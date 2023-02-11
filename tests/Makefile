# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).
#
# Makefile based on https://raw.githubusercontent.com/justb4/docker-jmeter/master/Makefile

TARGET_HOST ?= "127.0.0.1"
TARGET_PORT ?= "8001"
THREADS ?= "1"
CONTAINER_NAME ?= "docker-jmeter"
IMAGE = "justb4/jmeter:5.5"
TEST ?= trivial
JVM_ARGS ?= "-Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m"
TARGET_PATH ?= "/index.html"
TARGET_KEYWORD ?= "domain"

#TEST_DIR = tests/$(TEST)
TEST_DIR = jmeter

REPORT_DIR=$(TEST_DIR)/report

start_dockers:
ifndef DO_NOT_START_DOCKERS
	docker-compose down
	docker-compose up -d
# 	
# 	@echo Waiting for services
# 	@sleep 5 # nasty fixed wait
# 	docker-compose logs
	
endif

all: clean run report

clean:
	@rm -rf $(REPORT_DIR) $(TEST_DIR)/test-plan.jtl $(TEST_DIR)/jmeter.log

run: start_dockers
	@mkdir -p $(REPORT_DIR)
	docker run --rm --name $(CONTAINER_NAME) -i -v $(PWD):$(PWD) -w $(PWD) $(IMAGE) \
		-Dlog_level.jmeter=DEBUG \
		-JTARGET_HOST=${TARGET_HOST} -JTARGET_PORT=${TARGET_PORT} \
		-JTARGET_PATH=${TARGET_PATH} -JTARGET_KEYWORD=${TARGET_KEYWORD} \
		-JTHREADS=$(THREADS) \
		-n -t $(TEST_DIR)/test-plan.jmx -l $(TEST_DIR)/test-plan.jtl -j $(TEST_DIR)/jmeter.log \
		-e -o $(REPORT_DIR)

report:
	echo "==== jmeter.log ===="
	cat $(TEST_DIR)/jmeter.log
	echo "==== Raw Test Report ===="
	cat $(TEST_DIR)/test-plan.jtl
	echo "==== HTML Test Report ===="
	echo "See HTML test report in $(REPORT_DIR)/index.html"



start_all_local_tests:: start_dockers
	docker 
