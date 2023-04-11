Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  resources :contacts, only: %i[new create] do
    collection do
      get :thanks
    end
  end
end
