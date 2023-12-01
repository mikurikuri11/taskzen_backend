class User < ApplicationRecord
  enum role: { general: 0, admin: 1 }
  has_many :todos, dependent: :destroy
  has_one :line_notification, dependent: :destroy
  has_many :categories, dependent: :destroy

  def calculate_achievement_rate(id)
    client = HTTPClient.new

    begin
      response = client.get("#{ENV.fetch('API_URL', nil)}/#{id}")

      if response.status == 200
        # レスポンスが成功した場合、JSONから達成率を取得
        data = JSON.parse(response.body)
        achievement_rate = data['completion_rate'].to_i
      else
        # レスポンスがエラーの場合、デフォルト値などを設定
        achievement_rate = 0
      end
    rescue HTTPClient::BadResponseError, HTTPClient::TimeoutError => e
      # 例外が発生した場合、エラー処理を行う
      puts "Error making API request: #{e.message}"
      achievement_rate = 0
    end

    achievement_rate
  end
end
