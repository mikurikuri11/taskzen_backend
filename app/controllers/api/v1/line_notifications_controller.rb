class Api::V1::LineNotificationsController < ApplicationController
  before_action :set_user, only: [:update_or_create]

  def update_or_create
    @line_notification = LineNotification.find_or_initialize_by(user_id: @user.id)

    @line_notification.update(line_notification_params)

    render json: @line_notification
  end

  private

  def set_user
    @user = User.find_by(uid: params[:uid])
  end

  def line_notification_params
    params.require(:line_notification).permit(:notification_time, :active)
  end
end
