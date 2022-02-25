Rails.application.routes.draw do
  post "auth_user" => "authentication#auth"

  resources :registrations, only: :create

  resources :projects

  resources :sprints, only: %i[index create]

  resources :tasks, only: %i[index create show update] do
    resources :user_votes, only: %i[index create]
  end
end
