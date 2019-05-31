class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    if logged_in?
      redirect_to root_path
    else
      @user  = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # добавляем в сессию идентификатор пользователя после его регистрации
      session[:user_id] = @user.id
      redirect_to tests_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
