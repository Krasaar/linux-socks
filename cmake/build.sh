#! /bin/bash

build_type="$1"
if [ -z "$build_type" ]; then
	build_type="Debug"
fi

if [ ! -d cmake/generated ]; then
  mkdir cmake/cmake_auto_generated
fi
cmake -B cmake/cmake_auto_generated -S cmake -DCMAKE_BUILD_TYPE=$build_type
cmake --build cmake/cmake_auto_generated