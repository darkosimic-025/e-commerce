# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Set development environment
ENV BUNDLE_PATH="/usr/local/bundle" \
    RAILS_ENV="development"

# Update gems and bundler
RUN gem update --system --no-document && \
    gem install -N bundler

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompiling assets for development
RUN ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Install packages needed for runtime
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=base /usr/local/bundle /usr/local/bundle
COPY --from=base /rails /rails

# Run as a non-root user for security
ARG UID=1000 \
    GID=1000
RUN groupadd -f -g $GID rails && \
    useradd -u $UID -g $GID rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database and runs tests
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server or run tests based on the command
EXPOSE 3000
CMD ["sh", "-c", "./bin/rails test && ./bin/rails server -b 0.0.0.0"]
