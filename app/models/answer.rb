class Answer < ApplicationRecord
  belongs_to :question
  # выбор правильных ответов
  scope :correct, -> { where(correct: true) }

  validates :body, presence: true
  validate :validate_answers_limit

  private

  def validate_answers_limit
    # если уже есть 4 вопроса, то answer не добавлять
    errors.add(:question) if question.answers.size >= 4
  end

end
