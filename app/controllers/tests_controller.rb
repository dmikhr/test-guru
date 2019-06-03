class TestsController < ApplicationController

  before_action :set_test, only: %i[start]

  # обработка исключения для случая когда тест не был найден
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  # все тесты
  def index
    @tests = Test.all
  end

  def start
    # объект текущего пользователя при старте прохождения теста
    current_user.tests.push(@test)
    # перенаправление на ресур прохождения теста
    redirect_to current_user.test_passage(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: "Тест не найден"
  end
end
