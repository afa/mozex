ARG MIX_ENV="prod"
# build stage
FROM --platform=linux/amd64 elixir:1.17.3-otp-27-slim as build

# FROM hexpm/elixir:1.12.3-erlang-24.1.2-alpine-3.14.2 AS build

# install build dependencies
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install build-essential git python3 curl
# ?

# sets work dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

ENV ERL_FLAGS="+JPperf true"
ARG MIX_ENV
ENV MIX_ENV="${MIX_ENV}"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

# copy compile configuration files
RUN mkdir config
COPY config/config.exs config/$MIX_ENV.exs config/

# compile dependencies
RUN mix deps.compile

# copy assets
COPY priv priv
COPY assets assets

# compile project
COPY lib lib
RUN mix compile

# Compile assets
RUN mix phx.digest
RUN mix assets.deploy

# copy runtime configuration file
COPY config/runtime.exs config/

# assemble release
RUN mix release

RUN mkdir /root/.ssh && chmod 700 /root/.ssh
COPY .artifacts/deploy_key.rsa.pub .artifacts/deploy_key.rsa /root/.ssh/
COPY .artifacts/env /app/
RUN chmod 700 /app/env
RUN ssh-keyscan project.megarulez.ru>/root/.ssh/known_hosts

RUN ssh -i /root/.ssh/deploy_key.rsa moz@project.megarulez.ru rm -rf moz
RUN ssh -i /root/.ssh/deploy_key.rsa moz@project.megarulez.ru rm -rf static
RUN scp -i /root/.ssh/deploy_key.rsa -r /app/_build/prod/rel/moz moz@project.megarulez.ru:
RUN scp -i /root/.ssh/deploy_key.rsa -r /app/priv/static moz@project.megarulez.ru:
RUN scp -i /root/.ssh/deploy_key.rsa -r /app/env moz@project.megarulez.ru:moz/bin/
CMD /bin/sh
