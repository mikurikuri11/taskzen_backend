class LineNotification < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :active, presence: true
end
