# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

FROM jarredsumner/bun:0.5.1

WORKDIR /opt/test

COPY ./test_app .

RUN bun install

CMD ["bun", "run", "src/main.ts"]
