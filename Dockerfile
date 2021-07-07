# Use the Ruby 2.6.6 image from Docker Hub
# as the base image (https://hub.docker.com/_/ruby)
FROM ruby:2.6.6

# 
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get install -y yarn

# 
RUN mkdir /reddit-mvp

WORKDIR /reddit-mvp

COPY Gemfile /reddit-mvp/Gemfile

COPY Gemfile.lock /reddit-mvp/Gemfile.lock

# Install Yarn.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Run yarn install to install JavaScript dependencies.
RUN yarn install --check-files

# Install correct bundle version
RUN gem install bundler:2.1.4

RUN bundle install


COPY . /reddit-mvp