#!/bin/bash

docker run --entrypoint /bin/bash --rm -it -v `pwd`/app:/var/www/app -v `pwd`/data/app:/var/www/data/app erod-app -c " \
bundle install \
&& bundle exec rails new . --database=mysql --force --skip-bundle --skip-git \
&& rm config/database.yml \
&& mv config/master.key ../data/app/master.key \
&& ln -s ../../data/app/database.yml config/database.yml \
&& ln -s ../../data/app/master.key config/master.key \
&& ln -s ../../data/app/production.log log/production.log \
&& echo -e '\
/.bundle\n\
/log/*\n\
!/log/production.log\n\
/node_modules\n\
/public/assets\n\
/storage/*\n\
/tmp/*\n\
!/tmp/.keep\n\
/yarn-error.log\n\
.byebug_history' > .gitignore \
"
