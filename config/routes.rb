Rails.application.routes.draw do
  get 'admin/dashboard', to: 'dashboard#index', as: 'admin_dashboard'
  get 'admin/dashboard/books', to: 'dashboard#books'
  get 'admin/dashboard/genres', to: 'dashboard#genres'
  get 'home/index'

  resources :books, except: [:index]
  resources :genres, except: [:index]

  resources :genres do
    member do
      get 'delete', to: 'genres#delete'
    end
  end

  devise_for :admins, path: 'admin', skip: [:registrations, :passwords]

  devise_for :users, path: '', skip: [:passwords]

  root "home#index"
end
