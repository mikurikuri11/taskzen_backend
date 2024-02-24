class AchievementCalculator
  def self.calculate_and_update_achievements(user)
    achievement_rate = user.calculate_achievement_rate(user.uid)
    week_range = Time.zone.today.all_week
    start_date = Date.parse(week_range.first.strftime('%d %b %Y'))
    end_date = Date.parse(week_range.last.strftime('%d %b %Y'))

    existing_achievement = Achievement.find_by(user_id: user.id, achievements_start_date: start_date, achievements_end_date: end_date)

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
        achievements_start_date: start_date,
        achievements_end_date: end_date
      )
    end
  end
end
