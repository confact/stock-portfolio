FROM ruby:2.5.3-alpine

# Edit with nodejs, mysql-client, postgresql-client, sqlite3, etc. for your needs.
# Or delete entirely if not needed.
RUN apk --no-cache add nodejs tzdata git build-base libxml2-dev libxslt-dev sqlite-dev

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
# Install build dependencies - required for gems with native dependencies
RUN apk add --no-cache --virtual build-deps build-base postgresql-dev && \
  bundle install && \
  apk del build-deps

COPY . /app

RUN bundle exec rake assets:precompile

# For Rails
ENV PORT 5000
EXPOSE $PORT
CMD ["bin/rails s Puma -p 5000 -b 0.0.0.0"]
