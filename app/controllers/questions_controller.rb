class QuestionsController < ApplicationController
  # обратный вызов при поиске теста
  before_action :set_test, only: %i[new create]
  before_action :set_question, only: %i[show edit update destroy]

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
  def show; end

  # Вызов формы редактирования вопроса
  def edit; end

  # обработка PATCH запроса от формы редактирования вопроса
  # редактирование вопроса
  def update
    if @question.update(question_params)
      redirect_to test_path(@question.test)
    else
      render :edit
    end
  end

  # Вызов формы создания вопроса
  def new
    @question = @test.questions.new
  end

  # обработка POST запроса от формы создания вопроса
  # создание вопроса
  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to test_path(@test)
    else
      render :new
    end
  end

  # удаление вопроса
  def destroy
    @question.destroy
    redirect_to test_path(@question.test)
  end

  private

  def question_params
    params.require(:question).permit(:body, :test_id)
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: "В тесте '#{@test.title}' такого вопроса не существует"
  end
end
