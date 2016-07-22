Rails.application.routes.draw do
  namespace :admin do
    resources :rooms do
      resources :recorders
    end
  end
end
