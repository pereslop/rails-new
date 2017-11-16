Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  namespace :admin do
    root 'users#index'

    resources :users, only: [:index, :edit, :update, :show, :delete, :destroy]
  end

  namespace :account do
    root 'posts#index'

    resources :users do
      resources :posts, module: :users, only: [:show, :destroy]
      member do
        get 'follow', to: 'users#follow', as: :follow
      end
    end

    resources :comments do
      resources :comments, module: :comments
    end

    resources :users, only: [:index, :show]

    resources :posts do
      resources :comments, module: :posts do
      end
      member do
        get 'toggle_like', to: 'posts#toggle_like', as: :toggle_like
      end
    end
  end
end
