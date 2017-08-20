Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      scope module: 'customers' do
        resources :customers, only: [:index, :show] do
          get '/invoices', to: 'find_invoices#show'
          get '/transactions', to: 'find_transactions#show'
          get '/favorite_merchant', to: 'favorite_merchant#show'
        end
      end

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/revenue', to: 'revenue#index'
      end
      scope module: 'merchants' do
        resources :merchants, only: [:index, :show] do
          get '/revenue', to: 'single_merchant_revenue#show'
          get '/items', to: 'find_items#show'
          get '/invoices', to: 'find_invoices#show'
          get '/favorite_customer', to: 'favorite_customer#show'
          get '/customers_with_pending_invoices', to: 'customer_pending_invoices#show'
        end
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      scope module: 'invoices' do
        resources :invoices, only: [:index, :show] do
          get '/transactions', to: 'find_transactions#show'
          get '/invoice_items', to: 'find_invoice_items#show'
          get '/items', to: 'find_items#show'
          get '/customer', to: 'find_customer#show'
          get '/merchant', to: 'find_merchant#show'
        end
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      scope module: 'transactions' do
        resources :transactions, only: [:index, :show] do
          get '/invoice', to: 'find_invoice#show'
        end
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'top_items#index'
        get '/most_items', to: 'most_items#index'
      end
      scope module: 'items' do
        resources :items, only: [:index, :show] do
          get '/invoice_items', to: 'find_invoice_items#show'
          get '/merchant', to: 'find_merchant#show'
          get '/best_day', to: 'best_day#show'
        end
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      scope module: 'invoice_items' do
        resources :invoice_items, only: [:index, :show] do
          get '/invoice', to: 'find_invoice#show'
          get '/item', to: 'find_item#show'
        end
      end
    end
  end
end
