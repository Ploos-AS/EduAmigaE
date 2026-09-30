FROM debian:13-slim AS builder

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      python3 python3-pip python3-venv python3-dev build-essential \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/eduamigae/venv \
 && /opt/eduamigae/venv/bin/pip install --no-cache-dir 'amitools[vamos]==0.8.1'


FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates python3 file git make lhasa \
 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/eduamigae/venv /opt/eduamigae/venv

ENV PATH="/opt/eduamigae/venv/bin:$PATH"
WORKDIR /course

COPY qualification/vamos/.vamosrc /opt/eduamigae/vamos/.vamosrc
COPY scripts/student-self-test.sh /usr/local/bin/eduamigae-self-test
COPY scripts/compile-vamos.sh /usr/local/bin/eduamigae-compile
COPY scripts/import-evo.sh /usr/local/bin/eduamigae-import-evo
COPY scripts/eduamigae /usr/local/bin/eduamigae
COPY scripts/case-info.py /usr/local/lib/eduamigae/case-info.py
COPY scripts/verify-case.py /usr/local/lib/eduamigae/verify-case.py
COPY scripts/evidence-stdout.py /usr/local/lib/eduamigae/evidence-stdout.py

RUN chmod 0755 /usr/local/bin/eduamigae-self-test /usr/local/bin/eduamigae-compile /usr/local/bin/eduamigae-import-evo /usr/local/bin/eduamigae \
 && mkdir -p /opt/eduamigae/vamos/system /toolchains/evo

ENV VAMOS_CONFIG=/opt/eduamigae/vamos/.vamosrc
ENV VAMOS_SYSTEM=/opt/eduamigae/vamos/system
ENV EVO_HOME=/toolchains/evo/3.9.4

ENTRYPOINT ["/bin/sh"]
