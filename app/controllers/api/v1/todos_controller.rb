class Api::V1::TodosController < ApplicationController
  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
    @todo = Todo.find_by(id: params[:id])
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
    @todo = Todo.find_by(id: params[:id])
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: { error: "更新に失敗しました" }, status: :unprocessable_entity
    end
  end

  def destroy
    @todo = Todo.find_by(id: params[:id])
    if @todo.destroy
      head :ok
    else
      render json: { error: "削除に失敗しました" }, status: :unprocessable_entity
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:user_id, :title, :description, :due_date, :completed, :zone)
  end
end
