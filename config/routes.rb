Rails.application.routes.draw do
  get 'orders/index'
  root "products#index", as: 'store_index'

  resources :orders
  resources :products
end
