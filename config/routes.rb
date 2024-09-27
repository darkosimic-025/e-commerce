Rails.application.routes.draw do
  get 'admin/dashboard', to: 'dashboard#index', as: 'admin_dashboard'
  get 'admin/dashboard/books', to: 'dashboard#books'
  get 'admin/dashboard/genres', to: 'dashboard#genres'
  get 'admin/dashboard/users', to: 'dashboard#users'
  get 'admin/dashboard/orders', to: 'dashboard#orders'
  get 'home/index'

  resources :books, except: [:index]
  resources :genres, except: [:index]

  resources :genres do
    member do
      get 'delete', to: 'genres#delete'
    end
  end

  resources :books do
    member do
      get 'delete', to: 'books#delete'
    end
  end

  resources :carts, only: [] do
    post 'add', on: :collection
    delete 'remove', on: :collection
    post 'update_quantity', on: :collection
    post 'stripe_checkout', on: :collection
  end

  resources :orders, only: [] do
    collection do
      get 'success', to: 'orders#success', as: 'success'
      get 'cancel', to: 'orders#cancel', as: 'cancel'
    end
  end

  get 'checkout', to: 'carts#checkout', as: 'checkout'


  devise_for :admins, path: 'admin', skip: [:registrations, :passwords]

  devise_for :users, path: '', skip: [:passwords]

  root "home#index"
end
