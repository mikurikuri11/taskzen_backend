class TodoCategory < ApplicationRecord
  belongs_to :user
  belongs_to :todo

  # TODO: 必要かどうか検討
  # validates_uniqueness_of :todo_id, scope: :user_id
end
