Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :organizations

    root to: "users#index"
  end

  devise_for :users

  scope module: :api, constraints: APIConstraint do
    resource :authenticate_users, only: %i[create]
    resources :activities, only: %i[index show]
    resources :participants, only: %i[index show]
    resources :attendances, only: %i[index create]
  end

  resources :activities do
    resources :participants, only: %i[create destroy]
    resources :confirm_attendances, only: %i[update]
  end
  resource :account, only: %i[edit update]

  root "landing_page#show"
end
