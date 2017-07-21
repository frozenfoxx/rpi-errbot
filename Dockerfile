FROM arm32v6/python:3-alpine3.6
MAINTAINER FOXX <frozenfoxx@github.com>

# Set up environment variables
ENV ERRBOT_USER="errbot" \
  LC_ALL="C.UTF-8" \
  LANG="en_US.UTF-8" \
  LANGUAGE="en_US.UTF-8" \
  BACKEND="Text" \
  BOT_ADMINS="''" \
  BOT_NAME="Errbot" \
  CONFIG="/srv/config.py" \
  DATA_DIR="/srv/data" \
  EXTRA_PLUGIN_DIR="/srv/plugins" \
  EXTRA_BACKEND_DIR="/srv/errbackends" \
  TOKEN=""

# Add errbot user and group
RUN groupadd -r $ERRBOT_USER && \
  useradd -r \
    -g $ERRBOT_USER \
    -d /app \
    $ERRBOT_USER

# Install requirements
RUN apk -U add \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev \
    su-exec && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8 && \
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen && \
  pip3 install -U \
    errbot

# Create directories
RUN mkdir \
  /srv \
  /srv/data \
  /srv/plugins \
  /srv/errbackends \
  /app

# Copy configuration and support scripts
COPY defaults/config.py.template /tmp/
COPY bin/* /app/
VOLUME ["/srv"]
WORKDIR /app
RUN chown -R $ERRBOT_USER:$ERRBOT_USER /srv /app

# Expose network ports for webserver (if enabled)
EXPOSE 3141 3142

# Run the server
ENTRYPOINT /app/errbot-server
