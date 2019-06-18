class BadgeRule < ApplicationRecord
  belongs_to :badge
  belongs_to :test, optional: true
  belongs_to :category, optional: true

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true

  validate :enough_options_set
  validate :test_or_category

  private

  # проверка, что правило не пустое
  def enough_options_set
    if category.blank? && test.blank? && level.blank?
      errors.add(:badge_rule, "Set at least one option: category, test, level")
    end
  end

  # задается либо тест либо категория, но не оба параметра сразу
  def test_or_category
    # byebug
    if category.present? && test.present?
      errors.add(:badge_rule, "Choose category or test")
    end
  end
end
