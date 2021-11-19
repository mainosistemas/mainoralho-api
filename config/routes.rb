Rails.application.routes.draw do
  post 'auth_user' => 'authentication#auth'

  resources :registrations, only: :create

  resources :rooms

  resources :projects
end
