module TestPassagesHelper

  def show_progress_bar(test_passage)
    content_tag :div, class: 'passage-progress', data: { progress_percentage: test_passage.progress_percentage } do
      render partial: "progress_bar"
    end
  end

  def timer(test_passage)
    if test_passage.test.time_limit > 0
      # сколько времени осталось
      time_left = (test_passage.test.time_limit - (Time.now - test_passage.created_at)).to_i
      content_tag :span, "-:-", class: 'time-left', data: { time_left: time_left }
    end
  end
end
