module QuestionsHelper
  def question_header
    if !@question.body.present?
      "Создать новый вопрос"
    else
      "Редактировать вопрос '#{@question.body}'"
    end
  end

end
