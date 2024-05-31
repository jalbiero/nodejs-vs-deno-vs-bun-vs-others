# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

FROM node:20.14.0-alpine3.20

WORKDIR /opt/test

COPY ./test_app/ .

RUN npm install -g typescript && \
    npm install && \
    tsc

CMD ["npm", "run", "app"]
