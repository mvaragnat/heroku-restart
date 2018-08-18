class PagesController < ApplicationController
  protect_from_forgery except: [:webhook]

  def home
  end

  def webhook
    token = params[:token]

    if token == ENV['WEBHOOK_TOKEN']
      render json: { message: "Webhook processed" }, status: :ok

      # many adapters can be used depending on the monitoring service
      # here we use Updown.io
      website_up = WebhookAdapters::UpdownAdapter.new.process_events params.permit!

      if website_up
        puts "Website up"
        SlackServices::Client.new(
            message: "#{ENV['WEBSITE_URL']} is up",
            channel: ENV['SLACK_NOTIF_CHANNEL'],
            icon_emoji: ':muscle:',
            username: 'Heroku Monitor').send
      else
        puts "Website down"
        SlackServices::Client.new(
            message: "#{ENV['WEBSITE_URL']} is down - restarting",
            channel: ENV['SLACK_NOTIF_CHANNEL'],
            icon_emoji: ':scream:',
            username: 'Heroku Monitor').send

        puts "send restart command to Heroku"
        HerokuServices::Client.new.restart
      end
    else
      render json: { message: "Wrong token" }, status: :internal_server_error
    end
  end
end
