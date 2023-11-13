class RemoveNullConstraintFromLineNotifications < ActiveRecord::Migration[7.0]
  def change
    change_column_null :line_notifications, :user_id, true
  end
end
