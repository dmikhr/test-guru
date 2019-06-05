module TestsHelper
  def test_header(create_test_text, edit_test_text)
    # если вместо .blank? использовать .nil?, то при попытке сохранить тест без названия
    # в title передается пустая строка (т.е. это уже не nil) и будет выведено сообщение о редактировании
    # хотя это форма создания теста
    if @test.title.blank?
      #"Создать новый тест"
      create_test_text
    else
      "#{edit_test_text} '#{@test.title}'"
    end
  end

  def create_new_question_link(anchor)
    link_to anchor, new_admin_test_question_path(@test, @question)
  end
end
