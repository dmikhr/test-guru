class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true
  # при старте теста присвоить test_passage 1-ый вопрос из теста
  before_validation :before_validation_set_first_question, on: :create
  # при update - назначаем следующий вопрос
  before_validation :before_validation_next_question, on: :update

  SUCCESS_THRESHOLD = 85

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    #self.current_question = next_question
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
  def current_question_num
    total_questions_in_test - questions_left_num
  end

  # выводит визуальное представление продвижения по тесту
  def show_progress_bar
    '***' * (current_question_num - 1) + '___' * (questions_left_num + 1)
  end

  def correct_questions_percentage
    ((correct_questions / total_questions_in_test.to_f) * 100).round
  end

  private

  def questions_left_num
    # сколько вопросов осталось пройти
    test.questions.order(:id).where('id > ?', current_question.id).count
  end

  def before_validation_set_first_question
    # комментарий из скринкаста:
    # в приложении проверка if test.present? избыточна, т.к. belongs_to :test обеспечивает наличие хотя бы 1 теста
    # но такое условие удобно при отладке в консоли
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def before_validation_next_question
    self.current_question = next_question
  end
end
