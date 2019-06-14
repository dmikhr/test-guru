class ContactsController < ApplicationController
  # сделать форму обратной связи доступной также для неавторизованных пользователей
  skip_before_action :authenticate_user!
  # форма обратной связи
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.send_to_admin(contact_params).deliver_now
      manage_redirect
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

  def manage_redirect
    # если сообщение отправлено от авторизованного пользователя - то редирект на главную страницу с флеш сообщением
    if current_user
      redirect_to root_path, notice: t('.success')
    else
      # если гость, то редиректим на страницу логина и показываем флеш сообщение там
      redirect_to new_user_session_path, notice: t('.success')
    end
  end

end
