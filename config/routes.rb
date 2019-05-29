Rails.application.routes.draw do

  resources :answers
  root to: 'tests#index'

  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      # тк над ресурсом совершается действие выбираем метод POST
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end

  # ресурс Вопросов, вложенный в ресурс Тестов
  #resources :tests do
  #  resources :questions do
  #    resources :answers, shallow: true
  #  end
  #end
end
