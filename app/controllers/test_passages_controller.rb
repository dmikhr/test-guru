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
      badges = BadgeManagementService.new(@test_passage).call
      TestsMailer.completed_test(@test_passage).deliver_now
      if badges
        badges_achieved = badges.pluck(:name).join(', ')
        redirect_to result_test_passage_path(@test_passage), notice: "New badges achieved: #{badges_achieved}"
      else
        redirect_to result_test_passage_path(@test_passage)
      end
    else
      # когда пользователь нажимает 'далее' - заново рендерим форму теста
      # с новым вопросом
      render :show
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    service.call
    if service.success?
      # передаем объекты question и user вместо их id, т.к. есть ассоциации (аналогично seeds.rb)
      Gist.create(question: @test_passage.current_question, user: current_user, url:  service.gist_url)
      flash[:notice] = "#{t('.success')}: #{view_context.link_to(t('.view_gist'),  service.gist_url, target: "_blank")}"
    else
      flash[:alert] = t('.failure', gist_url:  service.gist_url)
    end
    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

end
