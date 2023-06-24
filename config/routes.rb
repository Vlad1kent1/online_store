Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index, :show, :new, :edit, :update, :delete] do
    member do
      post :buy, to: "cart#update", as: "buy"
      post :change_amount, to: "cart#update", as: "change_amount"
      post :cancel_delivery, to: "cart#update", as: "cancel_delivery"
    end
  end

  get "cart", to: "cart#show", as: 'cart'
  delete "clean_cart", to: "cart#destroy", as: "clean_cart"

  resources :orders
  resources :products
end
