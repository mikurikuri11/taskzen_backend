module Api::V1::Concerns
  module TodosResponse
    extend ActiveSupport::Concern

    def render_user_not_found
      render_error("指定されたUIDのユーザーが見つかりません", :not_found)
    end

    def render_todo_with_categories(todo, category_ids)
      category_list = { todo_id: todo.id, categories: category_ids.chars }
      render json: category_list
    end

    def render_error(message, status)
      render json: { error: message }, status: status
    end
  end
end
