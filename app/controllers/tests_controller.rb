class TestsController < ApplicationController

  # authenticate_user! идет первый, т.к. коллбэки исполняются последовательно
  # и если пользователь не залогинен, остальные коллбэки запускать нет смысла (прим. из скринкаста)
  before_action :authenticate_user!
  before_action :set_test, only: %i[show edit update destroy start]

  # обработка исключения для случая когда тест не был найден
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  # все тесты
  def index
    @tests = Test.all
  end

  # Просмотр конкретного теста
  def show
    @questions = @test.questions
  end

  # Вызов формы редактирования вопроса
  def edit; end

  # обработка PATCH запроса от формы редактирования вопроса
  # редактирование вопроса
  def update
    if @test.update(test_params)
      redirect_to tests_path
    else
      render :edit
    end
  end

  # Вызов формы создания теста
  def new
    @test = Test.new
  end

  # обработка POST запроса от формы создания теста
  # создание теста
  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  # удаление теста
  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def start
    # объект текущего пользователя при старте прохождения теста
    current_user.tests.push(@test)
    # перенаправление на ресур прохождения теста
    redirect_to current_user.test_passage(@test)
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :creator_id)
  end

  def set_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: "Тест не найден"
  end
end
