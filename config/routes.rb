Rails.application.routes.draw do
  get 'admins/new'

  devise_for :admins
  root 'home#index'

  namespace :admin do
    resources :rooms do
      resources :recorders
    end
  end

  resources :admins
end
