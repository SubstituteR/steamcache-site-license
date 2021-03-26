# Steam Site License Server for Content Caching

## Introduction

This is a docker container for running a Steam Site License Server with content caching. The intention is for this to be used by LAN parties and other places where bandwidth is limited, but you want a content cache for Steam. This is a fork of the original server from [LanCache.net](https://lancache.net).

This is a better solution than previous proxy-based Steam caches for a few reasons:

1. It does not require any DNS changes/overrides.
2. It is officially supported by Valve.
3. It works automatically in all clients on your network.
4. You get statistics on the games played.

## Pre-requisites

You will need to sign up to Valve's partner program and choose Site Licensing. You can then create a new Site and assign a steam user to it.

Adding a user to a Steam Partner forces Steam Guard to be enabled, this is a problem for us, but there is a way round it - we can generate the mobile authenticator tokens. Someone has already done the work to implement this and there is a separate container you can run for an HTTP service that gives out valid tokens.

 - [Steam 2FA Auth Code Generator](https://github.com/mintopia/steamcache-authcode)

## Usage

### Docker CLI:
```bash
docker run \
    --restart=unless-stopped \
    --name steamcache-server \
    --network=host \
    -d \
    -v /data/cache:/opt/steamcmd/cache \
    -e STEAM_USERNAME=mysteamuser \
    -e STEAM_PASSWORD=hunter2 \
    -e STEAM_AUTHCODE_URL=http://myauthcodeservice.example.com \
    lancachenet/steamcache-site-license:latest
```

### Docker Compose:
```yaml
version: '3.3'
services:
    steamcache-site-license:
        restart: unless-stopped
        container_name: steamcache-server
        network_mode: host
        volumes:
            - '/data/cache:/opt/steamcmd/cache'
        environment:
            - STEAM_USERNAME=mysteamuser
            - STEAM_PASSWORD=hunter2
            - 'STEAM_AUTHCODE_URL=http://myauthcodeservice.example.com'
        image: 'lancachenet/steamcache-site-license:latest'
```


In these examples, the path `/data/cache` on the host will be mapped to the cache directory in the container. The Steam credentials for the site are used as environment variables.

The network settings need to be host networking on the container. This is because steam clients discover the Site License Server by listening to UDP broadcasts sent out by the license server. If networking is not host mode then the broadcasts will not be seen by your LAN.

## Supported Environment Variables

The following variables are supported to allow configuration:

 - **STEAM_USERNAME** - The username to log in to the site with
 - **STEAM_PASSWORD** - The password for the Steam user
 - **STEAM_AUTHCODE_URL** - The URL for an instance of the [Steam 2FA Auth Code Service](https://github.com/mintopia/steamcache-authcode) for the user
 - **STEAM_CACHE_SIZE_GB** - The size of the cache in GB
 - **PGID** - The group ID for the user - see below for details
 - **PUID** - The user ID for the user - see below for details

## User/Group Identifiers

To prevent any problems reading/writing data to the volume and to follow Valve's best practice, it is best to have a single user for Steam. You can specify the user ID and group ID for this user as environment variables.

## Suggested Hardware

Regular commodity hardware (a single 2TB WD Black on an HP Microserver) can achieve peak throughputs of 30MB/s+ using this setup (depending on the specific content being served).

## Monitoring

Tail the container logs to see the output from the cache server.

### Docker CLI
```
docker logs -f steamcache-server
```

### Docker Compose
```
docker-compose logs steamcache-site-license
```