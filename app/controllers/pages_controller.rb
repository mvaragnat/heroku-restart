class PagesController < ApplicationController
  def home
  end
        
  def webhook
    token = params[:token]
    puts "TEST Webhook token #{token}, webhook #{ENV['WEBHOOK_TOKEN']}, #{token == ENV['WEBHOOK_TOKEN']}"
    if token == ENV['WEBHOOK_TOKEN']
      render json: { message: "Webhook processed" }, status: :ok
    else
      render json: { message: "Wrong token" }, status: :internal_server_error
    end
  end
end
