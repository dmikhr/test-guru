class TestsController < ApplicationController

  # обработка исключения для случая когда тест не был найден
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found
  
  # все тесты
  def index
    tests = Test.all
    titles = []
    tests.each { |test| titles.push(test.title) }
    render plain: titles.join("\n")
  end

  # Просмотр конкретного теста
  def show
    render plain: "Тест: '#{Test.find(params[:id]).title}'"
  end

  private

  def rescue_with_test_not_found
    render plain: "Тест не найден"
  end
end
