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
    current_question.nil? || no_time_left?
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

  def no_time_left?
    (test.time_limit - (Time.now - self.created_at)).to_i <= 0
  end

  private

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    if new_record?
      test.questions.first
    else
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
  end

  def before_validation_set_current_question
    self.current_question = next_question
  end

end
