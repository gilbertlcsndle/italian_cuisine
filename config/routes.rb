Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'
  resources :contacts, only: [:create]
  resources :reservations, only: [:create]
end
