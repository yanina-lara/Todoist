Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :users, only: [:show] do
    resources :tasks, only: [:index]
    get '/tasks/:tag_id', to: 'tasks#show_tasks_tag', as: 'tasks_tag'
  end
  
end
