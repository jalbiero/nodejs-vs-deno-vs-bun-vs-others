# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

#######################################
FROM openjdk:19-slim AS builder

WORKDIR /opt/test

COPY ./test_app .

RUN ./gradlew task bootJar

#######################################
FROM openjdk:19-slim

WORKDIR /opt/test

COPY --from=builder /opt/test/build/libs/test_app-0.0.1-SNAPSHOT.jar /opt/test/test_app.jar

CMD ["java", "-jar", "/opt/test/test_app.jar"]

