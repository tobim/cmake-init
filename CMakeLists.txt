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

function(username dst)
    if(UNIX)
        set(USER $ENV{USER})
        execute_process(COMMAND getent passwd ${USER} COMMAND cut -d : -f 5 COMMAND cut -d , -f 1 OUTPUT_VARIABLE USER)
        string(REGEX REPLACE "\n$" "" USER ${USER})
        if("${USER}" STREQUAL "")
            set(USER $ENV{USER})
        endif()
    else(WIN32)
        set(USER $ENV{USERNAME})
    endif()
    set(${dst} ${USER} PARENT_SCOPE)
endfunction(username)

username(AUTHOR)

set(LICENSE "Boost Software License 1.0" CACHE STRING "the license for your project (choosealicense.com)")
set_property(CACHE LICENSE PROPERTY STRINGS "Boost Software License 1.0" "Apache License, Version 2.0" "MIT License" "GNU General Public License, version 3.0" "GNU Affero General Public License, version 3.0" "GNU Lesser General Public License, version 3.0" "GNU General Public License, version 2.0" "GNU Lesser General Public License, version 2.1" "CC0" "BSD 3-Clause" "BSD 2-Clause")

message(STATUS "generating project ${PNAME}")

add_custom_target(DUMMY)
set_property(TARGET DUMMY
             PROPERTY TGT_NAME ${PNAME})

set_property(TARGET DUMMY
             PROPERTY BUILD_INTERFACE_GENERATOR
             "$<BUILD_INTERFACE:")

set_property(TARGET DUMMY
             PROPERTY INSTALL_INTERFACE_GENERATOR
             "$<INSTALL_INTERFACE:")

string(TIMESTAMP YEAR %Y)
set_property(TARGET DUMMY
             PROPERTY YEAR ${YEAR})


if(LICENSE STREQUAL "Boost Software License 1.0")
    file(STRINGS ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/boost/notice.txt NOTICE NEWLINE_CONSUME)
    string(CONFIGURE ${NOTICE} NOTICE @ONLY)
    set_property(TARGET DUMMY
                PROPERTY NOTICE ${NOTICE})
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/LICENSE_1_0.txt
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/boost/LICENSE_1_0.txt)
elseif(LICENSE STREQUAL "Apache License, Version 2.0")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/LICENSE
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/apache/LICENSE-2.0.txt)
elseif(LICENSE STREQUAL "MIT License")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/LICENSE
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/mit/LICENSE.txt)
elseif(LICENSE STREQUAL "GNU General Public License, version 3.0")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/COPYING
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/gnu/gpl-3.0.txt)
elseif(LICENSE STREQUAL "GNU Affero General Public License, version 3.0")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/COPYING
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/gnu/agpl-3.0.txt)
elseif(LICENSE STREQUAL "GNU Lesser General Public License, version 3.0")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/COPYING
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/gnu/gpl-3.0.txt)
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/COPYING.Lesser
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/gnu/lgpl-3.0.txt)
elseif(LICENSE STREQUAL "GNU General Public License, version 2.0")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/COPYING
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/gnu/gpl-2.0.txt)
elseif(LICENSE STREQUAL "GNU Lesser General Public License, version 2.1")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/COPYING
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/gnu/gpl-2.0.txt)
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/COPYING.Lesser
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/gnu/lgpl-2.1.txt)
elseif(LICENSE STREQUAL "CC0")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/LICENSE
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/creative-commons/CC0-1_0.txt)
elseif(LICENSE STREQUAL "BSD 3-Clause")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/LICENSE
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/bsd/BSD_3-Clause.txt)
elseif(LICENSE STREQUAL "BSD 2-Clause")
    file(GENERATE
         OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/LICENSE
         INPUT ${CMAKE_CURRENT_SOURCE_DIR}/../licenses/bsd/BSD_2-Clause.txt)
endif()


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
