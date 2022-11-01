Rails.application.routes.draw do
  namespace :api do
    resources :deliveries, only: :index
  end

  namespace :api do
    resources :payments, only: :index
  end

  namespace :api do
    resources :products, only: :update
  end


  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    
    root 'auction#index'
    devise_for :users
    resources :categories
    resources :products do 
      resources :prices
    end
    
    post "prices/create_index", to: "prices#create_index"
    delete "images/:id/purge", to: "images#purge", as: "purge_image"
  end
end
