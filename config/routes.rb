Rails.application.routes.draw do
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
end
