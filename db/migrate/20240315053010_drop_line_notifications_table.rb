class DropLineNotificationsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :line_notifications
  end

  def down
    create_table :line_notifications do |t|
      t.integer "user_id"
      t.boolean "active", default: true, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "notification_time", default: 1, null: false
    end
  end
end
