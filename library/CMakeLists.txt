cmake_minimum_required(VERSION 3.2)

set(RESOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../_resources")

set(PTYPE "library")
set(NEW_DESCRIPTION "My awesome lib" CACHE STRING "A short description of your header")
option(NEW_IDE_TARGET "Create extra target for interface includes (IDE compatibility)" ON)
set(DESC "${NEW_DESCRIPTION}")

include(${RESOURCE_DIR}/CMakeLists.common)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/include/${PROJ_NAME}/${PROJ_NAME}.hpp
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/header.hpp.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/src/${PROJ_NAME}.cpp
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/source.cpp.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/test/test.cpp
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/test/test.cpp.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/test/main.cpp
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cpp)

if(NEW_IDE_TARGET)
    set_property(TARGET DUMMY
        PROPERTY TGT_IDE "add_custom_target(${PROJ_NAME}_ide SOURCES \"include/${PROJ_NAME}/${PROJ_NAME}.hpp\")\n")
endif()
