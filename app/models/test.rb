class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :passed_tests
  has_many :users, through: :passed_tests
  # вывод объекта User автора теста test.creator
  # автор - это класс User, связь через внешний ключ creator_id
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  # scope методы заменяющие метод модели из предыдущего задания
  scope :category_by_title, -> (category) { Category.find_by(title: category).id }
  scope :tests_by_category_desc, -> (category)  { where(category_id: category_by_title(category)).order(title: :desc).pluck(:title) }

  # Может существовать только один Тест с данным названием и уровнем
  validates :title, presence: true, uniqueness: { scope: [:title, :level] }
  # Уровень Теста может быть только положительным целым числом
  # использовал greater_than_or_equal_to вместо greater_than т.к. scope easy включает тесты от 0
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  #def self.tests_by_category_desc(category)
  #  category_id = Category.find_by(title: category).id
  #  Test.where(category_id: category_id).order(title: :desc).pluck(:title)
  #end
end
