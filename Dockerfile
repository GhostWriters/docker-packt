FROM alpine:3.12

LABEL maintainer="GhostWriters"

COPY root /
RUN chmod +x /opt/docker-entrypoint.sh

RUN apk add --no-cache py3-pip
RUN pip3 install --no-cache-dir packt

ENTRYPOINT ["/opt/docker-entrypoint.sh"]
