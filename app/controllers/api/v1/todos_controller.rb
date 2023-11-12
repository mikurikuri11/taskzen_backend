class Api::V1::TodosController < ApplicationController
  before_action :set_user, only: [:todos_by_uid, :this_week_completion_rate, :create]
  before_action :set_todo, only: [:show, :update, :destroy]

  def todos_by_uid
    render_user_not_found and return unless @user.present?

    @todos = @user.todos
    render json: @todos
  end

  def this_week_completion_rate
    render_user_not_found and return unless @user.present?

    this_week_todos = @user.todos.where(due_date: Date.today.beginning_of_week..Date.today.end_of_week)

    total_this_week = this_week_todos.count
    completed_this_week = this_week_todos.where(completed: true).count

    completion_rate = total_this_week.zero? ? 0 : (completed_this_week.to_f / total_this_week) * 100

    render json: { completion_rate: completion_rate }
  end

  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
    render json: @todo
  end

  def create
    @todo = @user.todos.build(todo_params)

    if @todo.save
      create_todo_categories if params[:category_ids].present?

      render_todo_with_categories
    else
      render_error("保存に失敗しました", :unprocessable_entity)
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render_error("更新に失敗しました", :unprocessable_entity)
    end
  end

  def destroy
    render_error("削除に失敗しました", :unprocessable_entity) unless @todo.destroy
  end

  private

  def set_user
    @user = User.find_by(uid: params[:uid])
  end

  def set_todo
    @todo = Todo.find_by(id: params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :due_date, :completed, :zone, category_ids: [])
  end

  def create_todo_categories
    params[:category_ids].split(" ").each do |category|
      TodoCategory.create(todo_id: @todo.id, category_id: category)
    end
  end

  def render_user_not_found
    render_error("指定されたUIDのユーザーが見つかりません", :not_found)
  end

  def render_todo_with_categories
    category_list = { todo_id: @todo.id, categories: params[:category_ids].split(" ") }
    render json: category_list
  end

  def render_error(message, status)
    render json: { error: message }, status: status
  end
end
