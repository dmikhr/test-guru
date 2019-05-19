class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :passed_tests
  has_many :users, through: :passed_tests
  # вывод объекта User автора теста test.creator
  # автор - это класс User, связь через внешний ключ creator_id
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  def self.tests_by_category_desc(category)
    category_id = Category.find_by(title: category).id
    Test.where(category_id: category_id).order(title: :desc).pluck(:title)
  end
end
