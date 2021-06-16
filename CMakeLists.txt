cmake_minimum_required(VERSION 3.14)

# ********************
# Project Setup
# ********************
project(
  so_test
  LANGUAGES CXX
)

# ************************************************************************************************************
# Wasmer
# ************************************************************************************************************
add_library(wasmer_c_api SHARED IMPORTED)
set_target_properties(wasmer_c_api PROPERTIES
  IMPORTED_LOCATION "${CMAKE_SOURCE_DIR}/wasmer/lib/libwasmer.so"
  INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_SOURCE_DIR}/wasmer/include"
)

add_subdirectory(so_test_exe)
