class LineNotification < ApplicationRecord
  belongs_to :user
  enum notification_time: { '8': 1, '10': 2, '12': 3, '15': 4 }
end
