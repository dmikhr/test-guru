# TestsController доступный только для Admin
class Admin::TestsController < Admin::BaseController
  before_action :set_tests, only: %i[index update_inline]
  before_action :set_test, only: %i[show edit update destroy update_inline]

  # обработка исключения для случая когда тест не был найден
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  # все тесты
  def index; end

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

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  # Вызов формы создания теста
  def new
    @test = Test.new
  end

  # обработка POST запроса от формы создания теста
  # создание теста
  def create
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

  def set_tests
    @tests = Test.all
  end

  def test_params
    main_params = params.require(:test).permit(:title, :level, :category_id)
    time_params = params.require(:date).permit(:minute, :second)
    # переводим минуты и секунды из формы в секунды
    # в бд время хранится в секундах, чтобы не было привязки данных к интерфейсу
    # в интерфейсе возможно потребуется добавить поле часы или оставить только секунды, при этом схему бд менять будет не нужно
    main_params[:time_limit] = set_time_in_sec(time_params)
    main_params
  end

  def set_test
    @test = Test.find(params[:id])
  end

  def set_time_in_sec(time_params)
    time_params[:minute].to_i * 60 + time_params[:second].to_i
  end

  def rescue_with_test_not_found
    render plain: "Тест не найден"
  end
end
