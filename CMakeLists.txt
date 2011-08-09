cmake_minimum_required(VERSION 2.6)

# If project name is not passed as -DRedBoxApp_PROJECT_NAME
if(NOT RedBoxApp_PROJECT_NAME)
	# Try ENV
	SET(RedBoxApp_PROJECT_NAME "$ENV{PROJECT_NAME}")
	# If not set as env
	if(NOT RedBoxApp_PROJECT_NAME)
		# We set it to the default.
		SET(RedBoxApp_PROJECT_NAME "RedBoxApp")
	endif(NOT RedBoxApp_PROJECT_NAME)
endif(NOT RedBoxApp_PROJECT_NAME)
project(${RedBoxApp_PROJECT_NAME})

# Binary file name
if(NOT RedBoxApp_BINNAME)
	SET(RedBoxApp_BINNAME "$ENV{BINARY_NAME}")
endif(NOT RedBoxApp_BINNAME)
if(NOT RedBoxApp_BINNAME)
	SET(RedBoxApp_BINNAME "${CMAKE_PROJECT_NAME}")
endif(NOT RedBoxApp_BINNAME)

# Default build is SDL. If none set, set SDL
if(NOT iphone AND NOT QT AND NOT SDL)
	set(SDL 1)
endif(NOT iphone AND NOT QT AND NOT SDL)
if(NOT CURRENT_PLATFORM)
	set(CURRENT_PLATFORM "SDL")
endif(NOT CURRENT_PLATFORM)

# Include a useful function module
set(CMAKE_MODULE_PATH "${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/script/CMake/module/")
include(Function)

# We force the build type to be at least debug if not set.
if(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Debug CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
      FORCE)
endif(NOT CMAKE_BUILD_TYPE)

# Define the DEBUG symbol if necessary.
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	ADD_DEFINITIONS("-DDEBUG")
	if(NOT WIN32)
		set(CMAKE_CXX_FLAGS_DEBUG "-g -rdynamic")
	endif(NOT WIN32)
endif("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")

# Fix for an Xcode problem.
if("${CMAKE_GENERATOR}" STREQUAL "Xcode")
	set(EXECUTABLE_OUTPUT_PATH  ${${CMAKE_PROJECT_NAME}_BINARY_DIR}/bin/)
else()
	set(EXECUTABLE_OUTPUT_PATH  ${${CMAKE_PROJECT_NAME}_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE})
endif("${CMAKE_GENERATOR}" STREQUAL "Xcode")


# Begin building libraries with libbuildtool
if(iphone)
	if(NOT IS_DIRECTORY ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/ios/universal)
		execute_process(COMMAND	${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/script/libbuildtool/iphone-universal)
	endif(NOT IS_DIRECTORY ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/ios/universal)
else(iphone)
	if(NOT IS_DIRECTORY ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/current)
	message(STATUS "${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/script/libbuildtool/current")
		execute_process(COMMAND	${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/script/libbuildtool/current)
	endif(NOT IS_DIRECTORY ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/current)
endif(iphone)
# End libbuildtool


# Loading platform-specific parts
if(NOT EXISTS "${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/script/CMake/parts/${CURRENT_PLATFORM}.cmake")
	message(FATAL_ERROR "Platform '${CURRENT_PLATFORM}' is not a valid platform.")
endif(NOT EXISTS "${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/script/CMake/parts/${CURRENT_PLATFORM}.cmake")

include("${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/script/CMake/parts/${CURRENT_PLATFORM}.cmake")



file(GLOB RedBoxApp_resources ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/resources/*)
source_group(Resources FILES ${RedBoxApp_resources})

file(GLOB RedBoxApp_application_sources ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/application/*.cpp)
list(APPEND RedBoxApp_sources ${RedBoxApp_application_sources})
file(GLOB RedBoxApp_application_headers ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/application/*.h)
list(APPEND RedBoxApp_headers ${RedBoxApp_application_headers})
source_group(application FILES ${RedBoxApp_application_headers} ${RedBoxApp_application_sources})


# Include directories
INCLUDE_DIRECTORIES(${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/application)
INCLUDE_DIRECTORIES(${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/current/include/)
# System libraries include directories. (built beforehand)
INCLUDE_DIRECTORIES(${RedBoxApp_IncludeDir_list})

# Link directories
   link_directories(${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/current/lib/)

# Dev mode helper
# If redbox is available as a directory in the libraries folder, we use its build.
# Make sure that redbox is not also built using libbuildtool, this would be an undocumented comportment.
INCLUDE_DIRECTORIES(${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/redbox/build/${CMAKE_BUILD_TYPE}/include/)
   link_directories(${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/redbox/build/lib/${CMAKE_BUILD_TYPE})

if(INCLUDE_REDBOX)
	set(RedBox_directory ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/libraries/redbox/)
	if(EXISTS "${RedBox_directory}")
		message(STATUS "RedBox libraries... found")
	else(EXISTS "${RedBox_directory}")
		message(STATUS "RedBox libraries... not found")
		message(FATAL_ERROR "${RedBox_directory} was not found.")
	endif(EXISTS "${RedBox_directory}")

	add_subdirectory(${RedBox_directory} ${${CMAKE_PROJECT_NAME}_BINARY_DIR}/RedBox)	

	INCLUDE_DIRECTORIES(${RedBox_BINARY_DIR}/Dependencies/include)
	INCLUDE_DIRECTORIES(${RedBox_BINARY_DIR}/${CMAKE_BUILD_TYPE}/include)
	link_directories(${RedBox_BINARY_DIR}/${CMAKE_BUILD_TYPE}/lib)
	link_directories(${RedBox_BINARY_DIR}/Dependencies/lib/)
endif(INCLUDE_REDBOX)

if(APPLE)
	set_source_files_properties(
	${RedBoxApp_resources}
	 PROPERTIES
	  MACOSX_PACKAGE_LOCATION Resources
	)

else()
	copy(${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/resources ${EXECUTABLE_OUTPUT_PATH}/resources)
endif(APPLE)


if(APPLE)
	add_executable(
		${RedBoxApp_BINNAME}
		MACOSX_BUNDLE
		${RedBoxApp_sources}
		${RedBoxApp_headers}
		${RedBoxApp_resources}
	)
elseif(WIN32)
	add_executable(
			${RedBoxApp_BINNAME}
			WIN32
			${RedBoxApp_sources}
			${RedBoxApp_headers}
			${RedBoxApp_resources}
	)
else()
	add_executable(
		${RedBoxApp_BINNAME}
		${RedBoxApp_sources}
		${RedBoxApp_headers}
		${RedBoxApp_resources}
	)
endif(APPLE)

target_link_libraries(
	${RedBoxApp_BINNAME}
	RedBox
	${RedBoxApp_libraries_list}
	)

add_dependencies(${RedBoxApp_BINNAME} RedBox)


# -------------------------------------
# Install rules

SET(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/)

SET(RedBoxApp_APP "\${CMAKE_INSTALL_PREFIX}/${RedBoxApp_BINNAME}")
IF(APPLE)
	SET(RedBoxApp_APP "\${CMAKE_INSTALL_PREFIX}/${RedBoxApp_BINNAME}.app")
ENDIF(APPLE)
IF(WIN32)
	SET(RedBoxApp_APP "\${CMAKE_INSTALL_PREFIX}/${RedBoxApp_BINNAME}.exe")
ENDIF(WIN32)

IF(APPLE)
INSTALL(CODE "
    include(BundleUtilities)
    fixup_bundle(\"${RedBoxApp_APP}\" \"\${QTPLUGINS}\" \"${DIRS}\")
    " COMPONENT Runtime)
ENDIF(APPLE)
