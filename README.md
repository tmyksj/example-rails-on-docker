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
./railsnew.sh
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
