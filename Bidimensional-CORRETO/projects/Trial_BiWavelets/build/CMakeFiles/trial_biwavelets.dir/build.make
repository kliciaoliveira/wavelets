# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/klicia/projects/Trial_BiWavelets

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/klicia/projects/Trial_BiWavelets/build

# Include any dependencies generated for this target.
include CMakeFiles/trial_biwavelets.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/trial_biwavelets.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/trial_biwavelets.dir/flags.make

CMakeFiles/trial_biwavelets.dir/main.o: CMakeFiles/trial_biwavelets.dir/flags.make
CMakeFiles/trial_biwavelets.dir/main.o: ../main.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/klicia/projects/Trial_BiWavelets/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/trial_biwavelets.dir/main.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/trial_biwavelets.dir/main.o -c /home/klicia/projects/Trial_BiWavelets/main.cpp

CMakeFiles/trial_biwavelets.dir/main.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/trial_biwavelets.dir/main.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/klicia/projects/Trial_BiWavelets/main.cpp > CMakeFiles/trial_biwavelets.dir/main.i

CMakeFiles/trial_biwavelets.dir/main.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/trial_biwavelets.dir/main.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/klicia/projects/Trial_BiWavelets/main.cpp -o CMakeFiles/trial_biwavelets.dir/main.s

CMakeFiles/trial_biwavelets.dir/main.o.requires:
.PHONY : CMakeFiles/trial_biwavelets.dir/main.o.requires

CMakeFiles/trial_biwavelets.dir/main.o.provides: CMakeFiles/trial_biwavelets.dir/main.o.requires
	$(MAKE) -f CMakeFiles/trial_biwavelets.dir/build.make CMakeFiles/trial_biwavelets.dir/main.o.provides.build
.PHONY : CMakeFiles/trial_biwavelets.dir/main.o.provides

CMakeFiles/trial_biwavelets.dir/main.o.provides.build: CMakeFiles/trial_biwavelets.dir/main.o

# Object files for target trial_biwavelets
trial_biwavelets_OBJECTS = \
"CMakeFiles/trial_biwavelets.dir/main.o"

# External object files for target trial_biwavelets
trial_biwavelets_EXTERNAL_OBJECTS =

trial_biwavelets: CMakeFiles/trial_biwavelets.dir/main.o
trial_biwavelets: CMakeFiles/trial_biwavelets.dir/build.make
trial_biwavelets: CMakeFiles/trial_biwavelets.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable trial_biwavelets"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/trial_biwavelets.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/trial_biwavelets.dir/build: trial_biwavelets
.PHONY : CMakeFiles/trial_biwavelets.dir/build

CMakeFiles/trial_biwavelets.dir/requires: CMakeFiles/trial_biwavelets.dir/main.o.requires
.PHONY : CMakeFiles/trial_biwavelets.dir/requires

CMakeFiles/trial_biwavelets.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/trial_biwavelets.dir/cmake_clean.cmake
.PHONY : CMakeFiles/trial_biwavelets.dir/clean

CMakeFiles/trial_biwavelets.dir/depend:
	cd /home/klicia/projects/Trial_BiWavelets/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/klicia/projects/Trial_BiWavelets /home/klicia/projects/Trial_BiWavelets /home/klicia/projects/Trial_BiWavelets/build /home/klicia/projects/Trial_BiWavelets/build /home/klicia/projects/Trial_BiWavelets/build/CMakeFiles/trial_biwavelets.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/trial_biwavelets.dir/depend
