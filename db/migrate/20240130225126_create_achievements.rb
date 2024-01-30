class CreateAchievements < ActiveRecord::Migration[7.0]
  def change
    create_table :achievements do |t|
      t.integer :user_id
      t.float :achievement_rate
      t.date :achievement_date
      t.integer :zone

      t.timestamps
    end
  end
end
