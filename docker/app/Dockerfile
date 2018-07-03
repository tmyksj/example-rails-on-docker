FROM ruby:2.5.1

ENV EROD_APP_ROOT="/var/www/app" \
    EROD_APP_TASKS="assets:precompile db:create db:migrate db:seed" \
    EROD_BUNDLE_PATH="" \
    EROD_DOCKERIZE_HOSTS="" \
    EROD_DOCKERIZE_VERSION="v0.6.1" \
    EROD_NODE_VERSION="8"

WORKDIR $EROD_APP_ROOT

RUN apt update \
    && apt upgrade -y \
    && curl -sL https://deb.nodesource.com/setup_$EROD_NODE_VERSION.x | bash - \
    && apt install -y nodejs \
    && wget https://github.com/jwilder/dockerize/releases/download/$EROD_DOCKERIZE_VERSION/dockerize-linux-amd64-$EROD_DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$EROD_DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$EROD_DOCKERIZE_VERSION.tar.gz \
    && gem install bundler \
    && echo '#!/bin/bash\n\
if [ -f tmp/pids/server.pid ]; then rm tmp/pids/server.pid; fi\n\
if [ -z $EROD_BUNDLE_PATH ]; then bundle install; else bundle install --path $EROD_BUNDLE_PATH; fi\n\
for dockerize_host in $EROD_DOCKERIZE_HOSTS; do dockerize -wait tcp://$dockerize_host; done\n\
bundle exec rails $EROD_APP_TASKS\n\
bundle exec "$@"' >> /usr/local/bin/docker-entrypoint.sh \
    && chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["rails", "server", "--binding=0.0.0.0"]
