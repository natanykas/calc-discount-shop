FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /calc-discount-shop
COPY Gemfile /calc-discount-shop/Gemfile
COPY Gemfile.lock /calc-discount-shop/Gemfile.lock
RUN bundle install
COPY . /calc-discount-shop

EXPOSE 3000
