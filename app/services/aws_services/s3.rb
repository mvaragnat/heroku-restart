module AwsServices
  class S3
    class << self
      def client
        @s3 ||= Aws::S3::Client.new
      end

      def bucket
        client.list_buckets.buckets.select{ |bucket| bucket.name == ENV['S3_BUCKET'] }
      end

      def upload_file(filepath: 'tmp/backup_20210310')
        
      end
    end
  end
end