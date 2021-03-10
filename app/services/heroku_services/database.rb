require 'open-uri'

module HerokuServices
  class Database
    class << self
      def get_db
        return nil unless ENV['HEROKU_DATABASE_ID']

        client.databases.info(ENV['HEROKU_DATABASE_ID'])
      end

      def get_backups
        client.backups.list(ENV['HEROKU_APP_NAME'])
      end

      def get_last_backup
        get_backups.first
      end

      # download file to local filesystem, return filepath
      # local filesystem is not permanent on heroku => file should be then copied elsewhere
      def download_last_backup
        backup = get_last_backup
        backup_num = backup[:num]
        backup_date = Date.strptime backup[:started_at]
        backup_url = client.backups.url(ENV['HEROKU_APP_NAME'], backup_num)[:url]

        local_file_path = "tmp/backup_#{backup_date.strftime('%Y%m%d')}"

        File.open(local_file_path, 'w+b') do |file|
          file.write(open(backup_url).read)
          file.close
        end

        local_file_path
      end

      def client
        @heroku ||= Heroku::Api::Postgres.connect_oauth(ENV['HEROKU_API_TOKEN'])
        @heroku
      end
    end
  end
end
