FROM debian:bookworm-slim as build-env

RUN DEBIAN_FRONTEND=noninteractive apt update && DEBIAN_FRONTEND=noninteractive apt upgrade -y \
  # install dependencies
  && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends perl \
  # install Mojolicious
  && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends cpanminus \
  && cpanm --version \
  # make image smaller
  && rm -rf "/var/lib/apt/lists/*" \
  && rm -rf /var/cache/apt/archives \
  && rm -rf /tmp/* /var/tmp/*

WORKDIR /tmp

COPY main.pl .

EXPOSE 8080

CMD ./main.pl daemon -l http://0.0.0.0:8080

HEALTHCHECK CMD curl -f "http://localhost:8080" || exit 1
