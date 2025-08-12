# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.21)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(
  nightwatch-scanner
  DESCRIPTION "A memory & CPU monitoring scanner plugin for elos"
  LANGUAGES CXX
)
set(ELOSD_SCANNER_PATH ${CMAKE_INSTALL_FULL_LIBDIR}/elos/scanner)

find_package(libelosplugin 1.1.1 REQUIRED)
find_package(libelos REQUIRED)
find_package(safu 0.54.0 REQUIRED)
find_package(samconf 0.53.1 REQUIRED)
find_package(YAML-CPP 0.7.0 REQUIRED)

add_library(
  scanner_nightwatch SHARED
  src/nightwatchScanner.cpp
  src/systemMonitoring.cpp
  src/monitoringUnit.cpp
  src/application.cpp
)

set_target_properties(scanner_nightwatch PROPERTIES PREFIX "")


target_link_libraries(
  scanner_nightwatch
  PRIVATE
    elos::libelosplugin
    elos::libelos
    samconf::samconf
    safu::safu
)
target_include_directories(
  scanner_nightwatch
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

if (YAML-CPP_VERSION VERSION_LESS "0.8.0")
  target_include_directories( scanner_nightwatch PRIVATE ${YAML_CPP_INCLUDE_DIR})
  target_link_libraries( scanner_nightwatch PRIVATE ${YAML_CPP_LIBRARIES})
else()
  target_link_libraries( scanner_nightwatch PRIVATE yaml-cpp::yaml-cpp)
endif()

target_compile_definitions(scanner_nightwatch PRIVATE SAFU_LOG=1)
target_compile_options(scanner_nightwatch PRIVATE -Wall -Wextra -Wpedantic -Werror)

install(TARGETS scanner_nightwatch DESTINATION ${ELOSD_SCANNER_PATH})
install(FILES ./config/config.yaml DESTINATION ${CMAKE_INSTALL_FULL_SYSCONFDIR}/elos/nightwatch)

add_subdirectory(tests)
