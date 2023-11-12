class Api::V1::LineNotificationsController < ApplicationController
  before_action :set_user, only: [:update_or_create]

  def update_or_create
    @line_notification = LineNotification.find_by(user_id: @user.id)

    if @line_notification
      # 既存のレコードがある場合は更新
      @line_notification.update(line_notification_params)
    else
      # 既存のレコードがない場合は新規作成
      @line_notification = LineNotification.new(line_notification_params)
      @line_notification.user = @user
      @line_notification.save!
    end
  end

  private

  def set_user
    @user = User.find_by(uid: params[:uid])
  end

  def line_notification_params
    params.require(:line_notification).permit(:notification_time, :active)
  end
end
