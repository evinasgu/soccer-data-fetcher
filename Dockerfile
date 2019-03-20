# Stage use for building purposes
FROM elixir:1.8.1

RUN export MIX_ENV=prod

RUN mix local.hex --force && mix local.rebar --force

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix do deps.get, deps.compile, compile

EXPOSE 4000
