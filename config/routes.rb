Rails.application.routes.draw do
  resources :orders, only: %i[index show create update] do
    resources :line_items
    resource :status_transactions, only: %i[show create]
  end
  resources :products
end
