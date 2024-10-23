cmake_minimum_required(VERSION 3.28.3)
project(sockets)

if ("${CMAKE_BUILD_TYPE}" STREQUAL "")
	message("BUILD FAILED! Parameter CMAKE_BUILD_TYPE not specified")
	return()
elseif(NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Debug" AND NOT "${CMAKE_BUILD_TYPE}" STREQUAL "Release") 
	message("BUILD FAILED! target build type unsupported. Use: 'Debug' or 'Release'")
	return()
endif()

if ("${CMAKE_SYSTEM_NAME}" STREQUAL "")
	message("BUILD FAILED! Parameter CMAKE_SYSTEM_NAME cannot be empty. To specify use e.g. -DCMAKE_SYSTEM_NAME=Linux")
	return()
elseif(NOT "${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
	message("BUILD FAILED! Unsupported target system. Currently supported: Linux")
	return()
endif()

if ("${CMAKE_SYSTEM_VERSION}" STREQUAL "")
	message("BUILD FAILED! Parameter CMAKE_SYSTEM_VERSION not specified")
	return()
endif()

if ("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "")
	message("BUILD FAILED! Parameter CMAKE_SYSTEM_PROCESSOR not specified")
	return()
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	message("building debug")
	set(project_name "sockets-d")
elseif("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
	message("building release")
	set(project_name "sockets")
else()
	# currently no other build types are supported. 
	# cmake build command will return early
	message("building ${CMAKE_BUILD_TYPE}")
	set(project_name "sockets-${CMAKE_BUILD_TYPE}")
endif()

# enable_testing()

# message(CMAKE_CURRENT_SOURCE_DIR:  ${CMAKE_CURRENT_SOURCE_DIR})
cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH CMAKE_CURRENT_SOURCE_DIR)
set(CMAKE_CURRENT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/source)
message(CMAKE_CURRENT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

message(CMAKE_CURRENT_BINARY_DIR:  ${CMAKE_CURRENT_BINARY_DIR})
cmake_path(GET CMAKE_CURRENT_BINARY_DIR PARENT_PATH CMAKE_CURRENT_BINARY_DIR)
cmake_path(GET CMAKE_CURRENT_BINARY_DIR PARENT_PATH CMAKE_CURRENT_BINARY_DIR)
set(CMAKE_CURRENT_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/bin)
message(CMAKE_CURRENT_BINARY_DIR:  ${CMAKE_CURRENT_BINARY_DIR})


# https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM_VERSION.html#variable:CMAKE_SYSTEM_VERSION
# When the CMAKE_SYSTEM_NAME variable is set explicitly to enable cross compiling 
# then the value of CMAKE_SYSTEM_VERSION must also be set explicitly to specify the target system version.

message(CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME})
message(CMAKE_SYSTEM_VERSION: ${CMAKE_SYSTEM_VERSION})
message(CMAKE_SYSTEM_PROCESSOR : ${CMAKE_SYSTEM_PROCESSOR})
# message(CMAKE_GENERATOR_PLATFORM: ${CMAKE_GENERATOR_PLATFORM})

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}/${CMAKE_SYSTEM_NAME}/${CMAKE_SYSTEM_PROCESSOR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}/${CMAKE_SYSTEM_NAME}/${CMAKE_SYSTEM_PROCESSOR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}/${CMAKE_SYSTEM_NAME}/${CMAKE_SYSTEM_PROCESSOR})

# message(CMAKE_ARCHIVE_OUTPUT_DIRECTORY: ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
# message(CMAKE_LIBRARY_OUTPUT_DIRECTORY: ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
# message(CMAKE_RUNTIME_OUTPUT_DIRECTORY: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})


set(PROJECT_SOURCE_FILES 
	main.c
)

block(PROPAGATE PROJECT_SOURCE_FILES)
	set(templist)
	foreach(file ${PROJECT_SOURCE_FILES})
	list(APPEND  templist ${CMAKE_CURRENT_SOURCE_DIR}/${file})
	endforeach()
	set(PROJECT_SOURCE_FILES ${templist})
endblock()

add_executable("${project_name}.bin" ${PROJECT_SOURCE_FILES} )

# it's to determine output of static libs
# ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}" 
# if I understand correctly it's for DLLs
# LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"

set_target_properties("${project_name}.bin"
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
)
