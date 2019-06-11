module TestPassagesHelper
  def show_progress_bar
    progress_percentage = (@test_passage.current_question_num - 1) /
                           @test_passage.total_questions_in_test.to_f * 100
    content_tag :div, class: 'passage-progress', data: { progress_percentage: progress_percentage } do
      render partial: "progress_bar"
    end
  end
end
