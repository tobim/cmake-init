cmake_minimum_required(VERSION 3.2)

project(new_project)

MACRO(MACRO_ENSURE_OUT_OF_SOURCE_BUILD MSG)
     STRING(COMPARE EQUAL "${CMAKE_SOURCE_DIR}"
     "${CMAKE_BINARY_DIR}" insource)
     GET_FILENAME_COMPONENT(PARENTDIR ${CMAKE_SOURCE_DIR} PATH)
     STRING(COMPARE EQUAL "${CMAKE_SOURCE_DIR}"
     "${PARENTDIR}" insourcesubdir)
    IF(insource OR insourcesubdir)
        MESSAGE(FATAL_ERROR "${MSG}")
    ENDIF(insource OR insourcesubdir)
ENDMACRO(MACRO_ENSURE_OUT_OF_SOURCE_BUILD)

MACRO_ENSURE_OUT_OF_SOURCE_BUILD(
    "${CMAKE_PROJECT_NAME} requires an out of source build."
)

get_filename_component(BDNAME ${CMAKE_CURRENT_BINARY_DIR} NAME)

set(PNAME "${BDNAME}" CACHE STRING "the name for the new project")
string(TOUPPER ${PNAME} PNAME_UPPER)
string(TOLOWER ${PNAME} PNAME_LOWER)

message(STATUS "generating project ${PNAME}")
message(WARNING "please run FINALIZE.sh now!")

add_custom_target(DUMMY)
set_property(TARGET DUMMY
             PROPERTY TGT_NAME ${PNAME})

set_property(TARGET DUMMY
             PROPERTY BUILD_INTERFACE_GENERATOR
             "$<BUILD_INTERFACE:")

set_property(TARGET DUMMY
             PROPERTY INSTALL_INTERFACE_GENERATOR
             "$<INSTALL_INTERFACE:")

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/FINALIZE.sh
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../FINALIZE.sh)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/cmake/${PNAME}Config.cmake.in
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Config.cmake.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/cmake/HunterGate.cmake
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/HunterGate.cmake)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/cmake/compiler_support.cmake
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compiler_support.cmake)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CMakeLists.txt
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/CMakeLists.txt.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/test/CMakeLists.txt
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/test/CMakeLists.txt.in)

file(REMOVE ${CMAKE_CURRENT_BINARY_DIR}/Makefile)
