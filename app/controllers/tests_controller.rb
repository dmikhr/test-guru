class TestsController < ApplicationController

  # обработка исключения для случая когда тест не был найден
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  # все тесты
  def index
    @tests = Test.all
    #titles = []
    #tests.each { |test| titles.push(test.title) }
    #render plain: titles.join("\n")
  end

  # Просмотр конкретного теста
  def show
    @test = Test.find(params[:id])
    @questions = Test.find(params[:id]).questions
    #render plain: "Тест: '#{Test.find(params[:id]).title}'"
  end

  # Вызов формы редактирования вопроса
  def edit
    # чтобы поля были заполнены
    @test = Test.find(params[:id])
  end

  # обработка PATCH запроса от формы редактирования вопроса
  # редактирование вопроса
  def update
    @test = Test.find(params[:id])
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
    @test = Test.find(params[:id])
    @test.destroy
    redirect_to tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :creator_id)
  end

  def rescue_with_test_not_found
    render plain: "Тест не найден"
  end
end
