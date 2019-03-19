# Stage use for building purposes
FROM bitwalker/alpine-elixir:1.8.1 as build

# Now we need to copy our source code to the container
COPY . .

# Install dependencies and build the release
RUN export MIX_ENV=prod && \
	rm -Rf _build && \
	mix deps.get && \
	mix release

RUN APP_NAME="soccer_data_fetcher" && \
	VERSION="0.1.0" && \
	RELASE_DIR="_build/prod/rel/$APP_NAME/releases/$VERSION/" && \
	echo $RELEASE_DIR && \
	mkdir /export && \
	tar -xf "_build/prod/rel/$APP_NAME/releases/$VERSION/$APP_NAME.tar.gz" -C /export

# Stage made for deployment
FROM pentacent/alpine-erlang-base:latest

# Expose the port 4444
EXPOSE 4444
ENV REPLACE_OS_VARS=true \
	PORT=4444

COPY --from=build /export/ .

RUN ln -s /usr/local/lib/libssl.so.1.1 /usr/lib/libssl.so.1.1

USER default

ENTRYPOINT ["/opt/app/bin/soccer_data_fetcher"]
CMD ["foreground"]
