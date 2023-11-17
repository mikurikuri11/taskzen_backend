class Api::V1::TodosController < ApplicationController
  include Api::V1::Concerns::TodosResponse

  before_action :set_user, only: [:todos_by_uid, :this_week_completion_rate, :create]
  before_action :set_todo, only: [:show, :update, :destroy]

  def todos_by_uid
    render_user_not_found and return if @user.blank?

    @todos = @user.todos
    render json: @todos
  end

  def this_week_completion_rate
    render_user_not_found and return if @user.blank?

    this_week_todos = @user.todos.where(due_date: Time.zone.today.all_week)

    total_this_week = this_week_todos.count
    completed_this_week = this_week_todos.where(completed: true).count

    completion_rate = total_this_week.zero? ? 0 : (completed_this_week.to_f / total_this_week) * 100

    render json: { completion_rate: }
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
      create_todo_categories(@todo, params[:category_ids]) if params[:category_ids].present?
      render_todo_with_categories(@todo, params[:category_ids])
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
end
