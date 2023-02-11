# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

#######################################
FROM alpine:3.17.1 AS builder

RUN apk --no-cache add \
    cmake \
    g++ \
    gcc \
    git \
    jsoncpp-dev \
    make \
    pkgconfig \
    util-linux-dev \
    zlib-dev 
    
RUN git clone https://github.com/an-tao/drogon /usr/local/src/drogon && \
    cd /usr/local/src/drogon && \
    sed -i 's/bash/sh/' ./build.sh && \
    ./build.sh

WORKDIR /opt/test

COPY ./test_app .

RUN mkdir -p build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make

#######################################
FROM alpine:3.17.1

RUN apk --no-cache add libgcc libstdc++ jsoncpp libuuid

COPY --from=builder /opt/test/build/test_cpp /opt/test

CMD ["/opt/test/test_cpp"]