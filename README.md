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
[Copy defaults/config-template.py to defaults/config.py and adjust]
docker run -d --name=errbot_server \
  -v /srv \
  -v defaults/config.py:/srv/config.py
  frozenfoxx/rpi-errbot
```

## Custom Config
Errbot is highly configurable.  You can adjust the configuration by copying the `defaults/config-template.py` to `defaults/config.py`, modifying, and then mounting to `/srv/config.py` when running the container.  If you'd like to build one with a custom configuration to begin with simply modify the `defaults/config-template.py` first and it will be copied in upon build.

## Data Container
To persist your data, plugins, and other information you're going to want to create a data container (or otherwise mount storage).  The following will quickly create one:

```
docker create -v /srv --name errbot_data frozenfoxx/rpi-errbot /bin/true
```

You can then mount this container using `--volumes-from`:

```
docker run -d --name=errbot_server \
  -volumes errbot_data:/srv \
  frozenfoxx/rpi-errbot
```

# Configuration
## Environment Variables
This image can be configured using environment variables.

* `ERRBOT_USER`: system username.
* `LC_ALL`: default locale.
* `LANG`: default language.
* `LANGUAGE`: default system language.
* `CONFIG`: filesystem location for the main Errbot configuration file.

## Backends
Current backends built into this image:
* Slack
* Text

More can be added via inserting them into the packages to be installed via `pip3` in the `Dockerfile`.
