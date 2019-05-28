class Test < ApplicationRecord
  belongs_to :category
  # вывод объекта User автора теста test.creator
  # автор - это класс User, связь через внешний ключ creator_id
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  # scope методы заменяющие метод модели из предыдущего задания
  scope :category_by_title, -> (category) { Category.find_by(title: category) }
  scope :tests_by_category_desc, -> (category)  { where(category_id: category_by_title(category)).order(title: :desc) }
  scope :all_passed_tests_by_level, -> (level) { Test.where(level: level) }

  # Может существовать только один Тест с данным названием и уровнем
  validates :title, presence: true, uniqueness: { scope: [:title, :level] }
  # Уровень Теста может быть только положительным целым числом
  # использовал greater_than_or_equal_to вместо greater_than т.к. scope easy включает тесты от 0
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
