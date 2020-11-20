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

EXPOSE 3000 3035

ENTRYPOINT ./entrypoint.sh