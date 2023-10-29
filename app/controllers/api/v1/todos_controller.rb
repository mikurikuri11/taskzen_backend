class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: %i[show update destroy]

  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
    render json: @todo
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo
    else
      render json: { error: "保存に失敗しました" }, status: :unprocessable_entity
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
