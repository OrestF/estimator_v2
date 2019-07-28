require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  mount Sidekiq::Web => '/sidekiq'

  get 'organization' => 'organizations#show'
  get 'organization/edit' => 'organizations#edit'
  put 'organization' => 'organizations#update'
  patch 'organization' => 'organizations#update'
  resources :projects

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
