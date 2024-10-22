#! /bin/bash

if [ ! -d cmake/generated ]; then
  mkdir cmake/cmake_auto_generated
fi
cmake -B cmake/cmake_auto_generated -S cmake -DCMAKE_BUILD_TYPE=Debug
cmake --build cmake/cmake_auto_generated