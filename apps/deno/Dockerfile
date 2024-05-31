# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

FROM denoland/deno:1.43.6

WORKDIR /opt/test

COPY ./test_app .

# Cache dependencies
RUN deno task deps

CMD ["deno", "task", "app"]
