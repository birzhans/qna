Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true do
      member do
        post 'best'
      end
    end
  end

  resources :files, only: %w[destroy]
  resources :links, only: %w[destroy]
  resources :votes, only: %w[create destroy]
  resources :comments, only: %w[create]

  get 'user', to: 'users#show'
  get 'rewards', to: 'users#rewards'

  mount ActionCable.server => '/cable'
end
