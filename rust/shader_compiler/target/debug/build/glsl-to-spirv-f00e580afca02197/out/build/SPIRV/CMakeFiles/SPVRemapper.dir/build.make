# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build

# Include any dependencies generated for this target.
include SPIRV/CMakeFiles/SPVRemapper.dir/depend.make

# Include the progress variables for this target.
include SPIRV/CMakeFiles/SPVRemapper.dir/progress.make

# Include the compile flags for this target's objects.
include SPIRV/CMakeFiles/SPVRemapper.dir/flags.make

SPIRV/CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.o: SPIRV/CMakeFiles/SPVRemapper.dir/flags.make
SPIRV/CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.o: /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/SPVRemapper.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object SPIRV/CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.o"
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.o -c /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/SPVRemapper.cpp

SPIRV/CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.i"
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/SPVRemapper.cpp > CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.i

SPIRV/CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.s"
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/SPVRemapper.cpp -o CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.s

SPIRV/CMakeFiles/SPVRemapper.dir/doc.cpp.o: SPIRV/CMakeFiles/SPVRemapper.dir/flags.make
SPIRV/CMakeFiles/SPVRemapper.dir/doc.cpp.o: /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/doc.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object SPIRV/CMakeFiles/SPVRemapper.dir/doc.cpp.o"
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/SPVRemapper.dir/doc.cpp.o -c /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/doc.cpp

SPIRV/CMakeFiles/SPVRemapper.dir/doc.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/SPVRemapper.dir/doc.cpp.i"
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/doc.cpp > CMakeFiles/SPVRemapper.dir/doc.cpp.i

SPIRV/CMakeFiles/SPVRemapper.dir/doc.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/SPVRemapper.dir/doc.cpp.s"
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV/doc.cpp -o CMakeFiles/SPVRemapper.dir/doc.cpp.s

# Object files for target SPVRemapper
SPVRemapper_OBJECTS = \
"CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.o" \
"CMakeFiles/SPVRemapper.dir/doc.cpp.o"

# External object files for target SPVRemapper
SPVRemapper_EXTERNAL_OBJECTS =

SPIRV/libSPVRemapper.a: SPIRV/CMakeFiles/SPVRemapper.dir/SPVRemapper.cpp.o
SPIRV/libSPVRemapper.a: SPIRV/CMakeFiles/SPVRemapper.dir/doc.cpp.o
SPIRV/libSPVRemapper.a: SPIRV/CMakeFiles/SPVRemapper.dir/build.make
SPIRV/libSPVRemapper.a: SPIRV/CMakeFiles/SPVRemapper.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX static library libSPVRemapper.a"
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && $(CMAKE_COMMAND) -P CMakeFiles/SPVRemapper.dir/cmake_clean_target.cmake
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/SPVRemapper.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
SPIRV/CMakeFiles/SPVRemapper.dir/build: SPIRV/libSPVRemapper.a

.PHONY : SPIRV/CMakeFiles/SPVRemapper.dir/build

SPIRV/CMakeFiles/SPVRemapper.dir/clean:
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV && $(CMAKE_COMMAND) -P CMakeFiles/SPVRemapper.dir/cmake_clean.cmake
.PHONY : SPIRV/CMakeFiles/SPVRemapper.dir/clean

SPIRV/CMakeFiles/SPVRemapper.dir/depend:
	cd /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang /home/alexmurz/.cargo/registry/src/github.com-1ecc6299db9ec823/glsl-to-spirv-0.1.7/glslang/SPIRV /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV /home/alexmurz/Documents/code/simd_bench/rust/shader_compiler/target/debug/build/glsl-to-spirv-f00e580afca02197/out/build/SPIRV/CMakeFiles/SPVRemapper.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : SPIRV/CMakeFiles/SPVRemapper.dir/depend
