Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    member do
      post 'upvote'
    end
    resources :answers, shallow: true do
      member do
        post 'best'
      end
    end
  end

  resources :files, only: %w[destroy]
  resources :links, only: %w[destroy]
  get 'user', to: 'users#show'
  get 'rewards', to: 'users#rewards'
end
