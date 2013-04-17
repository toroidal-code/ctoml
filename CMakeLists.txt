CMAKE_MINIMUM_REQUIRED( VERSION 2.6 )
PROJECT (ctoml)

# Version
SET(ctoml_VERSION_MAJOR 0)
SET(ctoml_VERSION_MINOR 1)

# Default build config
if (NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type selected, default to Release")
  set(CMAKE_BUILD_TYPE "Release")
endif()

# Some compiler flags
SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x" )
set( CMAKE_CXX_FLAGS_DEBUG "-O2 -Wall -Wextra -pedantic -g" )
set( CMAKE_CXX_FLAGS_RELEASE "-O2 -Wall -fomit-frame-pointer -DNDEBUG" )
set( CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELEASE} -g" )

# put all the new executables into a bin folder
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin )

# ctoml libraries
SET( ctoml_SOURCES src/toml.cc src/tomlvalue.cc )
#ADD_LIBRARY( ctoml STATIC ${ctoml_SOURCES} )
ADD_LIBRARY( ctoml SHARED ${ctoml_SOURCES} )

# tomlparse tool
ADD_EXECUTABLE( tomlparse src/main.cc ${ctoml_SOURCES} )
TARGET_LINK_LIBRARIES( tomlparse ctoml )


# Copy our .a to lib
INSTALL(
  TARGETS ctoml
  DESTINATION lib
  CONFIGURATIONS Release)

# Copy our *.h files to include
IF(UNIX)
	SET(INCLUDE_DIR /usr/local/include/ctoml/)
ELSE(UNIX)
	SET(INCLUDE_DIR include/)
ENDIF(UNIX)

SET(ctoml_HEADERS src/include/toml.h src/include/tomlvalue.h)
INSTALL(
  FILES ${ctoml_HEADERS}
  DESTINATION ${INCLUDE_DIR}
  CONFIGURATIONS Release)


# Tests
ADD_EXECUTABLE( ctomltest test/main.cc )
TARGET_LINK_LIBRARIES( ctomltest ctoml )
CONFIGURE_FILE(test/tests.toml ${EXECUTABLE_OUTPUT_PATH}/tests.toml COPYONLY)
CONFIGURE_FILE(test/example.toml ${EXECUTABLE_OUTPUT_PATH}/example.toml COPYONLY)
ADD_TEST(test ${EXECUTABLE_OUTPUT_PATH}/ctomltest)

# The distclean target
IF (UNIX)
  ADD_CUSTOM_TARGET (distclean @echo cleaning for source distribution)
  SET(distcleaned
   cmake.depends
   cmake.check_depends
   CMakeCache.txt
   cmake.check_cache
   *.cmake
   Makefile
   core core.*
   gmon.out
   *~
  )
  
  ADD_CUSTOM_COMMAND(
    DEPENDS clean
    COMMENT "distribution clean"
    COMMAND rm
    ARGS    -Rf CMakeFiles CMakeTmp ${DISTCLEANED}
    TARGET  distclean
  )
ENDIF(UNIX)