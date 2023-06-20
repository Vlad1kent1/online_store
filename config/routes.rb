Rails.application.routes.draw do
  root "products#index"

  get "cart", to: "cart#show", as: 'cart'
  post "products/:id/buy", to: "cart#update", as: 'buy'
  post "products/:id/change_amount", to: "cart#update", as: 'change_amount'
  post "products/:id/cancel_delivery", to: "cart#update", as:'cancel_delivery'
  delete "clean_cart", to: "cart#delete", as: "clean_cart"

  resources :orders
  resources :products
end
