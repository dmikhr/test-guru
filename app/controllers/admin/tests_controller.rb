# TestsController доступный только для Admin
class Admin::TestsController < Admin::BaseController

  before_action :set_test, only: %i[show edit update destroy]

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
      redirect_to admin_tests_path
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
    # @test = Test.new(test_params)
    # создаем тест на от класса Test, а через ассоциацию из модели User
    # чтобы автоматически установилось авторство теста
    @test = current_user.tests_created.new(test_params)
    if @test.save
      redirect_to admin_test_path(@test), notice: t('.success')
    else
      render :new
    end
  end

  # удаление теста
  def destroy
    @test.destroy
    redirect_to admin_tests_path(@test)
  end

  private

  def test_params
    # params.require(:test).permit(:title, :level, :category_id, :creator_id)
    params.require(:test).permit(:title, :level, :category_id)
  end

  def set_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: "Тест не найден"
  end
end
