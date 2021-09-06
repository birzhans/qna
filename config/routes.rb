Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true

    member do
      post 'best_answer'
    end
  end

  get 'user', to: 'users#show'
end
