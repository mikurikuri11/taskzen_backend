class DropAchievementsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :achievements
  end

  def down
    create_table :achievements do |t|
      t.integer "user_id"
      t.float "achievement_rate"
      t.integer "zone"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.date "achievement_date"
    end
  end
end
