Rails.application.routes.draw do

  root to: 'tests#index'

  # ресурс Вопросов, вложенный в ресурс Тестов
  resources :tests do
    resources :questions
  end

end
