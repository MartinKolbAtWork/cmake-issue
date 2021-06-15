cmake_minimum_required(VERSION 3.14)

add_executable(so_test_exe
  main.cpp
)
target_link_libraries(so_test_exe PRIVATE
  wasmer_c_api
)

