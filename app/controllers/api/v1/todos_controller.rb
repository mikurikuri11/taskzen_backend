class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: %i[show update destroy]

  # def todos_by_user
  #   user_id = params[:user_id]
  #   @todos = Todo.where(user_id: user_id)

  #   if @todos.any?
  #     render json: @todos
  #   else
  #     render json: { error: "指定されたユーザーのToDoが見つかりません" }, status: :not_found
  #   end
  # end

  def todos_by_uid
    uid = params[:uid]
    user = User.find_by(uid: uid)

    if user.present?
      @todos = Todo.where(user_id: user.id)
      render json: @todos
    else
      render json: { error: "指定されたUIDのユーザーが見つかりません" }, status: :not_found
    end
  end

  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
    render json: @todo
  end

  # def create
  #   @todo = Todo.new(todo_params)
  #   categories = params[:category_ids].split(" ")
  #   if @todo.save
  #     categories.each do |category|
  #       TodoCategory.create(todo_id: @todo.id, category_id: category)
  #     end
  #     category_list = {
  #       todo_id: @todo.id,
  #       categories:
  #     }
  #     render json: category_list
  #   else
  #     render json: { error: "保存に失敗しました" }, status: :unprocessable_entity
  #   end
  # end

  # def create
  #   @todo = Todo.new(todo_params)
  #   categories = params[:category_ids]&.split(" ") # category_idsが存在しない場合にnilを返す

  #   if @todo.save
  #     if categories.present?
  #       categories.each do |category|
  #         TodoCategory.create(todo_id: @todo.id, category_id: category)
  #       end
  #     end

  #     category_list = {
  #       todo_id: @todo.id,
  #       categories: categories || [] # categoriesが存在しない場合は空の配列を返す
  #     }
  #     render json: category_list
  #   else
  #     render json: { error: "保存に失敗しました" }, status: :unprocessable_entity
  #   end
  # end

  def create
    # Find the user by uid from the request body
    uid = params[:uid]
    user = User.find_by(uid: uid)

    if user.present?
      # Create a new todo and associate it with the user
      @todo = Todo.new(todo_params)
      @todo.user = user # Associate the todo with the user
      categories = params[:category_ids]&.split(" ")

      if @todo.save
        if categories.present?
          categories.each do |category|
            TodoCategory.create(todo_id: @todo.id, category_id: category)
          end
        end

        category_list = {
          todo_id: @todo.id,
          categories: categories || [] # categories that are nil will be an empty array
        }
        render json: category_list
      else
        render json: { error: "保存に失敗しました" }, status: :unprocessable_entity
      end
    else
      render json: { error: "指定されたUIDのユーザーが見つかりません" }, status: :not_found
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: { error: "更新に失敗しました" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @todo.destroy
      head :ok
    else
      render json: { error: "削除に失敗しました" }, status: :unprocessable_entity
    end
  end

  private

  def set_todo
    @todo = Todo.find_by(id: params[:id])
  end

  def todo_params
    params.require(:todo).permit(:user_id, :title, :description, :due_date, :completed, :zone, category_ids: [])
  end
end
