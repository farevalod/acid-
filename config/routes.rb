Rails.application.routes.draw do
  resources :categories, except: [:index]
  devise_for :users
  resources :carts, only: [:show, :buy]
  resources :users, only: [:edit, :update, :show]
  resources :products do
	  collection { post :import }
  end
  post '/products/:id/add', to: 'products#add'
  post '/carts/:id/buy', to: 'carts#buy'
  post '/products/:id/remove', to: 'products#remove'
  root to: "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
