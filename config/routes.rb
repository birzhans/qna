Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, only: %w[new create], shallow: true
  end

  get 'user', to: 'users#show'
end
