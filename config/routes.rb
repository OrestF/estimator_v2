require 'sidekiq/web'

Rails.application.routes.draw do
  root 'pages#home'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  as :user do
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
  end

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
  end

  resources :estimations do
    member do
      put 'update_task'
      post 'create_task'
      delete 'destroy_task'
      patch 'done'
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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
