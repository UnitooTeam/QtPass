!include(../qtpass.pri) { error("Couldn't find the qtpass.pri file!") }

TEMPLATE   = app
QT        += core gui quick quickcontrols2

CONFIG += c++11
LIBS = -L"$$OUT_PWD/../src/$(OBJECTS_DIR)" -lqtpass $$LIBS
INCLUDEPATH += ../src

macx {
    TARGET = QtPass
} else {
    TARGET = qtpass
}

SOURCES   += main.cpp

RESOURCES   += \
    ../resources.qrc \
    ../icons/material/index.theme

isEmpty(PREFIX) {
 PREFIX = $$(PREFIX)
}

isEmpty(PREFIX) {
 PREFIX = /usr/local
}
target.path = $$PREFIX/bin/

INSTALLS += target
