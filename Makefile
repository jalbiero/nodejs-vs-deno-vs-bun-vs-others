# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).
#

include .env # service's ports

# Global test parameters
REPORT_DIR ?= ./tests/results
TARGET_HOST ?= "172.17.0.1" # < host's localhost from the container point of view
NUM_OF_THREADS ?= 10
NUM_OF_REQS_PER_THREAD ?= 2000

# Endpoint parameters
# TODO Improve echo data
ENDP_ECHO_DATA ?= "fooooooo-data-123-123-123-12-3-123123"
ENDP_GET_PRIMES_LIMIT ?= 2000
ENDP_COUNT_PRIMES_LIMIT ?= 2000

# JMeter docker configuration
JMETER_CONTAINER_NAME ?= "test-docker-jmeter"
JMETER_IMAGE = "justb4/jmeter:5.5"
JVM_ARGS ?= "-Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m"
AS_HOST = --user $(shell id -u):$(shell id -g)

# Description: Executes JMeter
# Arg $1 = TestName
# Arg $2 = Port
FUNCTION_RUN_JMETER = \
	@echo -e "\nRunning $1...\n\n" && \
	docker run $(AS_HOST) --rm --name $(JMETER_CONTAINER_NAME) \
		-i \
		-v $(PWD):$(PWD) \
		-w $(PWD) $(JMETER_IMAGE) \
		-Dlog_level.jmeter=INFO \
		-j $(REPORT_DIR)/jmeter.log \
		-JTARGET_HOST=$(TARGET_HOST) -JTARGET_PORT=$2 \
		-JNUM_OF_THREADS=$(NUM_OF_THREADS) -JNUM_OF_REQS=$(NUM_OF_REQS_PER_THREAD) \
		-JECHO_DATA=$(ENDP_ECHO_DATA) \
		-JGET_PRIMES_LIMIT=$(ENDP_GET_PRIMES_LIMIT) \
		-JCOUNT_PRIMES_LIMIT=$(ENDP_GET_PRIMES_LIMIT) \
		-n -t tests/jmeter/test-plan.jmx -l $(REPORT_DIR)/$1.csv \
		-e -o $(REPORT_DIR)/$1

start_dockers:
ifndef DO_NOT_START_DOCKERS
	docker compose down
	docker compose up -d

# Usually, a better alternative is to include a "healthcheck" section
# in the docker compose file for each service, but this check will interfiere
# with the tests
	@echo Waiting for services
	@sleep 5
	docker-compose logs
endif

clean:
	rm -rf $(REPORT_DIR)
	mkdir -p $(REPORT_DIR)

run: start_dockers clean
	$(call FUNCTION_RUN_JMETER,bun_test,$(BUN_PORT))
	$(call FUNCTION_RUN_JMETER,cpp_test,$(CPP_PORT))
	$(call FUNCTION_RUN_JMETER,charp_test,$(CSHARP_PORT))
	$(call FUNCTION_RUN_JMETER,deno_test,$(DENO_PORT))
	$(call FUNCTION_RUN_JMETER,java_test,$(JAVA_PORT))
	$(call FUNCTION_RUN_JMETER,nodejs_test,$(NODEJS_PORT))
	$(call FUNCTION_RUN_JMETER,python_test,$(PYTHON_PORT))
	$(call FUNCTION_RUN_JMETER,rust_test,$(RUST_PORT))
	@echo -e "\n** Test Suite has finalized. Check '$(REPORT_DIR)' directory for results **\n"
