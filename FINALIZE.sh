#!/bin/bash

DIR=`dirname "$0"`

echo "running finalize in ${DIR}"

echo "removing generator artefakts"
rm "${DIR}/Makefile" || (echo "operation failed"; exit 1)

echo "removing cmake files"
rm "${DIR}/CMakeCache.txt" "${DIR}/cmake_install.cmake" -r "${DIR}/CMakeFiles" || (echo "operation failed"; exit 1)

echo "removing self"
rm "$0" || (echo "operation failed"; exit 1)
