# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

VERSION = 0.1.0
NAME = jalbiero/test-bun

add-local-deps:
	if [ ! -d test_app/node_modules ]; then \
		cd test_app && bun install; \
	fi

build-image:
	docker build -t $(NAME) .

push-image:
	docker tag $(NAME) $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)
	docker tag $(NAME) $(NAME):latest
	docker push $(NAME):latest

run-image: add-local-deps
	docker run --init -it -p 8000:8000 $(NAME):latest

# Only valid if you have Bun installed on your system
run-local: add-local-deps
	cd test_app && bun run src/main.ts
