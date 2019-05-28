class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question

  SUCCESS_THRESHOLD = 85

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def passed?
    correct_questions_percentage >= SUCCESS_THRESHOLD
  end

  # всего вопросов в тесте
  def total_questions_in_test
    test.questions.count
  end

  # выводит номер текущего вопроса
  # считаем кол-во вопросов уже пройденных включая текущий вопрос
  # это и будет номер вопроса в тесте
  def current_question_num
    test.questions.order(:id).where('id <= ?', current_question.id).count
  end

  def correct_questions_percentage
    ((correct_questions / total_questions_in_test.to_f) * 100).round
  end

  private

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort if !answer_ids.nil?
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    id = current_question.nil? ? 0 : current_question.id
    test.questions.order(:id).where('id > ?', id).first
  end

  def before_validation_set_current_question
    self.current_question = next_question
  end
end
