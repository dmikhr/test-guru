class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show]

  def index
    @users = User.all
  end

  def show
    @badges = @user.badges
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
