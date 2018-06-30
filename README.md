# example-rails-on-docker: EROD

# howto
## README.md environment
- container:
  - app:
    - hostname: app
    - image name: erod-rails
  - db:
    - hostname: db
  - web:
    - hostname: web
- deploy stack: erod

## build
```
docker-compose build
```

## rails new
```
docker run --rm -it -v `pwd`/app:/var/www/app erod-rails rails new . --database=mysql --skip-bundle --skip-git
```

### config/database.yml example
```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV['RAILS_DATABASE_USERNAME'] %>
  password: <%= ENV['RAILS_DATABASE_PASSWORD'] %>
  host: db

development:
  <<: *default
  database: erod_development

test:
  <<: *default
  database: erod_test

production:
  <<: *default
  database: <%= ENV['RAILS_DATABASE'] %>
```

## development
```
docker-compose up
```

### rails command example
```
docker-compose exec app bundle exec rails generate scaffold article title:string body:string
```

## deploy
### with docker swarm
#### swarm init
```
docker swarm init
```

#### stack deploy
```
docker stack deploy -c docker-stack.yml erod
```

#### service update
```
docker service update --force erod_app
```
