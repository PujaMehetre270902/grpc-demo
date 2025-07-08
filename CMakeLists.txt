cmake_minimum_required(VERSION 3.10)

project(MygrpcApp)

set(CMAKE_CXX_STANDARD 17)

enable_testing()

include_directories(/usr/local/include)

add_library(vehicle_controller src/vehicle_controller.cpp)

add_executable(vehicle_controller_tests tests/test_vehicle_controller.cpp)

target_link_libraries(vehicle_controller_tests PRIVATE vehicle_controller)

add_test(NAME vehicle_controller_tests COMMAND vehicle_controller_tests)