require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  mount Sidekiq::Web => '/sidekiq'

  get 'organization' => 'organizations#show'
  get 'organization/edit' => 'organizations#edit'
  put 'organization' => 'organizations#update'
  patch 'organization' => 'organizations#update'

  resources :projects do
    member do
      patch 'assign_estimators'
    end
  end

  resources :estimations do
    member do
      put 'update_task'
      post 'create_task'
      patch 'done'
    end
  end

  resources :estimation_reports

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
