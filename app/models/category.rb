class Category < ApplicationRecord
  has_many :todos_categories, dependent: :destroy
end
