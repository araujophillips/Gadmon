Rails.application.routes.draw do

  resources :orders do
    collection do
      get 'update_quantity'
    end
  end

  get 'product_statuses/list'

  resources :customers do
    resources :shipping_addresses
  end

  resources :products do
    resources :product_details do
      resources :product_statuses
    end
    resources :prices
  end

  get 'welcome/index'

  # NO BORRAR
  root :to => 'welcome#index'
end
