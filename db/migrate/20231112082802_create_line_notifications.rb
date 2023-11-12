class CreateLineNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :line_notifications do |t|
      t.integer :user_id, null: false
      t.time :notification_time
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_foreign_key :line_notifications, :users
  end
end
