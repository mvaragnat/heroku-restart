module HerokuServices
  class Client
    def initialize(options={})
      @heroku = PlatformAPI.connect_oauth(ENV['HEROKU_API_TOKEN'])
    end

    def restart
      puts "task restart_worker is on"
      @heroku.dyno.restart_all(ENV["HEROKU_APP_NAME"])
    end
  end
end
