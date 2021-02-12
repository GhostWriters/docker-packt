# Container for Packt daily download script

[![GitHub contributors](https://img.shields.io/github/contributors/GhostWriters/docker-packt.svg?style=flat-square&color=607D8B)](https://github.com/GhostWriters/docker-packt/graphs/contributors)
[![GitHub last commit master](https://img.shields.io/github/last-commit/GhostWriters/docker-packt/master.svg?style=flat-square&color=607D8B&label=code%20committed)](https://github.com/GhostWriters/docker-packt/commits/master)
[![GitHub license](https://img.shields.io/github/license/GhostWriters/docker-packt.svg?style=flat-square&color=607D8B)](https://github.com/GhostWriters/docker-packt/blob/master/LICENSE.md)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/GhostWriters/docker-packt/Super-Linter/master?style=flat-square&color=607D8B&logo=github)](https://github.com/GhostWriters/docker-packt/actions?query=workflow%3ASuper-Linter+branch%3Amaster)

This creates a Alpine Linux docker container running running cron, scheduled to
claim the daily free book once per night at 1am. For more information about what
this container calls visit
<https://github.com/packt-cli/Packt-Publishing-Free-Learning>.

## Run

Run with:

```docker
docker run -d \
  --name=packt --rm \
  -e PACKT_EMAIL=<xxx@xxx.xxx> \
  -e PACKT_PASSWORD=<password> \
  -e PACKT_DOWNLOAD_FORMATS=pdf, epub, mobi, code \
  -e PACKT_ANTICAPTCHA_KEY=<key> \
  -e PUID=<UID> \
  -e PGID=<GID> \
  -e TZ=<timezone> \
  -v /home/user/packt/config:/config \
  -v /home/user/packt/books:/data \
  --restart unless-stopped \
  ghostwriters/docker-packt
```

## Volumes and variables

Volumes:

- /config, where the configFile.cfg and log file are placed
- /data, where files are downloaded to

OPTIONAL: Variables:

- PACKT_EMAIL - email address registered with Packt account
- PACKT_PASSWORD - password for Packt account
- PACKT_DOWNLOAD_FORMATS - pdf, epub, mobi, code
- PACKT_ANTICAPTCHA_KEY - get an api key from <https://anti-captcha.com>
- PACKT_DOWNLOAD_BOOK_TITLES - specify individual books

If variables are set, they overwrite what is already in the configFile.cfg file
at container startup. If not set, the config file will be left alone.

Anticaptcha key required to download the daily book.

## Special Thanks

- <https://github.com/packt-cli/Packt-Publishing-Free-Learning> for maintaining
  the package to handle the downloading.
- [LinuxServer.io](https://www.linuxserver.io/) for maintaining the base image used in this project.
