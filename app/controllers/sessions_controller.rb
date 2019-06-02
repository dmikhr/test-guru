# "установку флеша надо делать там, где происходит логин пользователя - подумай какой контроллер за это отвечает"

# здесь не уверен, что правильная реализация, но идея была следующая
# в прошлом уроке за логин отвечал контроллер SessionsController
# сейчас эту роль выполняет Devise, в нем за логин тоже отвечает одноименный контроллер
# https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb
# за логин отвечает метод create, там же Devise выводит собственные флеш сообщения после логина
# решение: переопределяем метод create, добавляя в конце наше flash сообщение

# как переопределить SessionsController в Devise
# https://stackoverflow.com/questions/13836139/rails-how-to-override-devise-sessionscontroller-to-perform-specific-tasks-when

class SessionsController < Devise::SessionsController
  def create
    super
    flash[:alert] = "Привет, #{current_user.full_name}!" unless current_user.admin?
  end
end
