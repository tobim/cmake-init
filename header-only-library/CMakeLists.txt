cmake_minimum_required(VERSION 3.2)

#get_filename_component(TTEMPLATE ${CMAKE_CURRENT_SOURCE_DIR} NAME)
include(../CMakeLists.txt)

configure_file(./header.hpp.in ./include/${PNAME}/${PNAME}.hpp @ONLY)
configure_file(./test/test.cpp.in ./test/test.cpp @ONLY)
configure_file(./test/main.cpp ./test/main.cpp COPYONLY)
