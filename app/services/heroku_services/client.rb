module HerokuServices
  class Client
    class << self
      def restart
        puts 'task restart_worker is on'
        client.dyno.restart_all(ENV['HEROKU_APP_NAME'])
      end

      def client
        @heroku ||= PlatformAPI.connect_oauth(ENV['HEROKU_API_KEY'])
        @heroku
      end
    end
  end
end
