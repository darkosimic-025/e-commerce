Rails.application.routes.draw do
  get 'admin/dashboard', to: 'dashboard#index', as: 'admin_dashboard'
  get 'admin/dashboard/users', to: 'dashboard#users'
  get 'admin/dashboard/orders', to: 'dashboard#orders'
  get 'home/index'

  devise_for :admins, path: 'admin', skip: [:registrations, :passwords]

  devise_for :users, path: '', skip: [:passwords]

  root "home#index"
end
