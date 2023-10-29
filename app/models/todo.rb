class Todo < ApplicationRecord
  has_many :todo_categories, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :user_id, presence: true
  enum status: { incomplete: 0, complete: 1 }
end
