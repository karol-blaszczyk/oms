Rails.application.routes.draw do
  resources :orders, only: [:index, :show, :create, :update] do
    namespace :orders do
      resources :line_items
      resource :status_transactions, only: [:show, :create]
    end
  end
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
