Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :organizations

    root to: "users#index"
  end

  scope module: :api do
    resources :activities
    resources :attenders
    resources :attendances
  end

  devise_for :users

  namespace :management do
    resources :activities, except: %i[destroy] do
      resources :leaders, only: %i[index create destroy]
      resources :attenders, only: %i[index show create destroy] do
        resources :attendances, only: %i[create edit update destroy]
      end
    end
  end

  namespace :attender do
    resources :activities, only: %i[index show] do
      resources :attendances, only: %i[create destroy]
    end
  end

  root "landing_page#show"
end
