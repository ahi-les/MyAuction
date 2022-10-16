Rails.application.routes.draw do
  namespace :api do
    resources :deliveries, only: :index
  end

  namespace :api do
    resources :payments, only: :index
  end


  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    
    root 'auction#index'
    devise_for :users
    resources :categories
    resources :products
    
  end
end
