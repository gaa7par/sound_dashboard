Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    resources :rooms do
      resources :recorders
    end
  end
end
