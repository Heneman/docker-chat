export DB_NAME=postgres
export DB_HOST=172.17.0.1
export DB_PORT=5432
export DB_UN=$DB_NAME
export DB_PW=$DB_NAME
export DB_IMG=$DB_NAME:9.4.1

export REDIS_NAME=redis
export REDIS_PORT=6379
export REDIS_URL=redis://$DB_HOST:$REDIS_PORT/1
export REDIS_IMG=$REDIS_NAME:latest

export RAILS_NAME=docker-chat
export RAILS_PORT=3000

# docker run --name redis -p 6379:6379 -d redis
# docker run --name postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
# docker run --name docker-chat -e DATABASE_HOST=172.17.0.1 -e DATABASE_PORT=5432 -e DATABASE_USERNAME=postgres -e DATABASE_PASSWORD=postgres -e REDIS_URL=redis://172.17.0.1:6379/1 -p 3000:3000 docker-chat
