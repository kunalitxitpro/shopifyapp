Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  resources :product_settings, only: [:update, :edit]
  resources :test_admins
  resources :test_proxies

  namespace :app_proxy do
    root action: 'index'
    get 'index', to: 'index'
  end

  get '/apps/products', as: :proxy_prod
  get '/app_proxy/index/:id', as: :collect_prod, to: 'app_proxy#index'

  get 'all_products', to: 'home#products', as: :all_products
  get '/products/sync', to: 'product_settings#sync', as: :sync_products

  get '/example', to: 'test_admins#example', as: :example

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
