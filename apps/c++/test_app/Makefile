# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

SAMPLE_NAME = test_cpp

AS_HOST = --user $(shell id -u):$(shell id -g)

DOCKER_VERSION ?= latest
DOCKER_CONTAINER = ${SAMPLE_NAME}-sample
DOCKER_WORK_DIR = /opt/${SAMPLE_NAME}
DOCKER_COMMON = ${AS_HOST} -v `pwd`:${DOCKER_WORK_DIR} --name ${DOCKER_CONTAINER} -w ${DOCKER_WORK_DIR} drogonframework/drogon

#jalbiero/test-cpp:${DOCKER_VERSION}

build: docker-stop
	docker run ${DOCKER_COMMON} bash -c "cd build && cmake .. && make"

clean: 
	rm -rf ./build

bash: docker-stop
	docker run -it -p 8000:8000 ${DOCKER_COMMON} bash

docker-stop:
	@-docker rm -f ${DOCKER_CONTAINER}
 
