class TodoCategory < ApplicationRecord
  belongs_to :todo
  belongs_to :category

  validates_uniqueness_of :todo_id, scope: :category_id
end
