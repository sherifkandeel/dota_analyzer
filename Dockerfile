FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /dota_analyzer
WORKDIR /dota_analyzer
COPY Gemfile /dota_analyzer/Gemfile
COPY Gemfile.lock /dota_analyzer/Gemfile.lock
RUN bundle install
COPY . /dota_analyzer