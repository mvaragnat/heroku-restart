module WebhookAdapters
  class UpdownAdapter
    def initialize; end

    # adapters return "false" if the website is down and needs to be restarted
    # "true" otherwise
    def process_events(params)
      events = params['_json']

      raise 'Missing events' if events.blank? || !events.class == Array

      # many events can be sent at once
      # restart server only if one or more down events, and no up event
      at_least_one_down = false
      at_least_one_up = false

      events.each do |e|
        type = e['event']
        url = e['check']['url']
        puts "Processing event #{type} from url #{url}"

        # updown sends events for all monitored website
        if url.match(ENV['WEBSITE_URL'])
          at_least_one_down = true if type == 'check.down'
          at_least_one_up = true if type == 'check.up'
        end
      end

      if at_least_one_down && !at_least_one_up
        false
      else
        true
      end
    end
  end
end
