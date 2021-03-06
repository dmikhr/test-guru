class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options
    # URL параметр языка не добавляется когда установленная локаль такая же как локаль по умолчанию
    { lang: (I18n.locale unless I18n.locale == I18n.default_locale) }
  end

  # перенаправление администраторов на страницу /admin/tests после логина
  # https://www.rubydoc.info/github/plataformatec/devise/Devise/Controllers/Helpers:after_sign_in_path_for
  def after_sign_in_path_for(user)
    if user.admin?
      admin_tests_path
    else
      super
    end
  end

  # https://stackoverflow.com/questions/16471498/adding-extra-registration-fields-with-devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :password, :password_confirmation])
  end

  private

  def set_locale
    # locale_available? - возвращает локаль, если она доступна
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end

end
