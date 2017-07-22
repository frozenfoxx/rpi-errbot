FROM arm32v6/python:3-alpine3.6
MAINTAINER FrozenFOXX <frozenfoxx@github.com>

# Set up environment variables
ENV ERRBOT_USER="errbot" \
  LC_ALL="C.UTF-8" \
  LANG="en_US.UTF-8" \
  LANGUAGE="en_US.UTF-8" \
  CONFIG="/srv/config.py"

# Add errbot user and group
RUN addgroup -S $ERRBOT_USER && \
  adduser -S \
    -g $ERRBOT_USER \
    -D \
    -H \
    -h /app \
    $ERRBOT_USER

# Install requirements
RUN apk -U add \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev \
    su-exec && \
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  pip3 install -U \
    errbot \
    errbot[slack] \
    slackclient

# Create directories
RUN mkdir \
  /srv/data \
  /srv/plugins \
  /srv/errbackends \
  /app

# Copy configuration and support scripts
COPY defaults/config-template.py /srv/config.py
COPY bin/* /app/
WORKDIR /app
RUN chown -R ${ERRBOT_USER}:${ERRBOT_USER} /srv /app

VOLUME ["/srv"]

# Expose network ports for webserver (if enabled)
EXPOSE 3141 3142

# Run the server
ENTRYPOINT /app/errbot-server
