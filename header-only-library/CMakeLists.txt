cmake_minimum_required(VERSION 3.2)

include(../CMakeLists.txt)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/include/${PNAME}/${PNAME}.hpp
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/header.hpp.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/test/test.cpp
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/test/test.cpp.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/test/main.cpp
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cpp)

