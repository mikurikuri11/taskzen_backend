class User < ApplicationRecord
  enum role: { general: 0, admin: 1 }
  has_many :todos, dependent: :destroy
  has_one :line_notification, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :achievements, dependent: :destroy

  def calculate_achievement_rate(uid, start_date, end_date)
    user_todos = todos.where(due_date: start_date..end_date)
    return 0 if user_todos.empty?

    completed_count = user_todos.where(completed: true).count
    total_count = user_todos.count

    ((completed_count.to_f / total_count) * 100).floor
  end
end
