require 'sidekiq/web'

Rails.application.routes.draw do
  root 'pages#home'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, prefix: 'my', controllers: {
    sessions: 'users/sessions'
  }
  as :user do
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
  end

  resources :users

  get 'organization' => 'organizations#show'
  get 'organization/edit' => 'organizations#edit'
  put 'organization' => 'organizations#update'
  patch 'organization' => 'organizations#update'
  post 'organization/invite_member' => 'organizations#invite_member'


  resources :slack, only: [] do
    collection do
      get 'connect', to: 'slack#connect', as: 'connect'
    end
  end

  resources :projects do
    member do
      put 'restore'
    end
  end

  resources :estimations do
    member do
      put 'update_task'
      post 'create_task'
      delete 'destroy_task'
      patch 'done'
      get 'evaluate'
      patch 'toggle'
    end
  end

  resources :specifications do
    member do
      put 'update_feature'
      post 'create_feature'
      delete 'destroy_feature'
      patch 'send_for_sign_off'
      get 'sign_off_request/:client_auth' => 'specifications#sign_off_request', as: 'sign_off_request'
      patch 'sign_off'
      patch 'assign_estimators'
      patch 'finish'
    end
  end

  resources :specification_templates, only: %i[index show edit create update] do
    collection do
      post 'create_from_specification'
    end

    member do
      put 'update_feature'
      post 'create_feature'
      delete 'destroy_feature'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
