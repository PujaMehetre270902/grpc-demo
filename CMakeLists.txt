cmake_minimum_required(VERSION 3.10)

project(MygrpcApp)

set(CMAKE_CXX_STANDARD 17)

add_library(vehicle_controller src/vehicle_controller.cpp)

enable_testing()

add_executable(tests test_vehicle_controller.cpp)

target_link_libraries(tests vehicle_controller)

find_package(Catch2 REQUIRES)

target_link_libraries(tests Catch2::Catch2)

include(CTest)