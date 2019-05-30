class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # дает доступ к current_user в шаблонах
  helper_method :current_user, :logged_in?

  private

  # проверка залогинен ли пользователь
  def authenticate_user!
    # если пользователь не залогинен - вместо доступа к ресурсам TestGuru перенаправить на форму логина
    unless current_user
      # если пользователь не залогинен сохраняем в куку путь, куда он хотел попасть
      # и отправляем на страницу логина
      cookies[:path] = request.original_url
      redirect_to login_path, alert: 'Войдите в аккаунт для доступа к TestGuru'
    end
  end

  # объект ApplicationController создается при каждом запросе
  # при обращениях к current_user будут идти новые запросы в БД
  # хотя в этом нет необходимости - решение: кэширование результата запроса
  # в инстанс-переменной через условное присваивание (прим. из скринкаста)
  def current_user
    # без if session[:user_id] будет идти запрос к БД даже если пользователь не залогинен
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
