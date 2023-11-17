class AddNotificationTimeToLineNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :line_notifications, :notification_time, :integer, default: 1, null: false
  end
end
