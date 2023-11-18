class LineBotController < ApplicationController
  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          # message = {
          #   type: 'text',
          #   text: event.message['text']
          # }
          # uri = URI(ENV["API_URL"])
          # res = Net::HTTP.get_response(uri)
          search_and_create_message
          # puts res.body if res.is_a?(Net::HTTPSuccess)
          message = [
            { type: "text", text: "メッセージ1" }, { type: "text", text: 'メッセージ2' }
          ]
          client.reply_message(event['replyToken'], message)
        end
      end
    end
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch("LINE_CHANNEL_SECRET", nil)
      config.channel_token = ENV.fetch("LINE_CHANNEL_TOKEN", nil)
    end
  end

  def search_and_create_message
    http_client = HTTPClient.new
    uri = URI("http://localhost:8080/api/v1/todos")
    res = http_client.get(uri)
  end
end
