require 'line/bot'

namespace :line_notification do
  desc "LINE通知メッセージ送信"
  task send_line_message: :environment do
    client = initialize_line_client

    users_to_notify = LineNotification.where(active: true)
    users_to_notify.each do |notification|
      user = notification.user

      next unless user.uid && user.provider == 'line'

      achievement_rate = user.calculate_achievement_rate(user.uid)
      message = create_line_message(achievement_rate)

      puts "achievement_rate: #{achievement_rate}"
      puts "Sending message to #{user.uid}: #{message[:text]}"

      puts "現在時刻 #{Time.now.strftime('%k').strip.to_sym}"
      puts "通知時刻 #{notification.notification_time.to_sym}"

      if Time.now.strftime('%k').strip.to_sym == notification.notification_time.to_sym
        response = client.push_message(user.uid, message)
      else
        puts "この時間には#{user.name}にメッセージを送信しません。"
      end
    end
  end

  private

  def initialize_line_client
    Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end
  end

  def create_line_message(achievement_rate)
    achievement_message =
      if achievement_rate <= 30
        'もう少し頑張りましょう。'
      elsif achievement_rate <= 55
        'そこそこできています。もう一踏ん張りです。'
      elsif achievement_rate <= 80
        'とてもいい感じです。これからも頑張りましょう。'
      else
        '完璧です。新しいことに挑戦してみましょう。'
      end

    {
      type: 'text',
      text: "今週の達成率は#{achievement_rate}%です！\n#{achievement_message}"
    }
  end
end
