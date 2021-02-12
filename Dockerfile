FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="GhostWriters"

COPY root /

# hadolint ignore=DL3018
RUN apk add --no-cache py3-pip

# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir packt
