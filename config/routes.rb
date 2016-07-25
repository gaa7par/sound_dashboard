Rails.application.routes.draw do
  devise_for :admins
  root 'home#index'

  namespace :admin do
    resources :rooms do
      resources :recorders
    end
  end
end
