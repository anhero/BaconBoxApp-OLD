
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

