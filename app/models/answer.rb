class Answer < ApplicationRecord
  belongs_to :question
  # выбор правильных ответов
  scope :correct_answer, -> { where(correct: true) }

  validates :body, presence: true

end
