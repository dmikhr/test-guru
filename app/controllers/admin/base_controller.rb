class Admin::BaseController < ApplicationController

  layout 'admin'

  before_action :admin_required!

  private

  def admin_required!
    redirect_to root_path, alert: 'У вас нет прав на просмотр этой страницы' unless current_user.admin?
  end
end
