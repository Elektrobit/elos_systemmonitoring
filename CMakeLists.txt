# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.21)

project(
  system-monitoring-plugins
  DESCRIPTION "System monitoring scanner and client plugin for elos"
  LANGUAGES CXX
)

include(GNUInstallDirs)

add_subdirectory(nightwatch)
add_subdirectory(punisher)
