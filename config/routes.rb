Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, only: %w[create destroy update], shallow: true
  end

  get 'user', to: 'users#show'
end
