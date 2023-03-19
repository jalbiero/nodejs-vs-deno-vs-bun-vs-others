# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

VERSION = 0.1.0
NAME = jalbiero/test-rust

build-image:
	docker build -t $(NAME):latest .

push-image:
	docker tag $(NAME) $(NAME):$(VERSION)
	docker push $(NAME):$(VERSION)
	docker tag $(NAME) $(NAME):latest
	docker push $(NAME):latest

run-image:
	docker run --init -it -p 8000:8000 $(NAME):latest

# Only valid if you have Rust installed on your system
run-local: 
	cd test_app && cargo run
