Rails.application.routes.draw do

  root to: 'tests#index'

  devise_for :users, controllers: {sessions: "sessions"}, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  resources :tests, only: :index do
    member do
      # тк над ресурсом совершается действие выбираем метод POST
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  # все экшены в блоке namespace будут доступны только admin
  namespace :admin do
    resources :tests do
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    # нужен только route для вывода списка gists - index
    resources :gists, only: :index
  end

end
