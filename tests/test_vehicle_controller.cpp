#define CATCH_CONFIG_MAIN
#include <catch2/catch.hpp>  //modern lightweight c++testing framework
#include "../src/vehicle_controller.h"

TEST_CASE("VehicleController start/stop works"){
    VehicleController vc;  //object of class in .h file

    REQUIRE(vc.start()==true);

    REQUIRE(vc.stop()==true);         //assertion that fails if test false
}