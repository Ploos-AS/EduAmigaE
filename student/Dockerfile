FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates python3 python3-pip python3-venv file git make \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/eduamigae/venv \
 && /opt/eduamigae/venv/bin/pip install --no-cache-dir amitools

ENV PATH="/opt/eduamigae/venv/bin:$PATH"
WORKDIR /course

COPY qualification/vamos/.vamosrc /opt/eduamigae/vamos/.vamosrc
COPY scripts/student-self-test.sh /usr/local/bin/eduamigae-self-test
COPY scripts/compile-vamos.sh /usr/local/bin/eduamigae-compile

RUN chmod 0755 /usr/local/bin/eduamigae-self-test /usr/local/bin/eduamigae-compile \
 && mkdir -p /opt/eduamigae/vamos/system /toolchains/evo

ENV VAMOS_CONFIG=/opt/eduamigae/vamos/.vamosrc
ENV VAMOS_SYSTEM=/opt/eduamigae/vamos/system
ENV EVO_HOME=/toolchains/evo/3.9.4

ENTRYPOINT ["/bin/sh"]
