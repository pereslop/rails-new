Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks#all' }

  namespace :admin do
    root 'users#index'

    resources :users, only: [:index, :edit, :update, :show, :delete, :destroy] do
      member do
        get 'statistic', to: 'users#statistic', as: :statistic
      end
    end
  end

  namespace :account do
    root 'posts#index'

    resources :conversations do
      member do
        get 'chat', to: 'conversations#chat', as: :chat
        get 'recipient', to: 'conversations#recipient', as: :recipient
      end
      resources :message_bodies, module: :conversations, only: [:create]
    end

    resources :users do
      resources :posts, module: :users, only: [:show, :destroy]
      member do
        get 'follow', to: 'users#follow', as: :follow
        get 'unfollow', to: 'users#unfollow', as: :unfollow
        get 'followers', to: 'users#followers', as: :followers
        get 'followees', to: 'users#followees', as: :followees
      end
      collection { post :index, to: 'users#index' }
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
