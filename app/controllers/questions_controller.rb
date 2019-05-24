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

  end

  # обработка PATCH запроса от формы редактирования вопроса
  # редактирование вопроса
  def update
    question = Question.find(question_edit_params[:id])
    old_body = question.body
    question.body = question_edit_params[:body]
    question.save
    render plain: "Вопрос отредактирован\nИсходный вопрос:'#{old_body}'\nОтредактированный вопрос: '#{question.body}'"
  end

  # Вызов формы создания вопроса
  def new

  end

  # обработка POST запроса от формы создания вопроса
  # создание вопроса
  def create
    question = Question.create(question_create_params)
    #byebug
    #render plain: question.inspect
    render plain: "Вопрос создан: '#{question.body}'"
  end

  # удаление вопроса
  def destroy
    Question.find(params[:id]).destroy
    render plain: 'Вопрос удален'
  end

  private

  def question_create_params
    # изначально форма передает параметры в таком виде
    # Parameters: {"authenticity_token"=>"u7ogzGdwf7z7YF1bVdjKuZxjSh63hkKI664nZB2Ee4y5rfcSbSCU8O94odwC1rrFiJxMwXyaAapBioCBAy0TCQ==", "question"=>{"body"=>"wertyu"}, "Create"=>"Submit Query", "test_id"=>"2"}
    # насколько я понял params.require предназначен для ограничения вложенных параметров, при этом test_id вложенных параметров не имеет
    # соответственно перенес test_id во вложенный хеш questions через hidden поле в new.html.erb
    # теперь параметры выглядят так
    # Parameters: {"authenticity_token"=>"u7ogzGdwf7z7YF1bVdjKuZxjSh63hkKI664nZB2Ee4y5rfcSbSCU8O94odwC1rrFiJxMwXyaAapBioCBAy0TCQ==", "question"=>{"test_id"=>"2", "body"=>"wertyu"}, "Create"=>"Submit Query", "test_id"=>"2"}
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
