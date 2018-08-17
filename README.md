# Why Heroku restarter?

Heroku apps may sometimes need to be restarted externally. Some instances of bugs will not allow the app to crash (for which Heroku would restart the dyno automatically), and "hang" instead. For example, blocking I/O or API calls on the main thread, Puma servers can hang on Timeout errors, and so on...


None of these errors should be allowed too much longer in production, but this app allows, as a temporary stopgap measure, to restart the app programmatically. It exposes a webhook to monitoring tools, which calls the restart function of the Heroku API on your main app.
