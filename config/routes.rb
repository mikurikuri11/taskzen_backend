Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todos, only: [:index, :create, :show, :destroy, :update] do
        collection do
          get 'todos_by_uid/:uid', action: 'todos_by_uid'
          get 'complete_todo/:uid', action: 'complete_todo'
          get 'incomplete_todo/:uid', action: 'incomplete_todo'
        end
      end
      resources :categories, only: [:create, :destroy, :update] do
        collection do
          get 'categories_by_uid/:uid', action: 'categories_by_uid'
          get 'categories_by_todo/:id', action: 'categories_by_todo'
        end
      end
    end
  end
  post 'auth/:provider/callback', to: 'api/v1/users#create'
end
