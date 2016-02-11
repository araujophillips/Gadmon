Rails.application.routes.draw do

  resources :orders do
    collection do
      get 'update_quantity'
    end
  end

  get 'orders/:id/update_quantity' => 'orders#update_quantity'

  get 'product_statuses/list'

  resources :customers do
    resources :shipping_addresses
  end

  resources :providers do
    resources :provider_types
  end

  resources :products do
    collection do
      get 'current_price'
    end
    resources :product_details do
      resources :product_statuses
    end
    resources :prices
  end

  get 'welcome/index'

  # NO BORRAR
  root :to => 'welcome#index'
end
