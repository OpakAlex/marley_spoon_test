FROM ruby:2.7.0

ARG RAILS_ENV
ENV RAILS_ENV production

ARG API_SPACE_ID
ARG API_ACCESS_TOKEN

ENV BUNDLER_VERSION 2.0.2
ENV BUNDLE_PATH /bundle

RUN mkdir -p /app && mkdir -p /bundle

WORKDIR /app

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn

COPY Gemfile* ./

RUN gem update --system && gem install bundler && \
	bundle install

COPY . .

RUN yarn install --check-files

RUN bundle exec rails assets:precompile

EXPOSE 80

CMD bundle exec puma -C "-" -p 80 -w 3 --preload
