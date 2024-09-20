Rails.application.routes.draw do
  get 'dashboard/index'
  get 'home/index'

  devise_for :admins, path: 'admin'
  devise_for :users, path: ''

  root "home#index"
end
