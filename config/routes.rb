Rails.application.routes.draw do
  root to: "chats#show"
  get 'chats/show'
  post "auth_user" => "authentication#auth"
  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'

  resources :registrations, only: :create

  resources :projects

  resources :sprints, only: %i[index create show] do
    resources :tasks, only: :index
  end

  resources :tasks, only: %i[create show update destroy] do
    resources :user_votes, only: %i[index create]
  end

  mount ActionCable.server => '/cable'
end
