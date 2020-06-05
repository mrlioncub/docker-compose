FROM alpine:3.12.0

LABEL maintainer="mr.lioncub" \
      release-date="2020–06–05"

ARG DOCKER_COMPOSE_VERSION

RUN set -x \
  && apk add --no-cache py3-pip \
  && apk add --no-cache --virtual .build-deps python3-dev libffi-dev openssl-dev gcc libc-dev make \
  && pip3 install --no-cache-dir "docker-compose${DOCKER_COMPOSE_VERSION:+==}${DOCKER_COMPOSE_VERSION}" \
  && apk del --no-cache .build-deps \
  && rm -rf ~/.cache/pip \
  && find . -name "__pycache__" -exec rm -r {} +

CMD ["/usr/bin/docker-compose", "version", "--short"]
