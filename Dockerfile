ARG RUBY_VERSION=3.1.2

FROM ruby:${RUBY_VERSION}-alpine AS base

RUN apk add --update tzdata build-base sqlite sqlite-dev

RUN wget -O - https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2 | tar -xj && \
    cd jemalloc-5.2.1 && \
    ./configure && \
    make && \
    make install

FROM base AS dependencies

ARG RAILS_ENV=production
ARG BUNDLER_VERSION=2.3.9

RUN apk add --update build-base

RUN gem install bundler:$BUNDLER_VERSION

COPY Gemfile Gemfile.lock ./

RUN if [[ "$RAILS_ENV" == "production" ]]; then \
  bundle config --global frozen 1 && \
  bundle config set without "development test" && \
  bundle install --retry 3 --jobs 3; \
	else bundle install; fi

FROM base

RUN adduser -D app

USER app

WORKDIR /home/app

COPY --from=base /usr/local/lib/libjemalloc.so.2 /usr/local/lib/

ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2

RUN MALLOC_CONF=stats_print:true ruby -e "exit"

COPY --from=dependencies /usr/local/bundle /usr/local/bundle

COPY --chown=app . ./

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "--log-to-stdout"]
