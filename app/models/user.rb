class User < ApplicationRecord
  # возвращает список всех Тестов, которые проходит или когда-либо
  # проходил Пользователь на этом уровне сложности
  def taken_tests_by_level(level)
    # список test_id которые проходил пользователь
    test_ids = Takentest.where(user_id: self.id).pluck(:test_id)
    # получаем тесты по списку test_id
    tests = Test.where(id: test_ids)
    # выбираем тесты с заданным level
    tests.where(level: level).pluck(:title)
  end
end
