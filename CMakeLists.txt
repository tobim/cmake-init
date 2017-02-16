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

add_custom_target(DUMMY)
set_property(TARGET DUMMY
             PROPERTY TGT_NAME ${PNAME})

#configure_file(../cleanup_.sh ./cleanup_.sh)
file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/cmake/${PNAME}Config.cmake.in
     INPUT cmake/Config.cmake.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/cmake/HunterGate.cmake
     INPUT cmake/HunterGate.cmake)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/cmake/compiler_support.cmake
     INPUT cmake/compiler_support.cmake)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CMakeLists.txt
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/CMakeLists.txt.in)

file(GENERATE
     OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/test/CMakeLists.txt
     INPUT ${CMAKE_CURRENT_SOURCE_DIR}/test/CMakeLists.txt.in)

file(REMOVE ${CMAKE_CURRENT_BINARY_DIR}/Makefile)
#execute_process(COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/../cleanup.sh
#WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
#TIMEOUT 0.2)
