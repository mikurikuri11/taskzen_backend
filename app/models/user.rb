class User < ApplicationRecord
  enum role: { general: 0, admin: 1 }
  has_many :todos, dependent: :destroy
  has_many :categories, dependent: :destroy
end
