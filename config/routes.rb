Finalproject::Application.routes.draw do

  root  'static_pages#home'

  match 'cart_items/empty', to: 'cart_items#empty_cart', via: 'delete'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :products, only: [:index, :show]
  resources :books, only: [:index, :show]
  resources :songs, only: [:index, :show]
  resources :cart_items
  resources :orders, only: [:new, :index, :create, :show]
  resources :vendors, only: [:index, :show]

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/home',    to: 'static_pages#home',    via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

end
