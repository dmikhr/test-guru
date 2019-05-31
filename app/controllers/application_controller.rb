class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # перенаправление администраторов на страницу /admin/tests после логина
  # https://www.rubydoc.info/github/plataformatec/devise/Devise/Controllers/Helpers:after_sign_in_path_for
  def after_sign_in_path_for(user)
    # приветствуем пользователя после логина
    flash[:alert] = "Привет, #{user.first_name} #{user.last_name}!" unless user.first_name.nil? && user.last_name.nil?
    if user.is_a?(Admin)
      admin_tests_path
    else
      super
    end
  end

  # https://stackoverflow.com/questions/16471498/adding-extra-registration-fields-with-devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :password, :password_confirmation])
  end

end
