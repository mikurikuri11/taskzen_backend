class Category < ApplicationRecord
  has_many :todo_categories, dependent: :destroy
  has_many :todos, through: :todo_categories
end
