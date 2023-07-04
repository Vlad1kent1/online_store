Rails.application.routes.draw do
  root "products#index"

  resources :cart

  resources :products do
    member do
      resource :cart, only: [:update] do
        [:add, :remove, :update].each do |action|
          patch action, to: "cart#update", as: "#{action}_products_to", defaults: { action_type: action.to_s }
        end
      end
    end
  end

  resources :orders
end
