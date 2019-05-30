class SessionsController < ApplicationController

  # отображение формы логина
  def new
    # если пользователь залогинен и зашел на старинцу логина, перенаправить его на главную страницу
    redirect_to root_path if logged_in?
  end

  # создание пользовательской сессии (логин)
  def create
    user  = User.find_by(email: params[:email])
    # если user == nil, то user&.authenticate тоже будет nil
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      # отправляем пользователя после логина на страницу
      # куда он хотел попасть на основе данных из куки
      redirect_to cookies[:path]
    else
      # сообщение если пользователь не залогинен
      flash.now[:alert] = 'Войдите в систему'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

end
