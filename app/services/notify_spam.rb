class NotifySpam
    require 'net/http'
    NAME_AND_ICON = {
        username: 'SlackBot',
        icon_emoji: ':red_circle:'
    }


    def initialize()
      @uri = URI(ENV['SLACK_WEBHOOK_URL'])
      @channel = ENV['SLACK_WEBHOOK_CHANNEL']
    end
  
    def notify_spam(email = "N/A", bounce_time="N/A")

      params = {
        "blocks": [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": "A Spam has been detected",
                    "emoji": true
                }
            },
            {
                "type": "section",
                "fields": [
                    {
                        "type": "mrkdwn",
                        "text": "*Email:*\n#{email}"
                    }
                ]
            },
            {
                "type": "section",
                "fields": [
                    {
                        "type": "mrkdwn",
                        "text": "*On:*\n#{bounce_time}"
                    }
                ]
            }
        ]
      }
      @params = generate_payload(params)
      self
    end
  
    def deliver_message
      begin
        Net::HTTP.post_form(@uri, @params)
      rescue => e
        Rails.logger.error("Error when sending: #{e.message}")
      end
    end
  
    private
  
    def generate_payload(params)
      {
          payload: NAME_AND_ICON
                       .merge(channel: @channel)
                       .merge(params).to_json
      }
    end
end