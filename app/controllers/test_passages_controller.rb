class TestPassagesController < ApplicationController
  # лучше перечислить экшены, для которых действует коллбэк
  # чтобы в случае добавления новых экшенов коллбэк не распространился на них
  before_action :set_test_passage, only: %i[show update result gist]

  # форма выбора ответов к текущему вопросу
  def show; end

  # результат прохождения теста
  def result; end

  # сохранение информации о прохождении вопроса
  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      # когда пользователь нажимает 'далее' - заново рендерим форму теста
      # с новым вопросом
      render :show
    end
  end

  def gist
    @result = GistQuestionService.new(@test_passage.current_question).call
    flash_options = if gist_success?
      # передаем объекты question и user вместо их id, т.к. есть ассоциации (аналогично seeds.rb)
      Gist.create(question: @test_passage.current_question, user: current_user, url: @result[:html_url])
      { notice: t('.success', gist_url: @result[:html_url]) }
    else
      { alert: t('.failure') }
    end
    redirect_to @test_passage, flash_options
  end

  private

  def gist_success?
    @result[:html_url].present? && @result[:html_url].include?('https://gist.github.com/')
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

end
