# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

FROM python:3.12.3-alpine3.20

RUN apk --no-cache add curl && \
    curl -sSL https://install.python-poetry.org | python -

ENV PATH="/root/.local/bin:${PATH}"
WORKDIR /opt/test

COPY ./test_app .

RUN rm -f poetry.lock && poetry install

CMD ["poetry", "run", "app"]
