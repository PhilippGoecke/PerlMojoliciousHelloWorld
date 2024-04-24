FROM debian:bookworm-slim as build-env

RUN DEBIAN_FRONTEND=noninteractive apt update && DEBIAN_FRONTEND=noninteractive apt upgrade -y \
  # install perl
  && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends perl cpanminus \
  # install Mojolicious dependencies
  && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends make \
  # install dependencies
  && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends curl \
  # make image smaller
  && rm -rf "/var/lib/apt/lists/*" \
  && rm -rf /var/cache/apt/archives \
  && rm -rf /tmp/* /var/tmp/*

RUN cpanm --version \
  && cpanm Mojolicious

WORKDIR /tmp

COPY main.pl .

EXPOSE 8080

CMD perl main.pl daemon -l http://0.0.0.0:8080

HEALTHCHECK CMD curl -f "http://localhost:8080" || exit 1
