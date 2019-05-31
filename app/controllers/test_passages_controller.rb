class TestPassagesController < ApplicationController
  # лучше перечислить экшены, для которых действует коллбэк
  # чтобы в случае добавления новых экшенов коллбэк не распространился на них
  before_action :set_test_passage, only: %i[show update result]

  # форма выбора ответов к текущему вопросу
  def show; end

  # результат прохождения теста
  def result; end

  # сохранение информации о прохождении вопроса
  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.completed?
      redirect_to result_test_passage_path(@test_passage)
    else
      # когда пользователь нажимает 'далее' - заново рендерим форму теста
      # с новым вопросом
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

end
