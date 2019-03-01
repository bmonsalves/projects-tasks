Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :v1 do
    namespace :projects do
      resources :create, only: :create
    end

    namespace :tasks do
      resources :create, only: :create
    end

  end
end
