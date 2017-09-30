Rails.application.routes.draw do
  root 'home#index'
  devise_for :users,
    controllers: {
        sessions: 'account/users/sessions'
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'home/index'
  #
  get 'show', to: 'home#show'

  namespace :admin do
    resources :users
    root 'users#index'
  end

  namespace :account do
    resources :users, only: [:show, :index]
    root 'posts#index'
    resources :posts, only: [:index, :create, :destroy, :show, :likes] do
      member do
        get 'toggle_like', to: 'posts#toggle_like', as: :toggle_like
      end
    end
  end
end
