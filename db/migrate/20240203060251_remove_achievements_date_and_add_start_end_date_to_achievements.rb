class RemoveAchievementsDateAndAddStartEndDateToAchievements < ActiveRecord::Migration[7.0]
  def change
    remove_column :achievements, :achievement_date, :date
    add_column :achievements, :achievements_start_date, :date
    add_column :achievements, :achievements_end_date, :date
  end
end
