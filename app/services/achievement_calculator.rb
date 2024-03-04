class AchievementCalculator
  def self.calculate_and_update_achievements(user, todo)
    achievement_rate = user.calculate_achievement_rate(todo.due_date)

    existing_achievement = Achievement.find_by(user_id: user.id, achievement_date: todo.due_date)

    if existing_achievement
      puts "Updating existing achievement record..."
      puts "Old achievement rate: #{existing_achievement.achievement_rate}"
      puts "New achievement rate: #{achievement_rate}"

      existing_achievement.update(achievement_rate: achievement_rate)
    else
      puts "Creating new achievement record..."
      puts "Achievement rate: #{achievement_rate}"

      Achievement.create(
        user_id: user.id,
        achievement_rate: achievement_rate,
        achievement_date: todo.due_date
      )
    end
  end
end