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

  resources :activities do
    resources :participants, only: %i[create destroy]
    resources :confirm_attendances, only: %i[update]
  end
  resource :account, only: %i[edit update]

  root "landing_page#show"
end
