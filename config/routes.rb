Rails.application.routes.draw do
  namespace :account do
    get 'users/index'
  end

  namespace :account do
    get 'users/show'
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'home/index'
  #
  root 'home#index'
  get 'show', to: 'home#show'

  namespace :admin do
    resources :users
    root 'users#index'
  end

  namespace :account do
    resources :users, only: [:show, :index]
    root 'users#index'
    resources :posts, only: [:create, :destroy]
  end

end
