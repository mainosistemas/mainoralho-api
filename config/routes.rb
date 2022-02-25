Rails.application.routes.draw do
  post "auth_user" => "authentication#auth"

  resources :registrations, only: :create

  resources :projects

  resources :sprints

  resources :tasks, only: %i[index show create]
end
