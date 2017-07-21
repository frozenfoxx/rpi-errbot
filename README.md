# rpi-errbot
[Errbot](http://errbot.io/en/latest/) for [Docker](https://www.docker.com) on the [Raspberry Pi](https://www.raspberrypi.org).

Docker Hub: [https://hub.docker.com/r/frozenfoxx/rpi-errbot/](https://hub.docker.com/r/frozenfoxx/rpi-errbot/)

# How to Build
```
git clone git@github.com:frozenfoxx/rpi-errbot.git
cd rpi-errbot
docker build .
```

# How to Use this Image
## Quickstart
The following will set up and run the latest Errbot connected to [Slack](https://slack.com).

```
docker run -d --name=errbot_server \
  -v /srv \
  -e BACKEND="Slack" \
  -e TOKEN="[bot token]" \
  frozenfoxx/rpi-errbot
```

## Data Container
To persist your data, plugins, and other information you're going to want to create a data container (or otherwise mount storage).  The following will quickly create one:

```
docker create -v /srv --name errbot_data frozenfoxx/rpi-errbot /bin/true
```

You can then mount this container using `--volumes-from`:

```
docker run -d --name=errbot_server \
  --volumes-from errbot_data \
  -e BACKEND="Slack" \
  -e TOKEN="[bot token]" \
  frozenfoxx/rpi-errbot
```

# Configuration
## Environment Variables
This image can be configured using environment variables.

* `ERRBOT_USER`: system username.
* `LC_ALL`: default locale.
* `LANG`: default language.
* `LANGUAGE`: default system language.
* `BACKEND`: which backend to load.
* `BOT_ADMINS`: list of bot administrators.  Single quote and comma required. (Ex. "'user1','user2','user3'")
* `BOT_NAME`: friendly name of the bot in chat.
* `CONFIG`: filesystem location for the main Errbot configuration file.
* `DATA_DIR`: filesystem location for Errbot data.
* `EXTRA_PLUGIN_DIR`: filesystem location for extra plugins.
* `EXTRA_BACKEND_DIR`: filesystem location for extra backends.
* `TOKEN`: integration token (Slack/Telegram)
