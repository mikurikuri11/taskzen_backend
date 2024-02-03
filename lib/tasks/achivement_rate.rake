require 'line/bot'

namespace :achievement_rate do
  desc "達成率をテーブルに保存"
  task add_achievement_rate: :environment do
    users = User.all
    users.each do |user|
      achievement_rate = user.calculate_achievement_rate(user.uid)
      week_range = Time.zone.today.all_week
      start_date = Date.parse(week_range.first.strftime('%d %b %Y'))
      end_date = Date.parse(week_range.last.strftime('%d %b %Y'))

      if Time.zone.today == end_date
        puts "Achievement rate will be added only on the end_date."
        puts "Achievement rate: #{achievement_rate}"

        Achievement.create(
          user_id: user.id,
          achievement_rate: achievement_rate,
          achievements_start_date: start_date,
          achievements_end_date: end_date
        )
      else
        puts "Today is not the end_date. Skipping..."
      end
    end
  end
end
