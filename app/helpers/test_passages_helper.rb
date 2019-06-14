module TestPassagesHelper

  def show_progress_bar
    progress_percentage = (@test_passage.current_question_num - 1) /
                           @test_passage.total_questions_in_test.to_f * 100
    content_tag :div, class: 'passage-progress', data: { progress_percentage: progress_percentage } do
      render partial: "progress_bar"
    end
  end

  def timer
    if @test_passage.test.time_limit > 0
      # сколько времени осталось
      time_left = (@test_passage.test.time_limit - (Time.now - @test_passage.created_at)).to_i
      content_tag :span, "-:-", class: 'time-left', data: { time_left: time_left }
    end
  end
end
