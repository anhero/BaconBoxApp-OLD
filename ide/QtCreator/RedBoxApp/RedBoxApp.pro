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
	../../../libraries/redbox/RedBox/RedBox \
	../../../libraries/redbox/RedBox/RedBox/Audio \
	../../../libraries/redbox/RedBox/RedBox/Audio/OpenAL \
	../../../libraries/redbox/RedBox/RedBox/Display \
	../../../libraries/redbox/RedBox/RedBox/Display/Driver \
	../../../libraries/redbox/RedBox/RedBox/Display/Text \
	../../../libraries/redbox/RedBox/RedBox/Emitter \
	../../../libraries/redbox/RedBox/RedBox/Input \
	../../../libraries/redbox/RedBox/RedBox/Input/Accelerometer \
	../../../libraries/redbox/RedBox/RedBox/Input/GamePad \
	../../../libraries/redbox/RedBox/RedBox/Input/Keyboard \
	../../../libraries/redbox/RedBox/RedBox/Input/Keyboard/Qt \
	../../../libraries/redbox/RedBox/RedBox/Input/Pointer \
	../../../libraries/redbox/RedBox/RedBox/Physic \
	../../../libraries/redbox/RedBox/RedBox/Helper \
	../../../libraries/redbox/RedBox/RedBox/SignalSlots \
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
