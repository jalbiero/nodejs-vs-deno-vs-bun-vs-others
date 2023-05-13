# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

######################################
FROM rust:1.69.0-alpine3.17 AS builder

RUN apk --no-cache add musl-dev

WORKDIR /opt/test

COPY ./test_app .

RUN cargo install --path .

#######################################
FROM alpine:3.17.1

WORKDIR /opt/test

COPY --from=builder /usr/local/cargo/bin/test_rust ./
COPY --from=builder /opt/test/Rocket.toml ./

CMD ["/opt/test/test_rust"]
