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
CMAKE_SOURCE_DIR = /home/klicia/projects/NovoTrial

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/klicia/projects/NovoTrial/build

# Include any dependencies generated for this target.
include CMakeFiles/novotrial.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/novotrial.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/novotrial.dir/flags.make

CMakeFiles/novotrial.dir/main.o: CMakeFiles/novotrial.dir/flags.make
CMakeFiles/novotrial.dir/main.o: ../main.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/klicia/projects/NovoTrial/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/novotrial.dir/main.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/novotrial.dir/main.o -c /home/klicia/projects/NovoTrial/main.cpp

CMakeFiles/novotrial.dir/main.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/novotrial.dir/main.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/klicia/projects/NovoTrial/main.cpp > CMakeFiles/novotrial.dir/main.i

CMakeFiles/novotrial.dir/main.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/novotrial.dir/main.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/klicia/projects/NovoTrial/main.cpp -o CMakeFiles/novotrial.dir/main.s

CMakeFiles/novotrial.dir/main.o.requires:
.PHONY : CMakeFiles/novotrial.dir/main.o.requires

CMakeFiles/novotrial.dir/main.o.provides: CMakeFiles/novotrial.dir/main.o.requires
	$(MAKE) -f CMakeFiles/novotrial.dir/build.make CMakeFiles/novotrial.dir/main.o.provides.build
.PHONY : CMakeFiles/novotrial.dir/main.o.provides

CMakeFiles/novotrial.dir/main.o.provides.build: CMakeFiles/novotrial.dir/main.o

# Object files for target novotrial
novotrial_OBJECTS = \
"CMakeFiles/novotrial.dir/main.o"

# External object files for target novotrial
novotrial_EXTERNAL_OBJECTS =

novotrial: CMakeFiles/novotrial.dir/main.o
novotrial: CMakeFiles/novotrial.dir/build.make
novotrial: CMakeFiles/novotrial.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable novotrial"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/novotrial.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/novotrial.dir/build: novotrial
.PHONY : CMakeFiles/novotrial.dir/build

CMakeFiles/novotrial.dir/requires: CMakeFiles/novotrial.dir/main.o.requires
.PHONY : CMakeFiles/novotrial.dir/requires

CMakeFiles/novotrial.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/novotrial.dir/cmake_clean.cmake
.PHONY : CMakeFiles/novotrial.dir/clean

CMakeFiles/novotrial.dir/depend:
	cd /home/klicia/projects/NovoTrial/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/klicia/projects/NovoTrial /home/klicia/projects/NovoTrial /home/klicia/projects/NovoTrial/build /home/klicia/projects/NovoTrial/build /home/klicia/projects/NovoTrial/build/CMakeFiles/novotrial.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/novotrial.dir/depend

