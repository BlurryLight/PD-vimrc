cmake_minimum_required(VERSION 3.14)

#=== vcpkg related
set(vcpkg "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
if(NOT CMAKE_TOOLCHAIN_FILE AND EXISTS "${vcpkg}")
  set(CMAKE_TOOLCHAIN_FILE "${vcpkg}"
      CACHE FILEPATH "CMake toolchain file")
  message(STATUS "vcpkg toolchain found: ${CMAKE_TOOLCHAIN_FILE}")
endif()
# toolchain file settings should be ahead of project
project(TestProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_VERBOSE_MAKEFILE ON CACHE BOOL "ON")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


if (DEFINED VCPKG_TARGET_TRIPLET) # we are using vcpkg
    message("VCPKG found!")
	#find_package(... REQUIRED)
endif (DEFINED VCPKG_TARGET_TRIPLET)
#=== vcpkg end

# == Windows related
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS on)
#

add_executable(${PROJECT_NAME} main.cc)
target_compile_definitions(${PROJECT_NAME} PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:-D_CRT_SECURE_NO_WARNINGS>")
target_compile_options(${PROJECT_NAME} PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")
target_compile_options(${PROJECT_NAME} PRIVATE "$<$<CXX_COMPILER_ID:MSVC>:/W3>")
target_compile_options(${PROJECT_NAME} PRIVATE "$<$<CXX_COMPILER_ID:GNU,Clang>:-Wall;-Wextra;-pedantic>")