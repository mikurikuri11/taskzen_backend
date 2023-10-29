class Category < ApplicationRecord
  has_many :todo_categories, dependent: :destroy
end
