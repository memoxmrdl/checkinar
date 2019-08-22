Rails.application.routes.draw do
  devise_for :users
  root 'landing_page#show'
end
