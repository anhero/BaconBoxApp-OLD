# ========================================================================
# =                           BaconBox App                                 =
# ========================================================================

TARGET = BaconBoxApp
TEMPLATE = app
DEFINES = SDL
DESTDIR = $$PWD/../../build/bin

SOURCES += $$PWD/../../application/**.cpp \

HEADERS  += $$PWD/../../application/**.h \


# ------------------------------------------------------------------------------
# Resources

copyResources.target = copyResourcesTarget
macx {
	copyResources.commands += mkdir -p "$$DESTDIR/$${TARGET}.app/Contents/Resources/";
	copyResources.commands += cp -vpRf "$$PWD/../../resources/" "$$DESTDIR/$${TARGET}.app/Contents/Resources/";
}
unix:!mac{
	copyResources.commands += mkdir -p "$$DESTDIR/resources";
	copyResources.commands += cp -vprf "$$PWD/../../resources" "$$DESTDIR/"
}
QMAKE_EXTRA_TARGETS += copyResources
PRE_TARGETDEPS += copyResourcesTarget


# ------------------------------------------------------------------------------
# Local dependencies

# When using the package
INCLUDEPATH +=  $$PWD/../../libraries/current/include
# When in "developer-mode"
INCLUDEPATH +=  $$PWD/../../libraries/BaconBox/build/Debug/include/

# When using the package
LIBS += -L$$PWD/../../libraries/current/lib/
# When in "developer-mode"
LIBS += -L$$PWD/../../libraries/baconbox/build/lib/Debug/

macx {
	INCLUDEPATH +=  $$PWD/../../libraries/baconbox-osx/include
	LIBS += -L$$PWD/../../libraries/baconbox-osx/
}

LIBS += -lBaconBox

# ------------------------------------------------------------------------------
# System dependencies

# Libraries for linux
unix:!mac{
	LIBS += -L/usr/lib -L/usr/X11R6/lib
	LIBS += -lGL -lGLU -lSM -lICE -lX11 -lXext -lpthread
}
#Libraries for OS X
macx {
	INCLUDEPATH += -I/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/Cocoa.framework/Headers
	INCLUDEPATH += -I/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/AudioUnit.framework/Headers
	INCLUDEPATH += -I/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/CoreAudio.framework/Headers
	INCLUDEPATH += -I/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/AudioToolbox.framework/Headers
	INCLUDEPATH += -I/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/IOKit.framework/Headers
	INCLUDEPATH += -I/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/ForceFeedback.framework/Headers
	INCLUDEPATH += -I/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/CoreFoundation.framework/Headers
	INCLUDEPATH += -I/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/Carbon.framework/Headers

	LIBS += -L/Users/alabranche/Development/baconboxapp/libraries/current/lib
	LIBS += -L/Users/alabranche/Development/baconboxapp/libraries/baconbox/build/lib/Debug
	LIBS += -framework Cocoa -framework AudioUnit -framework CoreAudio -framework AudioToolbox
	LIBS += -framework IOKit -framework ForceFeedback -framework CoreFoundation
	LIBS += -framework Carbon -framework AGL -framework OpenGL
}
#Libraries for Windows
win32 {
	LIBS += -lopengl32 -lm -luser32 -lgdi32 -lwinmm -limm32 -lole32 -loleaut32 -luuid -lversion
}
