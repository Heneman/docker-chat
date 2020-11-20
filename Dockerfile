FROM ruby:2.6.2-stretch

RUN apt update -qq \
	&& apt install -y --no-install-recommends \
	apt-transport-https \
	ca-certificates \
	apt-utils \
	build-essential

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - && \
	apt-get update && \
	apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq \
	&& apt-get install -y --no-install-recommends yarn

ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:2.1.4
ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
RUN yarn install --check-files

ENV EDITOR vi
ENV RAILS_SERVE_STATIC_FILES true
ENV SECRET_KEY_BASE bundle exec rails credentials:edit --environment production
ENV RAILS_ENV production
ENV DB_NAME postgres
ENV DB_HOST 172.17.0.1
ENV DB_PORT 5432
ENV DB_UN $DB_NAME
ENV DB_PW $DB_NAME
ENV DB_IMG $DB_NAME:9.4.1

ENV REDIS_NAME redis
ENV REDIS_PORT 6379
ENV REDIS_URL $REDIS_NAME://$DB_HOST:$REDIS_PORT/1
ENV REDIS_IMG $REDIS_NAME:latest

ENV RAILS_NAME docker-chat
ENV RAILS_PORT 3000

EXPOSE 3000 3035

ENTRYPOINT ./entrypoint.sh