Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :users, only: [:index]
      # resources :users, only: :show, param: :uid
      resources :todos, only: [:index, :create, :show, :destroy, :update] do
        collection do
          get 'todos_by_uid/:uid', action: 'todos_by_uid'
          get 'this_week_completion_rate/:uid', action: 'this_week_completion_rate'
        end
      end
      resources :categories, only: [:index, :create, :destroy, :update]
      resources :hello, only: [:index]
    end
  end
  post 'auth/:provider/callback', to: 'api/v1/users#create'
end
