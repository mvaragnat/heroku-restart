# Why Heroku restarter?

Heroku apps may sometimes need to be restarted externally. Some instances of bugs will not allow the app to crash (for which Heroku would restart the dyno automatically), and "hang" instead. For example, blocking I/O or API calls on the main thread, Puma servers can hang on Timeout errors, and so on...

None of these errors should be allowed too much longer in production, but this app allows, as a temporary stopgap measure, to restart the app programmatically. It exposes a webhook to monitoring tools, which calls the restart function of the Heroku API on your main app. It also notifies on Slack when the website is down (and restarted) and when it is up.

# How to use it

1) Add environment variables (see application.yml.demo)

* a webhook token (a secret shared with the monitoring service)
* Heroku API token and app name
* Slack Webhook URL and notification channel
* your website url

2) Configure the monitoring service webhook to your-heroku-restarter-url.com/webhook/WEBHOOK_TOKEN

3) You may need to write a suitable adapter for your monitoring tool, depending on the payload it sends. Current adapter is for [updown.io](https://www.updown.io) (great service, highly recommended)

# PR Welcome

* more adapters
* more notification channels and more config options
* better management of up/down period (to avoid double-restart, for example)
