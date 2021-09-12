Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    member do
      delete 'delete_file'
    end
    resources :answers, shallow: true do
      member do
        post 'best'
        delete 'delete_file'
      end
    end
  end

  get 'user', to: 'users#show'
end
