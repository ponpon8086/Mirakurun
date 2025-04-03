ARG ARCH=
FROM ${ARCH}node:22.14.0-bookworm AS build
WORKDIR /app
ENV DOCKER=YES NODE_ENV=production
ADD . .
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends build-essential \
    git \
    cmake \
    autoconf \
    automake \
    libpcsclite-dev && \
    mkdir /buildwork && \
    cd /buildwork && \
    git clone https://github.com/stz2012/libarib25.git && \
    cd libarib25 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../ && \
    git clone https://github.com/stz2012/recpt1.git && \
    cd recpt1/recpt1 && \
    ./autogen.sh && \
    ./configure --enable-b25 --prefix /opt && \
    make && \
    mkdir -p /opt/bin && \
    make install && \
    cd /app && \
    npm ci --include=dev && \
    npm run build && \
    npm ci --omit=dev

FROM ${ARCH}node:22.14.0-bookworm-slim
WORKDIR /app
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        make \
        gcc \
        g++ \
        pkg-config \
        pcscd \
        libpcsclite-dev \
        libccid \
        libdvbv5-dev \
        pcsc-tools \
        dvb-tools \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /app /app
COPY --from=build /opt/bin/* /usr/local/bin
COPY --from=build /buildwork/libarib25/build /tmp/libarib25
RUN ./libarib25_install.sh
CMD ["./docker/container-init.sh"]
EXPOSE 40772 9229
