class Test < ApplicationRecord
  def self.tests_by_category_desc(category)
    category_id = Category.find_by(title: category).id
    Test.where(category_id: category_id).order(title: :desc).pluck(:title)
  end
end
