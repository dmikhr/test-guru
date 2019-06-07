class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy

  validates :body, presence: true

  # У одного вопроса может быть от 1-го до 4-х ответов
  # добавил условие on: :update
  # иначе при создании нового вопроса он не пройдет валидацию
  # т.к. у нового вопроса изначально 0 ответов
  validate :validate_answers_range, on: :update

  private

  def validate_answers_range
    errors.add(:answers) unless answers.size.between?(1, 4)
  end

end
