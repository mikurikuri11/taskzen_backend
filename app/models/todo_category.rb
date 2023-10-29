class TodoCategory < ApplicationRecord
  belongs_to :todo
  belongs_to :category
  validates :todo_id, presence: true
  validates :category_id, presence: true

  # TODO: 必要かどうか検討
  # validates_uniqueness_of :todo_id, scope: :user_id
end
