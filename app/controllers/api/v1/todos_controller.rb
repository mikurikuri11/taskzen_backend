class Api::V1::TodosController < ApplicationController
  include Api::V1::Concerns::TodosResponse

  before_action :set_user, only: [:todos_by_uid, :complete_todo, :incomplete_todo, :incomplete_todo_by_one, :incomplete_todo_by_two, :incomplete_todo_by_three, :incomplete_todo_by_four, :this_week_completion_rate, :create]
  before_action :set_todo, only: [:show, :update, :destroy]

  def todos_by_uid
    render_user_not_found and return if @user.blank?

    @todos = @user.todos.includes(:categories)
    render json: @todos, include: :categories
  end

  def complete_todo
    render_user_not_found and return if @user.blank?

    completed_todos = @user.todos.includes(:categories).where(completed: true)
    render json: completed_todos, include: :categories
  end

  def incomplete_todo
    render_user_not_found and return if @user.blank?

    incomplete_todos = @user.todos.includes(:categories).where(completed: false)
    render json: incomplete_todos, include: :categories
  end

  ## TODO: 不要かも
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
    category_ids = params[:category_ids] || []

    if @todo.save
      category_ids.each do |category_id|
        TodoCategory.create(todo_id: @todo.id, category_id: category_id)
      end
      render_todo_with_categories(@todo, category_ids)
    else
      render_error("保存に失敗しました", :unprocessable_entity)
    end
  end

  def update
    if @todo.update(todo_params)
      categories_params = params["categories"] || []
      category_ids = categories_params.map { |category| category["id"] }
      # 既存のカテゴリーを削除
      @todo.categories.clear
      # 新しいカテゴリーを追加
      category_ids.each do |category_id|
        category = Category.find_by(id: category_id)
        @todo.categories << category if category.present?
      end
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
    params.require(:todo).permit(:title, :description, :due_date, :completed, :zone, categories: [:id, :name])
  end
end
