class Api::V1::AchievementsController < ApplicationController
  before_action :set_user

  def achievements_by_uid
    render_user_not_found and return if @user.blank?

    @achievements = @user.achievements
    render json: @achievements
  end

  private

  def set_user
    @user = User.find_by(uid: params[:uid])
  end

  def render_user_not_found
    render json: { error: 'User not found' }, status: :not_found
  end
end
