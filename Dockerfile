FROM ruby:2.7-alpine as base
RUN apk update && apk add alpine-sdk
RUN gem update --system
RUN gem install jekyll bundler
WORKDIR /srv/jekyll
COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM base as build
COPY . .
ENTRYPOINT ["bundle", "exec", "jekyll", "build", "--destination", "./_site"]

FROM base as serve
ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--force_polling"]