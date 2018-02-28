Rails.application.routes.draw do
  root 'static_pages#home'
  resources :subscribers, only: [:create]
  resources :contacts, only: [:create]
end
