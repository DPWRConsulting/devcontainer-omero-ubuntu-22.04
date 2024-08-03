# docker build -t devcontainer-omero-ubuntu-22.04 . --build-arg dev-ubuntu

ARG VARIANT="0-ubuntu-22.04"
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}
LABEL org.opencontainers.image.authors="Douglas Russell <root@dpwrussell.com>" \
      org.opencontainers.image.source=https://github.com/dpwrconsulting/devcontainer-omero-ubuntu-22.04 \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="OMERO Devcontainer Image" \
      org.opencontainers.image.description="An OMERO Docker image for use with VS Code's Remote Containers extension or GitHub codespaces."
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    openjdk-11-jre \
    db5.3-util \
    bzip2 \
    libdb++ \
    libexpat1 \
    libmcpp0 \
    openssl \
    mcpp \
    zlib1g
RUN cd /tmp \
    && wget -q https://github.com/glencoesoftware/zeroc-ice-ubuntu2204-x86_64/releases/download/20221004/Ice-3.6.5-ubuntu2204-x86_64.tar.gz \
    && tar xf Ice-3.6.5-ubuntu2204-x86_64.tar.gz \
    && mv Ice-3.6.5 /opt/ice-3.6.5 \
    && echo /opt/ice-3.6.5/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf \
    && ldconfig
ENV ICE_HOME=/opt/ice-3.6.5		
ENV PATH="$ICE_HOME/bin:$PATH"	
ENV SLICEPATH="$ICE_HOME/slice"
