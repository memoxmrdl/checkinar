Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :organizations

    root to: "users#index"
  end

  devise_for :users

  root "landing_page#show"
end
