# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.1
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set environment
ENV BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    DEBIAN_FRONTEND=noninteractive

# Set environment variables for Rails
ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV

# Throw-away build stage to reduce size of final image
FROM base as build

# Install apt-utils first to avoid debconf warnings
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y apt-utils && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config ffmpeg

# Verificar se o ffmpeg foi instalado corretamente
RUN ffmpeg -version

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Final stage for app image
FROM base

# Install packages needed for deployment, including ffmpeg
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client ffmpeg && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Verificar se o ffmpeg foi instalado corretamente na fase final
RUN ffmpeg -version

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
