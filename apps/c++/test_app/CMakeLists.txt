# Copyright (C) 2023 Javier Albiero (jalbiero)
# Distributed under the MIT License (see the accompanying LICENSE file
# or go to http://opensource.org/licenses/MIT).

set(CMAKE_CXX_STANDARD 17)

project(TestCpp)
cmake_minimum_required(VERSION 3.0)

find_package(Drogon CONFIG REQUIRED)

add_executable(test_cpp src/main.cpp) 
target_link_libraries(test_cpp PRIVATE Drogon::Drogon)
