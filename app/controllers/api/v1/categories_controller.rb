class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: %i[update destroy]

  def index
    @categories = Category.all
    render json: @categories
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: { error: "カテゴリーの作成に失敗しました" }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: { error: "カテゴリーの更新に失敗しました" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      head :ok
    else
      render json: { error: "カテゴリーの削除に失敗しました" }, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit(:name, todo_ids: [])
  end
end
