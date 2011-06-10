cmake_minimum_required(VERSION 2.6)
project(RedBoxApp)

# Default build is SDL. If none set, set SDL
if(NOT iphone AND NOT QT AND NOT SDL)
	set(SDL 1)
endif(NOT iphone AND NOT QT AND NOT SDL)

# Include a useful function module
set(CMAKE_MODULE_PATH "${RedBoxApp_SOURCE_DIR}/script/CMake/module/")
include(Function)

# We force the build type to be at least debug
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

if("${CMAKE_GENERATOR}" STREQUAL "Xcode")
	set(EXECUTABLE_OUTPUT_PATH  ${RedBoxApp_BINARY_DIR}/bin/)
else()
	set(EXECUTABLE_OUTPUT_PATH  ${RedBoxApp_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE})
endif("${CMAKE_GENERATOR}" STREQUAL "Xcode")


#we build dependencies with libbuildtool (only if needed)
if(iphone)
	if(NOT IS_DIRECTORY ${RedBoxApp_SOURCE_DIR}/libraries/ios/universal)
		execute_process(COMMAND	${RedBoxApp_SOURCE_DIR}/script/libbuildtool/iphone-universal)
	endif(NOT IS_DIRECTORY ${RedBoxApp_SOURCE_DIR}/libraries/ios/universal)
else()
	if(NOT IS_DIRECTORY ${RedBoxApp_SOURCE_DIR}/libraries/current)
	message(STATUS "${RedBoxApp_SOURCE_DIR}/script/libbuildtool/current")
		execute_process(COMMAND	${RedBoxApp_SOURCE_DIR}/script/libbuildtool/current)
	endif(NOT IS_DIRECTORY ${RedBoxApp_SOURCE_DIR}/libraries/current)
endif(iphone)



# Platform-specific configurations.
if(iphone)
	set(RedBoxApp_framework_list  "Foundation" "AudioToolBox" "AVFoundation" "CoreGraphics" "OpenAL" "QuartzCore" "UIKit" "OpenGLES")
	foreach(framework ${RedBoxApp_framework_list})
		findpkg_framework(${framework})		
		list(APPEND RedBoxApp_IncludeDir_list ${${framework}_FRAMEWORK_INCLUDES})
		list(APPEND RedBoxApp_libraries_list ${${framework}_LIBRARY_FWK})
	endforeach(framework)
elseif(QT)
	FIND_PACKAGE(OpenGL REQUIRED)
	list(APPEND RedBoxApp_libraries_list ${OPENGL_LIBRARY})
	FIND_PACKAGE(OpenAL REQUIRED)
	list(APPEND RedBoxApp_IncludeDir_list ${OPENAL_INCLUDE_DIR})
	list(APPEND RedBoxApp_libraries_list ${OPENAL_LIBRARY})
	
	#QT##########
	set(QT_USE_QTOPENGL TRUE)   
	set(QT 1)	
	ADD_DEFINITIONS("-DQT")
	FIND_PACKAGE( Qt4 REQUIRED)	
	INCLUDE( ${QT_USE_FILE} )

	list(APPEND RedBoxApp_IncludeDir_list ${QT_INCLUDE_DIR} ${QT_QTOPENGL_INCLUDE_DIR})
	list(APPEND RedBoxApp_libraries_list ${QT_LIBRARIES} ${QT_QTOPENGL_LIBRARY})
	set(RedBoxApp_QtSpecific_path  ${RedBoxApp_SOURCE_DIR}/ide/QtCreator/QtCreator_specific/)

	file(GLOB RedBoxApp_QT_MOC_headers ${RedBoxApp_QtSpecific_path}/*.h)
	file(GLOB RedBoxApp_QT_sources ${RedBoxApp_QtSpecific_path}/*.cpp)
	file(GLOB RedBoxApp_QT_uis ${RedBoxApp_QtSpecific_path}/*.ui)
	file(GLOB RedBoxApp_QT_QRC ${RedBoxApp_QtSpecific_path}/*.qrc)

	QT4_ADD_RESOURCES( RedBoxApp_QT_RC_sources ${RedBoxApp_QT_QRC})
	QT4_WRAP_UI( RedBoxApp_QT_uis_headers ${RedBoxApp_QT_uis} )
	QT4_WRAP_CPP( RedBoxApp_QT_MOC_sources ${RedBoxApp_QT_MOC_headers})
	INCLUDE_DIRECTORIES( ${CMAKE_BINARY_DIR} )

	list(APPEND RedBoxApp_sources ${RedBoxApp_QT_sources})
	list(APPEND RedBoxApp_sources ${RedBoxApp_QT_MOC_sources} ${RedBoxApp_QT_RC_sources})
	list(APPEND RedBoxApp_headers ${RedBoxApp_QT_uis_headers})
	source_group(qtspecific FILES ${RedBoxApp_QT_sources} ${RedBoxApp_QT_MOC_sources}  ${RedBoxApp_QT_RC_sources} ${RedBoxApp_QT_uis_headers})
elseif(SDL)
	if(APPLE)
		set(RedBoxApp_framework_list "Cocoa" "AudioUnit" "CoreAudio" "AudioToolbox" "IOKit" "ForceFeedback" "CoreFoundation" "Carbon")
		foreach(framework ${RedBoxApp_framework_list})
			findpkg_framework(${framework})		
			list(APPEND RedBoxApp_IncludeDir_list ${${framework}_FRAMEWORK_INCLUDES})
			list(APPEND RedBoxApp_libraries_list ${${framework}_LIBRARY_FWK})
		endforeach(framework)
	endif(APPLE)
	FIND_PACKAGE(OpenGL REQUIRED)
	list(APPEND RedBoxApp_IncludeDir_list ${OPENGL_INCLUDE_DIR})
	list(APPEND RedBoxApp_libraries_list ${OPENGL_LIBRARY})

	#pthreads seems to be only needed on Linux for SDL.
	if("${CMAKE_SYSTEM}" MATCHES "Linux")
		find_package (Threads)
		list(APPEND RedBoxApp_libraries_list ${CMAKE_THREAD_LIBS_INIT})
	endif("${CMAKE_SYSTEM}" MATCHES "Linux")

	ADD_DEFINITIONS("-DSDL")

	set(RedBoxApp_SDLSpecific_path ${RedBoxApp_SOURCE_DIR}/platform/SDL/)

	file(GLOB RedBoxApp_SDL_sources ${RedBoxApp_SDLSpecific_path}/*.cpp)
	file(GLOB RedBoxApp_SDL_headers ${RedBoxApp_SDLSpecific_path}/*.h)
	
	INCLUDE_DIRECTORIES( ${CMAKE_BINARY_DIR} )

	list(APPEND RedBoxApp_sources ${RedBoxApp_SDL_sources})
	list(APPEND RedBoxApp_headers ${RedBoxApp_SDL_headers})

	if(WIN32)
		set(RedBoxApp_libraries_list ${RedBoxApp_libraries_list} mingw32 m user32 gdi32 winmm imm32 ole32 oleaut32 version uuid )
	endif(WIN32)

#else(iphone)
	#message(FATAL_ERROR "Build type not found...")
endif(iphone)

file(GLOB RedBoxApp_resources ${RedBoxApp_SOURCE_DIR}/resources/*)
source_group(Resources FILES ${RedBoxApp_resources})

file(GLOB RedBoxApp_application_sources ${RedBoxApp_SOURCE_DIR}/application/*.cpp)
list(APPEND RedBoxApp_sources ${RedBoxApp_application_sources})
file(GLOB RedBoxApp_application_headers ${RedBoxApp_SOURCE_DIR}/application/*.h)
list(APPEND RedBoxApp_headers ${RedBoxApp_application_headers})
source_group(application FILES ${RedBoxApp_application_headers} ${RedBoxApp_application_sources})


# Include directories
INCLUDE_DIRECTORIES(${RedBoxApp_SOURCE_DIR}/application)
INCLUDE_DIRECTORIES(${RedBoxApp_SOURCE_DIR}/libraries/current/include/)
# System libraries include directories. (built beforehand)
INCLUDE_DIRECTORIES(${RedBoxApp_IncludeDir_list})

# Link directories
   link_directories(${RedBoxApp_SOURCE_DIR}/libraries/current/lib/)

# Dev mode helper
# If redbox is available as a directory in the libraries folder, we use its build.
# Make sure that redbox is not also built using libbuildtool, this would be an undocumented comportment.
INCLUDE_DIRECTORIES(${RedBoxApp_SOURCE_DIR}/libraries/redbox/build/${CMAKE_BUILD_TYPE}/include/)
   link_directories(${RedBoxApp_SOURCE_DIR}/libraries/redbox/build/lib/${CMAKE_BUILD_TYPE})

if(APPLE)
	set_source_files_properties(
	${RedBoxApp_resources}
	 PROPERTIES
	  MACOSX_PACKAGE_LOCATION Resources
	)

else()
	copy(${RedBoxApp_SOURCE_DIR}/resources ${EXECUTABLE_OUTPUT_PATH}/resources)
endif(APPLE)


if(APPLE)
	add_executable(
		RedBoxApp
		MACOSX_BUNDLE
		${RedBoxApp_sources}
		${RedBoxApp_headers}
		${RedBoxApp_resources}
	)
elseif(WIN32)
	add_executable(
			RedBoxApp
			WIN32
			${RedBoxApp_sources}
			${RedBoxApp_headers}
			${RedBoxApp_resources}
	)

else()

	add_executable(
		RedBoxApp
		${RedBoxApp_sources}
		${RedBoxApp_headers}
		${RedBoxApp_resources}
	)
endif(APPLE)

target_link_libraries(
	RedBoxApp
	RedBox
	${RedBoxApp_libraries_list}
	)

add_dependencies(RedBoxApp RedBox)


# -------------------------------------
# Install rules

SET(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE}/)

SET(RedBoxApp_APP "\${CMAKE_INSTALL_PREFIX}/RedBoxApp")
IF(APPLE)
	SET(RedBoxApp_APP "\${CMAKE_INSTALL_PREFIX}/RedBoxApp.app")
ENDIF(APPLE)
IF(WIN32)
	SET(RedBoxApp_APP "\${CMAKE_INSTALL_PREFIX}/RedBoxApp.exe")
ENDIF(WIN32)

IF(APPLE)
INSTALL(CODE "
    include(BundleUtilities)
    fixup_bundle(\"${RedBoxApp_APP}\" \"\${QTPLUGINS}\" \"${DIRS}\")
    " COMPONENT Runtime)
ENDIF(APPLE)
