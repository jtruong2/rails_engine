Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :customers, only: [:index, :show] do
        get '/invoices', to: 'customer_invoices#show'
        get '/transactions', to: 'customer_transactions#show'
      end

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/revenue', to: 'revenue#index'
      end

      resources :merchants, only: [:index, :show] do
        get '/revenue', to: 'revenue#show'
        get '/items', to: 'merchant_items#show'
        get '/invoices', to: 'merchant_invoices#show'
      end


      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'invoice_transactions#show'
        get '/invoice_items', to: 'invoice_invoice_items#show'
        get '/items', to: 'inv_items#show'
        get '/customer', to: 'invoice_customer#show'
        get '/merchant', to: 'invoice_merchant#show'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show] do
        get '/invoice', to: 'transaction_invoice#show'
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :items, only: [:index, :show] do
        get '/invoice_items', to: 'item_invoice_items#show'
        get '/merchant', to: 'item_merchant#show'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: 'invoice_items_invoice#show'
        get '/item', to: 'invoice_item#show'
      end
    end
  end
end
