Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todos, only: [:index, :create, :show, :destroy, :update] do
        collection do
          get 'todos_by_uid/:uid', action: 'todos_by_uid'
          get 'this_week_completion_rate/:uid', action: 'this_week_completion_rate'
        end
      end
      resources :categories, only: [:destroy, :update] do
        collection do
          get 'categories_by_uid/:uid', action: 'categories_by_uid'
          post 'create_by_uid/:uid', action: 'create_by_uid'
        end
      end
      resources :line_notifications, only: [:update_or_create] do
        collection do
          put 'update_or_create/:uid', action: 'update_or_create'
        end
      end
    end
  end
  post 'auth/:provider/callback', to: 'api/v1/users#create'
end
