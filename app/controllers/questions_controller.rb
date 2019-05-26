class QuestionsController < ApplicationController
  # обратный вызов при поиске теста
  before_action :find_test
  # отключаем CSRF для экшена destroy, чтобы протестировать DELETE запрос через curl
  # например: curl -i -X DELETE http://localhost:3000/tests/4/questions/9
  # https://stackoverflow.com/questions/5669322/turn-off-csrf-token-in-rails-3
  # skip_before_action :verify_authenticity_token, :only => [:destroy]

  # обработка исключения для случая когда вопрос не был найден
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  # Просмотр списка вопросов теста
  def index
    questions = @test.questions
    bodies = []
    questions.each { |question| bodies.push(question.body) }
    render plain: "Все вопросы из теста '#{@test.title}':\n#{bodies.join("\n")}"
  end

  # Просмотр конкретного вопроса теста
  def show
    question_body = @test.questions.find(params[:id]).body
    render plain: "Вопрос из теста '#{@test.title}:'\n#{question_body}"
  end

  # Вызов формы редактирования вопроса
  def edit
    # чтобы поля были заполнены
    @question = Question.find(params[:id])
  end

  # обработка PATCH запроса от формы редактирования вопроса
  # редактирование вопроса
  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to url_for(@test)
    else
      render :edit
    end
  end

  # Вызов формы создания вопроса
  def new
    @question = Question.new
  end

  # обработка POST запроса от формы создания вопроса
  # создание вопроса
  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to url_for(@test)
    else
      render :new
    end
  end

  # удаление вопроса
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to url_for(@test)
  end

  private

  def question_params
    params.require(:question).permit(:body, :test_id)
  end

  def question_edit_params
    params.require(:question).permit(:body, :id, :test_id)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: "В тесте '#{@test.title}' такого вопроса не существует"
  end
end
