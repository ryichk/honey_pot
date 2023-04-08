Rails.application.routes.draw do
  root 'home#index'
  resources :contacts, only: %i[new create] do
    collection do
      get :thanks
    end
  end
end
