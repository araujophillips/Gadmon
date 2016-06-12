Rails.application.routes.draw do

  resources :orders do
    collection do
      get 'update_quantity'
    end
  end
  get 'orders/:id/update_quantity' => 'orders#update_quantity'

  get 'customers/download', to: "customers#download"
  resources :customers do
    resources :shipping_addresses
  end

  get 'providers/download', to: "providers#download"
  resources :providers do
    resources :provider_types
  end

  get 'purchases/download', to: "purchases#download"
  resources :purchases do
    resources :purchases_details
  end

  get 'product_statuses/list'
  get 'products/download', to: "products#download"
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
