#!/bin/bash

docker run --entrypoint /bin/bash --rm -it -v `pwd`/app:/var/www/app -v `pwd`/data/app:/var/www/data/app erod-rails -c " \
bundle install \
&& bundle exec rails new . --database=mysql --force --skip-bundle \
&& rm -rf .git \
&& rm config/database.yml \
&& mv config/master.key ../data/app/master.key \
&& ln -s ../../data/app/database.yml config/database.yml \
&& ln -s ../../data/app/master.key config/master.key \
&& ln -s ../../data/app/production.log log/production.log \
"
