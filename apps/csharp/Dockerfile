# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

#######################################
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine3.18-amd64 as builder

WORKDIR /opt/test

COPY ./test_app .

RUN dotnet build --configuration Release && \
    dotnet publish --configuration Release -o app_release

#######################################
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine3.18-amd64

WORKDIR /opt/test

COPY --from=builder /opt/test/app_release .

CMD ["./test_app", "--urls=http://0.0.0.0:8000" ]
