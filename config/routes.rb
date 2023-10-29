Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todos, only: [:index, :create, :show, :destroy, :update]
      resources :categories, only: [:index, :create, :destroy, :update]
      resources :hello, only: [:index]
    end
  end
  post 'auth/:provider/callback', to: 'api/v1/users#create'
end
