class Api::V1::AchievementsController < ApplicationController
  before_action :set_user

  def achievements_by_uid
    render_user_not_found and return if @user.blank?

    @achievements = @user.achievements
    render json: @achievements
  end

  def this_week_achievement_rate
    render_user_not_found and return if @user.blank?

    start_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week

    @this_week_achievements = @user.achievements.where(
      achievements_start_date: start_of_week..end_of_week
    )

    render json: @this_week_achievements
  end

  private

  def set_user
    @user = User.find_by(uid: params[:uid])
  end

  def render_user_not_found
    render json: { error: 'User not found' }, status: :not_found
  end
end
