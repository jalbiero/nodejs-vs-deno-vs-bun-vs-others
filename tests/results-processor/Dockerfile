# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

FROM python:3.11.2-alpine3.17

RUN apk --no-cache add curl && \
    curl -sSL https://install.python-poetry.org | python -

ENV PATH="/root/.local/bin:${PATH}"
WORKDIR /opt/test

COPY . .

RUN poetry install

CMD ["poetry", "run", "app"]
