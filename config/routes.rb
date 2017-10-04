Rails.application.routes.draw do
  root 'home#index'

  devise_for :users,
    controllers: {
      sessions: 'account/users/sessions'
    }

  namespace :admin do
    root 'users#index'

    resources :users, only: [:index, :edit, :show, :delete]
  end

  namespace :account do
    root 'posts#index'

    resources :users, only: [:index, :show]
    resources :posts, only: [:index, :create, :destroy, :show, :likes] do
      member do
        get 'toggle_like', to: 'posts#toggle_like', as: :toggle_like
      end
    end
  end
end
