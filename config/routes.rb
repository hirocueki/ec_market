Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  root to: "posts#index"
  resources :items, only: %i[index show]

  namespace :admins do
    resources :items do
      member do
        post :up_position
        post :down_position
      end
    end
    resources :coupons
  end

  resource :cart, only: [:show]
  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  delete '/delete_item' => 'carts#delete_item'

  resources :orders, only: %i[index show new create]

  resources :posts, only: :index

  resources :users do
    get :profile, action: :profile, on: :collection
    resources :posts do
      resources :comments
      resources :goods, only: %i[create destroy]
    end
  end

  namespace :users do
    resources :coupons, only: %i[index new create]
    resources :points, only: %i[edit update]
  end


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/lo'
  end
end
