module TestsHelper
  def test_header
    if @test.title.nil?
      "Создать новый тест"
    else
      "Редактировать тест '#{@test.title}'"
    end
  end

  def create_new_question_link
    link_to 'Создать новый вопрос', new_admin_test_question_path(@test, @question)
  end
end
