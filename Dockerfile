FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="GhostWriters"

COPY root /

RUN apk add --no-cache py3-pip
RUN pip3 install --no-cache-dir packt
