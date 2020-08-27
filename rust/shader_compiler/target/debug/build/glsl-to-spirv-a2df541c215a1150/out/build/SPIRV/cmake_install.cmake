# Install script for directory: /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/SPIRV/libSPIRV.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/SPIRV/libSPVRemapper.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/SPIRV" TYPE FILE FILES
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/bitutils.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/spirv.hpp"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/GLSL.std.450.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/GLSL.ext.KHR.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/GlslangToSpv.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/hex_float.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/Logger.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/SpvBuilder.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/spvIR.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/doc.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/disassemble.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/GLSL.ext.AMD.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/GLSL.ext.NV.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/SPVRemapper.h"
    "/home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/doc.h"
    )
endif()

