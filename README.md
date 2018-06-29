# example-rails-on-docker
## is EROD

# howto
## README.md environment
- container:
  - db:
    - hostname: mariadb
  - rails:
    - hostname: rails
    - image name: erod-rails
  - webserver:
    - hostname: nginx
- deploy stack: erod

## build
```
docker-compose build
```

### rebuild
```
docker rmi erod-rails
docker-compose build
```

## rails new
```
docker run --rm -it -v `pwd`:/var/www/app erod-rails rails new . --database=mysql --skip-bundle
```

### config/database.yml example
```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV['RAILS_DATABASE_USERNAME'] %>
  password: <%= ENV['RAILS_DATABASE_PASSWORD'] %>
  host: <%= ENV['RAILS_DATABASE_HOST'] %>

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
docker-compose exec rails rails generate scaffold article title:string body:string
```

## deploy
### with docker compose
```
docker-compose -f docker-stack.yml up
```

### with docker swarm
```
docker swarm init
docker stack deploy -c docker-stack.yml erod
```
