class User < ApplicationRecord
  enum role: { general: 0, admin: 1 }
  has_many :todos, dependent: :destroy
  has_one :line_notification
end
