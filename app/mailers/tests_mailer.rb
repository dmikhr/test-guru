class TestsMailer < ApplicationMailer

  def completed_test(test_passage)
    @user = test_passage.user
    @test = test_passage.test

    mail to: @user.email
  end

  # тестирование отправки сообщений в dev среде
  # TestsMailer.test_email(email).deliver_now
  def test_email(email)
    mail to: email
  end
end
