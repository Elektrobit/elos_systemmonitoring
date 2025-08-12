# SPDX-License-Identifier: MIT

find_package(GTest REQUIRED)

add_executable(nightwatch_unit_tests
  application_tests.cpp
  monitoringunit_tests.cpp
  systemmonitoring_tests.cpp
)

target_link_libraries(
  nightwatch_unit_tests
  PRIVATE
    scanner_nightwatch
)

target_include_directories(
  nightwatch_unit_tests
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_link_libraries(nightwatch_unit_tests
  PRIVATE
    GTest::gtest_main
    elos::libelosplugin
    elos::libelos
    samconf::samconf
    safu::safu
)

if (YAML-CPP_VERSION VERSION_LESS "0.8.0")
  target_include_directories( nightwatch_unit_tests PRIVATE ${YAML_CPP_INCLUDE_DIR})
  target_link_libraries( nightwatch_unit_tests PRIVATE ${YAML_CPP_LIBRARIES})
else()
  target_link_libraries( nightwatch_unit_tests PRIVATE yaml-cpp::yaml-cpp)
endif()
