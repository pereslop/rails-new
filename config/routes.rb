Rails.application.routes.draw do
  root 'home#index'

  devise_for :users,
    controllers: {
      sessions: 'account/users/sessions'
    }

  namespace :admin do
    root 'users#index'

    resources :users, only: [:index, :edit, :update, :show, :delete, :destroy]
  end

  namespace :account do
    root 'posts#index'

    resources :users, only: [:index, :show]

    resources :posts do
      resources :comments, module: :posts
      member do
        get 'toggle_like', to: 'posts#toggle_like', as: :toggle_like
      end
    end
  end
end
