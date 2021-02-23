Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  devise_for :users
  get 'search_stock', to: 'stocks#search'
  get 'update_stock', to: 'stocks#update'
  get 'search_friends', to: 'users#search'
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio' 
  get 'my_friends' , to: 'users#my_friends'
  get 'user_profile', to: 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
