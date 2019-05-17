class User < ApplicationRecord
  has_many :passed_tests
  has_many :tests, through: :passed_tests
  # доступ к тестам, созданным пользователем через user.tests_created
  # тесты относятся к классу Test, связь через внешний ключ creator_id
  has_many :tests_created, class_name: 'Test', foreign_key: :creator_id

  def passed_tests_by_level(level)
    # за счет ассоциаций tests содержат только тесты данного пользователя
    # можно сократить код до
    tests.where(level: level).pluck(:title)
  end
end
