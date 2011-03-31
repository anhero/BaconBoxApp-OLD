#-------------------------------------------------
#
# Project created by QtCreator 2011-03-22T14:33:28
#
#-------------------------------------------------

QT       += core gui opengl

TARGET = RedBoxApp
TEMPLATE = app

CONFIG += x86

DEFINES += QT

INCLUDEPATH += ../../../libraries/redbox/RedBox \
	../../../libraries/redbox/RedBox/Audio \
	../../../libraries/redbox/RedBox/Audio/OpenAL \
	../../../libraries/redbox/RedBox/Display \
	../../../libraries/redbox/RedBox/Display/Camera \
	../../../libraries/redbox/RedBox/Display/GraphicDrivers \
	../../../libraries/redbox/RedBox/Display/Emitter \
	../../../libraries/redbox/RedBox/Display/Interface/Text \
	../../../libraries/redbox/RedBox/other \
	../../../libraries/redbox/RedBox/Helper \
	../../../libraries/redbox/RedBox/StatesSystem \
	../../../application

SOURCES += main.cpp\
        mainwindow.cpp \
    redboxwidget.cpp \
	../../../application/PlayState.cpp

HEADERS  += mainwindow.h \
    redboxwidget.h \
	../../../application/PlayState.h

FORMS    += mainwindow.ui

macx {
QMAKE_LFLAGS += -F/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/OpenAL.framework
LIBS += -framework OpenAL
}

INCLUDEPATH += $$PWD/../../../libraries/redbox/RedBox
DEPENDPATH += $$PWD/../../../libraries/redbox/RedBox
INCLUDEPATH += $$PWD/../../../libraries/redbox/libraries/ios/i386/include
DEPENDPATH += $$PWD/../../../libraries/redbox/libraries/ios/i386/include

macx: LIBS += -L$$PWD/../../../libraries/redbox/libraries/ios/i386/lib/ -lpng15

macx: PRE_TARGETDEPS += $$PWD/../../../libraries/redbox/libraries/ios/i386/lib/libpng15.a

macx: LIBS += -L$$PWD/../../../libraries/redbox/libraries/ios/i386/lib/ -lfreetype

macx: PRE_TARGETDEPS += $$PWD/../../../libraries/redbox/libraries/ios/i386/lib/libfreetype.a

macx: LIBS += -L$$PWD/../../../libraries/redbox/libraries/ios/i386/lib/ -lvorbisidec

macx: PRE_TARGETDEPS += $$PWD/../../../libraries/redbox/libraries/ios/i386/lib/libvorbisidec.a

macx: LIBS += -L$$PWD/../../../libraries/redbox/ide/QtCreator/RedBox-build-desktop/ -lRedBox

macx: PRE_TARGETDEPS += $$PWD/../../../libraries/redbox/ide/QtCreator/RedBox-build-desktop/libRedBox.a

macx: LIBS += -lz

PRIVATE_RESOURCES.files = ../../../resources
PRIVATE_RESOURCES.path = Contents/Resources
QMAKE_BUNDLE_DATA += PRIVATE_RESOURCES

#ICON = ../../../resources/icon.icns
