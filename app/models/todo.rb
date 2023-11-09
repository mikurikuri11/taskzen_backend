class Todo < ApplicationRecord
  has_many :todo_categories, dependent: :destroy
  has_many :categories, through: :todo_categories
  belongs_to :user
  validates :title, presence: true
  validates :user_id, presence: true

  def self.this_week_completion_rate
    start_of_week = Date.today.beginning_of_week
    end_of_week = Date.today.end_of_week

    completed_count = where(completed: true, due_date: start_of_week..end_of_week).count

    total_count = where(due_date: start_of_week..end_of_week).count

    if total_count > 0
      completion_rate = (completed_count.to_f / total_count.to_f) * 100
    else
      completion_rate = 0
    end

    completion_rate
  end
end
