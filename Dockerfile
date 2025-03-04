FROM steamcmd/steamcmd:latest
MAINTAINER Substitute <substitute@pocketdevs.org>

USER root
RUN \
	steamcmd +quit && \
    apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

EXPOSE \
	3128/tcp \
	27037/tcp \
	27037/udp \
	27036/tcp \
	27036/udp

ENV \
	STEAM_CACHE_SIZE_GB=1000 \
	STEAM_CACHE_CREDS=0 \
	STEAM_CACHE_IP= \
	STEAM_CACHE_EXTERNAL= \
	STEAM_USERNAME= \
	STEAM_PASSWORD= \
	STEAM_GUARD= \
	STEAM_AUTHCODE_URL=
COPY files /opt/steamcmd
RUN \
	mkdir /opt/steamcmd/cache && \
	chown -R root /opt/steamcmd && \
	chmod +x /opt/steamcmd/entrypoint.sh /opt/steamcmd/run.sh

ENTRYPOINT ["/bin/bash", "/opt/steamcmd/entrypoint.sh"]
CMD ["/bin/bash", "/opt/steamcmd/run.sh"]
