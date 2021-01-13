Rails.application.routes.draw do
  resources :questions do
    resources :answers, only: %w[new create], shallow: true
  end
end
