Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :organizations

    root to: "users#index"
  end

  scope module: :api, constraints: APIConstraint do
    resource :authenticate_users, only: %i[create]
    resources :activities, except: %i[destroy edit]
    resources :attenders
    resources :attendances, only: %i[create]
  end

  devise_for :users

  namespace :management do
    resources :activities, except: %i[destroy] do
      resources :leaders, only: %i[index create destroy]
      resources :attenders, only: %i[index show create destroy] do
        resources :attendances, only: %i[create edit update destroy]
      end
    end

    root "activities#index"
  end

  namespace :attender do
    resources :activities, only: %i[index show] do
      resources :attendances, only: %i[create destroy]
    end

    root "activities#index"
  end

  root "landing_page#show"
end
