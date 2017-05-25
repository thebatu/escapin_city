Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  # resources :participations, only: [:create], shallow: true
  resources :hunts, only: [:index, :show], shallow: true  do
    member do
      get :play
      post :check
    end
    resources :checkpoints, only: [] do
      member do
        post :check
        get :next
      end
    end
  end
end
