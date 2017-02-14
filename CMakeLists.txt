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
configure_file(./CMakeLists.txt.in ./CMakeLists.txt @ONLY)
configure_file(./test/CMakeLists.txt.in ./test/CMakeLists.txt @ONLY)
configure_file(../cmake/HunterGate.cmake ./cmake/HunterGate.cmake COPYONLY)
configure_file(../cmake/compiler_support.cmake ./cmake/compiler_support.cmake COPYONLY)
configure_file(../cleanup_.sh ./cleanup_.sh)

execute_process(COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/../cleanup.sh
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                TIMEOUT 0.2)
