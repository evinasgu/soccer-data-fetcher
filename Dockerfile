# Stage use for building purposes
FROM bitwalker/alpine-elixir:1.8.1 as build

# Now we need to copy our source code to the container
COPY . .

# Install dependencies and build the release
RUN export MIX_ENV=prod && \
	rm -Rf _build && \
	mix deps.get && \
	mix release

RUN APP_NAME="SOCCER_DATA_FETCHER" && \
	RELASE_DIRECTORY=`ls -d _build/prod/rel/$APP_NAME/releases/*/` && \
	mkdir /export && \
	tar -xf "$RELEASE_DIRECTORY/$APP_NAME.tar.gz" -C /export

# Stage made for deployment
FROM pentacent/alpine-erlang-base:latest

# Expose the port 4444
EXPOSE 4444
ENV REPLACE_OS_VARS=true \
	PORT=4444

COPY --from=build /export/

USER default

ENTRYPOINT ["/opt/app/bin/SOCCER_DATA_FETCHER"]
CMD ["foreground"]
