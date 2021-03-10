module SlackServices
  class Client
    def initialize(options = {})
      @options = options
      @adapter = Rails.configuration.slack_adapter.call.new
    end

    def send
      @adapter.send @options
    end
  end
end
