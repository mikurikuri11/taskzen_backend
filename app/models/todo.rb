class Todo < ApplicationRecord
  has_many :todo_categories, dependent: :destroy
  has_many :categories, through: :todo_categories
  belongs_to :user
  validates :title, presence: true

  def self.this_week_completion_rate
    start_of_week = Time.zone.today.beginning_of_week
    end_of_week = Time.zone.today.end_of_week

    completed_count = where(completed: true, due_date: start_of_week..end_of_week).count
    total_count = where(due_date: start_of_week..end_of_week).count

    if total_count.positive?
      (completed_count.to_f / total_count) * 100
    else
      0
    end
  end
end
