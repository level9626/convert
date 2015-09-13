Rails.application.routes.draw do
  resources :converters do
    member do
      get :download
    end
  end

  root 'converters#index'
end
