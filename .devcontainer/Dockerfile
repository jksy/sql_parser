# Development image: Ruby plus Oracle Instant Client, so that ruby-oci8 (used by
# the Oracle connection tests under test/oracle_enhanced-adapter) can be built.
# The Oracle database itself runs in the "oracle" service (docker-compose.yml).
FROM ruby:3.4-bookworm

ARG TARGETARCH

# libaio is required by the Instant Client shared libraries.
RUN apt-get update \
 && apt-get install -y --no-install-recommends libaio1 unzip \
 && rm -rf /var/lib/apt/lists/*

# Oracle Instant Client (Basic Light, SDK and SQL*Plus). The zips are downloaded
# at build time from Oracle's public download site (no sign-in required) and are
# not redistributed with this repository. The unversioned file names always
# point at the latest release.
RUN set -eux; \
    case "$TARGETARCH" in \
      amd64) suffix=linuxx64 ;; \
      arm64) suffix=linux-arm64 ;; \
      *) echo "unsupported TARGETARCH: $TARGETARCH" >&2; exit 1 ;; \
    esac; \
    base=https://download.oracle.com/otn_software/linux/instantclient; \
    mkdir -p /opt/oracle; \
    cd /opt/oracle; \
    for pkg in basiclite sdk sqlplus; do \
      curl -fsSLO "$base/instantclient-$pkg-$suffix.zip"; \
      unzip -qo "instantclient-$pkg-$suffix.zip"; \
      rm "instantclient-$pkg-$suffix.zip"; \
    done; \
    ln -s /opt/oracle/instantclient_* /opt/oracle/instantclient; \
    echo /opt/oracle/instantclient > /etc/ld.so.conf.d/oracle-instantclient.conf; \
    ldconfig

ENV LD_LIBRARY_PATH=/opt/oracle/instantclient \
    PATH=/opt/oracle/instantclient:$PATH

# Run as a non-root user so that files written to the bind-mounted workspace
# (Gemfile.lock, coverage/, gemfiles/*.lock, ...) are not owned by root on the
# host. The devcontainer tooling remaps the UID to the host user's.
ARG USERNAME=vscode
ARG USER_UID=1000
RUN useradd --create-home --uid "$USER_UID" --shell /bin/bash "$USERNAME" \
 && chown -R "$USERNAME" "$GEM_HOME"
USER $USERNAME
