class Api::V1::CategoriesController < ApplicationController
  before_action :set_user, only: %i[categories_by_uid create_by_uid]
  before_action :set_category, only: %i[update destroy]

  def categories_by_uid
    @categories = @user.categories
    render json: @categories
  end

  def create_by_uid
    @category = @user.categories.build(category_params)
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
      render json: { message: "カテゴリーを削除しました" }
    else
      render json: { error: "カテゴリーの削除に失敗しました" }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(uid: params[:uid])
  end

  def set_category
    @category = Category.find_by(id: params[:id])
  end

  def category_params
    params.require(:category).permit(:name, todo_ids: [])
  end
end
