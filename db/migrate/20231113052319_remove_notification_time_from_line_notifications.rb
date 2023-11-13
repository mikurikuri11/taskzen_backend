class RemoveNotificationTimeFromLineNotifications < ActiveRecord::Migration[7.0]
  def change
    remove_column :line_notifications, :notification_time
  end
end
