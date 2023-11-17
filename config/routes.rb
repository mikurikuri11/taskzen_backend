Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todos, only: [:index, :create, :show, :destroy, :update] do
        collection do
          get 'todos_by_uid/:uid', action: 'todos_by_uid'
          get 'this_week_completion_rate/:uid', action: 'this_week_completion_rate'
        end
      end
      resources :categories, only: [:index, :create, :destroy, :update]
      resources :line_notifications, only: [:update_or_create] do
        collection do
          put 'update_or_create/:uid', action: 'update_or_create'
        end
      end
    end
  end
  post 'auth/:provider/callback', to: 'api/v1/users#create'
  post 'callback' => 'line_bot#callback'
end
