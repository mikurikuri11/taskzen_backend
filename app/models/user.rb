class User < ApplicationRecord
  enum role: { general: 0, admin: 1 }
  has_many :todos, dependent: :destroy
  has_one :line_notification, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :achievements, dependent: :destroy

  def calculate_achievement_rate(achievement_date)
    user_todos = todos.where(due_date: achievement_date)
    return 0 if user_todos.empty?

    puts "Calculating achievement rate for user: #{id} and date: #{achievement_date}"

    completed_count = user_todos.where(completed: true).count
    total_count = user_todos.count

    puts "Completed count: #{completed_count}"
    puts "Total count: #{total_count}"

    ((completed_count.to_f / total_count) * 100).floor
  end
end
