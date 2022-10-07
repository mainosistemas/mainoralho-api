Rails.application.routes.draw do
  root to: "chats#show"
  get 'chats/show'
  post "auth_user" => "authentication#auth"
  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'

  post 'projects/listar', to: 'projects#index'
  post 'sprints/listar', to: 'sprints#index'
  post 'sprints/show', to: 'sprints#show'
  post 'tasks/listar', to: 'tasks#index'
  post 'tasks/destroy', to: 'tasks#destroy'
  resources :registrations, only: :create

  resources :projects
  resources :tasks, only: :destroy

  resources :sprints, only: %i[index create show] do
    resources :tasks, only: :index
  end

  resources :tasks, only: %i[create show update destroy] do
    resources :user_votes, only: %i[index create]
  end

  mount ActionCable.server => '/cable'
end
