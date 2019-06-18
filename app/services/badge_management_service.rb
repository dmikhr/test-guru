# изначально этот код был в модели BadgeRule
# перенес в сервис, т.к. BadgeRule отвечает за хранение правил, а принимать решение о выдаче бейджа лучше вынести в отдельную сущность
# для этого создан сервис по аналогии с Gist сервисом из 14 урока
class BadgeManagementService

  def initialize(test_passage)
    #byebug
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
    @test_passages = @user.test_passages
  end

  def call
    badges = Badge.all.filter{ |badge| eligible_for_badge?(badge) }
    @user.badges << badges if badges
    badges
  end

  private

  # ТЗ: "Пользователь может получать один и тот же бэйдж более одного раза"
  # если бейдж уже есть, то рассматриваем test_passages после timestamp, когда был получен этот бейдж в прошлый раз
  # в таком случае бейдж можно получить еще раз, но для этого нужно выполнить правила бейджа еще раз
  def previous_badges(badge)
    # byebug
    # был ли этот бейдж уже у пользователя?
    # через scope в UserBadge находим последний раз, когда пользователь получал этот же бейдж
    prevous_badge = UserBadge.badges_for_user(@user, badge).last
    # если найден, далее работаем с записями в test_passages после получения данного бейджа
    if prevous_badge
      @test_passages.where(created_at: prevous_badge.created_at.utc..Time.current.utc)
    else
      # иначе возвращаем весь test_passages
      @test_passages
    end
  end

  def eligible_for_badge?(badge)
    @test_passages = previous_badges(badge)
    @badge_rules = badge.badge_rules.first
    select_rule if relevant_badge?
  end

  # выполняются ли условия для получения бейджа?
  # можно выбирать одну из 4 опций - выдача бейджа за прохождение теста, за прохождение теста c 1 раза, за прохождение тестов категории или тестов определенного уровня
  def select_rule
    #byebug
    if @badge_rules.test && @badge_rules.first_attempt
      rule_passed_test_first_attempt
    elsif @badge_rules.test
      @test_passage.passed
    elsif @badge_rules.category
      rule_passed_by_category
    elsif @badge_rules.level
      rule_passed_by_level
    end
  end

  # бейдж релевантен текущему тесту?
  def relevant_badge?
    @badge_rules.test_id == @test.id || @badge_rules.category_id == @test.category_id || @badge_rules.level == @test.level
  end

  # должны быть пройдены все тесты из заданной категории
  def rule_passed_by_category
    # все тесы текущей категории
    category_tests = Test.tests_by_category_id(@test.category_id)
    # возвращает тесты данной категории, которые пройдены пользователем
    passed_tests = category_tests.filter{ |test| rule_passed_test(test.id) }
    # все ли пройдены? Возваращем набор тестов для проверки на следующие критерии
    category_tests.pluck(:id).sort == passed_tests.pluck(:id).uniq.sort
  end

  # пройдены тесты определенного уровня
  def rule_passed_by_level
    # все тесы заданного уровня
    level_tests = Test.tests_by_level(@badge_rules.level)
    # пройденные тесты заданного уровня
    passed_tests = level_tests.filter{ |test| rule_passed_test(test.id) }
    # все ли тесты данного уровня пройдены
    level_tests.pluck(:id).sort == passed_tests.pluck(:id).uniq.sort
  end

  # должен быть успешно пройден тест (не обязательно с 1 попытки)
  def rule_passed_test(id = @test.id)
    find_test_attempts(id).filter{ |test_passage| test_passage.passed }.count >= 1
  end

  # тест должен быть успешно пройден с 1 попытки (первая попытка должна быть passed == true)
  def rule_passed_test_first_attempt(id = @test.id)
    res = find_test_attempts(id).order(:created_at).first
    res.passed if !res.nil?
  end

  # все попытки пройти данный тест
  def find_test_attempts(id)
    @test_passages.where(test_id: id)
  end
end
