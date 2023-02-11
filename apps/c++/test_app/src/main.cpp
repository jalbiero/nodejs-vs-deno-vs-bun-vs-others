// Copyright (C) 2023 Javier Albiero (jalbiero)
// Distributed under the MIT License (see the accompanying LICENSE file
// or go to http://opensource.org/licenses/MIT).

#include <functional>
#include <string>

#include <drogon/drogon.h>
#include "primes.hpp"

using namespace drogon;

using RespCallbackT = std::function<void(const HttpResponsePtr &)>;

const char serverHost[] = "0.0.0.0";
const int serverPort = 8000;

int main() {
    app().registerHandler(
        "/", 
        [] (const HttpRequestPtr&, RespCallbackT &&callback) {
            auto resp = HttpResponse::newHttpResponse();
            resp->setBody("C++ test");
            callback(resp);
        },
        {Get});

    app().registerHandler(
        "/getPrimesLessThan/{limit}", 
        [] (const HttpRequestPtr&, RespCallbackT &&callback, const std::string& limit) {
            try {
                auto num_limit = std::stoul(limit);
                auto primes = primes::get_primes_less_than(num_limit);

                Json::Value root;
                root["prime_less_than"] = Json::Value::UInt64(num_limit);
                root["count"] = Json::Value::UInt64(primes.size());
                root["primes"] = primes;

                callback(HttpResponse::newHttpJsonResponse(root));
            }
            catch (const std::exception& e) {
                LOG_ERROR << "Unexpected error = " << e.what();
                auto resp = HttpResponse::newHttpResponse();
                resp->setBody(e.what());
                callback(resp);
            }
        },
        {Get});

    app().registerHandler(
        "/countPrimesLessThan/{limit}", 
        [] (const HttpRequestPtr&, RespCallbackT &&callback, const std::string& limit) {
            try {
                auto num_limit = std::stoul(limit);

                Json::Value root;
                root["prime_less_than"] = Json::Value::UInt64(num_limit);
                root["count"] = Json::Value::UInt64(primes::count_primes_less_than(num_limit));

                callback(HttpResponse::newHttpJsonResponse(root));
            }
            catch (const std::exception& e) {
                LOG_ERROR << "Unexpected error = " << e.what();
                auto resp = HttpResponse::newHttpResponse();
                resp->setBody(e.what());
                callback(resp);
            }
        },
        {Get});

    LOG_INFO << "Listening on http://" << serverHost << ':' << serverPort;
    app().addListener(serverHost, serverPort).run();
}

