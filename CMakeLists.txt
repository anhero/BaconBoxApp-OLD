cmake_minimum_required(VERSION 2.6)
project(RedBoxApp)

add_subdirectory(${RedBoxApp_SOURCE_DIR}/libraries/redbox ${RedBoxApp_BINARY_DIR}/RedBox)
#We force the build type to be at least debug
if(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Debug CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
      FORCE)
endif(NOT CMAKE_BUILD_TYPE)

if("${CMAKE_GENERATOR}" STREQUAL "Xcode")
	set(EXECUTABLE_OUTPUT_PATH  ${RedBoxApp_BINARY_DIR}/bin/)
else()
	set(EXECUTABLE_OUTPUT_PATH  ${RedBoxApp_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE})
endif("${CMAKE_GENERATOR}" STREQUAL "Xcode")


if(iphone)
set(RedBoxApp_framework_list  "Foundation" "AudioToolBox" "AVFoundation" "CoreGraphics" "OpenAL" "QuartzCore" "UIKit" "OpenGLES")
	foreach(framework ${RedBoxApp_framework_list})
		findpkg_framework(${framework})		
		list(APPEND RedBoxApp_IncludeDir_list ${${framework}_FRAMEWORK_INCLUDES})
		list(APPEND RedBoxApp_libraries_list ${${framework}_LIBRARY_FWK})
	endforeach(framework)

else()
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
		mm(QT_QTOPENGL_LIBRARIES)
		set(CFLAGS "-m32" ${CFLAGS})
		set(CXXFLAGS "-m32" ${CXXFLAGS})
		set(CMAKE_OSX_ARCHITECTURES "i386")
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

endif(iphone)

file(GLOB RedBoxApp_resources ${RedBoxApp_SOURCE_DIR}/resources/*)
source_group(Resources FILES ${RedBoxApp_resources})

file(GLOB RedBoxApp_application_sources ${RedBoxApp_SOURCE_DIR}/application/*.cpp)
list(APPEND RedBoxApp_sources ${RedBoxApp_application_sources})
file(GLOB RedBoxApp_application_headers ${RedBoxApp_SOURCE_DIR}/application/*.h)
list(APPEND RedBoxApp_headers ${RedBoxApp_application_headers})
source_group(application FILES ${RedBoxApp_application_headers} ${RedBoxApp_application_sources})


INCLUDE_DIRECTORIES(${RedBoxApp_IncludeDir_list})
INCLUDE_DIRECTORIES(${RedBoxApp_SOURCE_DIR}/application)
INCLUDE_DIRECTORIES(${RedBox_BINARY_DIR}/Dependencies/include)

INCLUDE_DIRECTORIES(${RedBox_BINARY_DIR}/${CMAKE_BUILD_TYPE}/include)


link_directories(${RedBox_BINARY_DIR}/${CMAKE_BUILD_TYPE}/lib)
link_directories(${RedBox_BINARY_DIR}/Dependencies/lib/)


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
	

