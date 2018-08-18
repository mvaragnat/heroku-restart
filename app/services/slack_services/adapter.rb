module SlackServices
  class Adapter
    def initialize
    end

    def send(options)
      message = options[:message]
      raise "Slack message missing" if message.blank?

      url = ENV['SLACK_WEBHOOK']
      payload = { text: message }

      if options[:channel].present?
        payload[:channel] = options[:channel]
      else
        # default channel from Slack config pannel
      end

      if options[:username].present?
        payload[:username] = options[:username]
      else
        # default username from Slack config pannel
      end

      if options[:icon_emoji].present?
        payload[:icon_emoji] = options[:icon_emoji]
      else
        # default username from Slack config pannel
      end
      RestClient.post(url, payload.to_json) if url.present?
    end
  end
end
