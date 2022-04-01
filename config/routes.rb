Rails.application.routes.draw do
  post "auth_user" => "authentication#auth"
  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'

  resources :registrations, only: :create

  resources :projects

  resources :sprints, only: %i[index create show]

  resources :tasks, only: %i[index create show update] do
    resources :user_votes, only: %i[index create]
  end
end
