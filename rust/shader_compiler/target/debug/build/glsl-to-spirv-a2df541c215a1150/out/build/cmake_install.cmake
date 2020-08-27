# Install script for directory: /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang

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

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/External/cmake_install.cmake")
  include("/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/glslang/cmake_install.cmake")
  include("/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/OGLCompilersDLL/cmake_install.cmake")
  include("/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/StandAlone/cmake_install.cmake")
  include("/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/SPIRV/cmake_install.cmake")
  include("/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/hlsl/cmake_install.cmake")
  include("/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/gtests/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/alexmurz/Documents/code/lib/rust/game_engine/shader_compiler/target/debug/build/glsl-to-spirv-a2df541c215a1150/out/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
