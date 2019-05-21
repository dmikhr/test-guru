class Question < ApplicationRecord
  belongs_to :test
  has_many :answers

  validates :body, presence: true

  # У одного вопроса может быть от 1-го до 4-х ответов
  validate :validate_answers_range

  private

  def validate_answers_range
    errors.add(:answers) unless answers.size.between?(1, 4)
  end

end
