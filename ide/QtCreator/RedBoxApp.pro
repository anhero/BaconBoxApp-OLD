#-------------------------------------------------
#
# Project created by QtCreator 2011-03-22T14:33:28
#
#-------------------------------------------------

QT       += core gui opengl

TARGET = RedBoxApp
TEMPLATE = app

CONFIG += x86
CONFIG += ordered

DEFINES += QT

DESTDIR = $$PWD/../../build/bin

INCLUDEPATH +=  $$PWD/../../libraries/redbox/RedBox \
                $$PWD/../../libraries/redbox/RedBox/RedBox \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Audio \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Audio/OpenAL \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Display \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Display/Driver \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Display/Text \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Emitter \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Input \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Input/Accelerometer \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Input/GamePad \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Input/Keyboard \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Input/Keyboard/Qt \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Input/Pointer \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Physic \
                $$PWD/../../libraries/redbox/RedBox/RedBox/Helper \
                $$PWD/../../libraries/redbox/RedBox/RedBox/SignalSlots \
                $$PWD/../../application

SOURCES += $$PWD/QtCreator_specific/main.cpp\
        $$PWD/QtCreator_specific/mainwindow.cpp \
    $$PWD/QtCreator_specific/redboxwidget.cpp \
	$$PWD/../../application/*.cpp \

HEADERS  += $$PWD/QtCreator_specific/mainwindow.h \
    $$PWD/QtCreator_specific/redboxwidget.h \
    $$PWD/../../application/*.h \

FORMS    += $$PWD/QtCreator_specific/mainwindow.ui

macx {
QMAKE_LFLAGS += -F/Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/OpenAL.framework
LIBS += -framework OpenAL
}

INCLUDEPATH += $$PWD/../../libraries/redbox/RedBox
DEPENDPATH += $$PWD/../../libraries/redbox/RedBox
INCLUDEPATH += $$PWD/../../libraries/redbox/libraries/ios/i386/include
DEPENDPATH += $$PWD/../../libraries/redbox/libraries/ios/i386/include

macx: LIBS += -L$$PWD/../../libraries/redbox/libraries/ios/i386/lib/ -lpng15

macx: PRE_TARGETDEPS += $$PWD/../../libraries/redbox/libraries/ios/i386/lib/libpng15.a

macx: LIBS += -L$$PWD/../../libraries/redbox/libraries/ios/i386/lib/ -lfreetype

macx: PRE_TARGETDEPS += $$PWD/../../libraries/redbox/libraries/ios/i386/lib/libfreetype.a

macx: LIBS += -L$$PWD/../../libraries/redbox/libraries/ios/i386/lib/ -lvorbisidec

macx: PRE_TARGETDEPS += $$PWD/../../libraries/redbox/libraries/ios/i386/lib/libvorbisidec.a

macx: LIBS += -L$$PWD/../../libraries/redbox/build/lib -lRedBox

macx: PRE_TARGETDEPS += $$PWD/../../libraries/redbox/build/lib/libRedBox.a

macx: LIBS += -lz

PRIVATE_RESOURCES.files = $$PWD/../../resources
PRIVATE_RESOURCES.path = Contents/Resources
QMAKE_BUNDLE_DATA += PRIVATE_RESOURCES


#ICON = ../../../resources/icon.icns
