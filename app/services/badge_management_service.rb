# изначально этот код был в модели BadgeRule
# перенес в сервис, т.к. BadgeRule отвечает за хранение правил, а принимать решение о выдаче бейджа лучше вынести в отдельную сущность
# для этого создан сервис по аналогии с Gist сервисом из 14 урока
class BadgeManagementService

  RULES = %w(category test test_first level)

  def initialize(test_passage)
    #byebug
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
    @test_passages = @user.test_passages
  end

  def call
    # "all можно опустить" - без all метод filter выдает ошибку - undefined method, но без all вызвается select - использую его
    Badge.select{ |badge| eligible_for_badge?(badge) }
  end

  private

  # ТЗ: "Пользователь может получать один и тот же бэйдж более одного раза"
  # если бейдж уже есть, то рассматриваем test_passages после timestamp, когда был получен этот бейдж в прошлый раз
  # в таком случае бейдж можно получить еще раз, но для этого нужно выполнить правила бейджа еще раз
  def relevant_passages(badge)
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
    @test_passages = relevant_passages(badge)
    # выделяем методы, отвечающие за бейджи префиксом rule_, чтобы отличить от других методов
    method("rule_#{badge.rule}".to_sym).call if RULES.include?(badge.rule) && relevant_badge?(badge)
  end

  # relevant_badge? думаю стоит сохранить - по нему решается, нужно ли запускать проверку на выдачу бейджа
  # не стоит запускать проверку, если бейдж для данного теста не предназначен
  def relevant_badge?(badge)
    (badge.rule == 'category' && badge.value == @test.category_id) ||
    (badge.rule == 'test' && badge.value == @test.id) ||
    (badge.rule == 'level' && badge.value == @test.level)
  end

  # должны быть пройдены все тесты из заданной категории
  def rule_category
    # все тесы текущей категории
    category_tests = Test.tests_by_category_id(@test.category_id)
    # получаем список пройденных пользователем тестов, фильтруем по категории и успешному прохождению
    passed_tests = @test_passages.joins(:test).where("tests.category_id": @test.category_id).where(passed: true)
    # все ли пройдены?
    category_tests.pluck(:id).sort == passed_tests.pluck(:test_id).uniq.sort
  end

  # пройдены тесты определенного уровня
  def rule_level
    # все тесы заданного уровня
    level_tests = Test.tests_by_level(@test.level)
    # пройденные тесты заданного уровня
    passed_tests = @test_passages.joins(:test).where("tests.level": @test.level).where(passed: true)
    # все ли тесты данного уровня пройдены
    level_tests.pluck(:id).sort == passed_tests.pluck(:test_id).uniq.sort
  end

  # должен быть успешно пройден тест (не обязательно с 1 попытки)
  def rule_test(id = @test.id)
    @test_passages.where(test_id: @test.id).where(passed: true).count >= 1
  end

  # тест должен быть успешно пройден с 1 попытки (первая попытка должна быть passed == true)
  def rule_test_first(id = @test.id)
    first_passed_test = @test_passages.where(test_id: @test.id).order(:created_at).first
    first_passed_test.passed if !first_passed_test.nil?
  end
end
