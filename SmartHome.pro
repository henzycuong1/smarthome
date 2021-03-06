QT += qml quick widgets multimedia
CONFIG += c++11
DEFINES += QT_DEPRECATED_WARNINGS
SOURCES += \
        fileIO.cpp \
        main.cpp \
        myimage.cpp \
        myimagesaver.cpp
RESOURCES += qml.qrc

QML_IMPORT_PATH =

QML_DESIGNER_IMPORT_PATH =
# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    fileIO.h \
    myimage.h \
    myimagesaver.h

DISTFILES += \
    qmldir
# test
static {
    QT += svg
    QTPLUGIN += qtvirtualkeyboardplugin
}
disable-desktop|android-embedded|!isEmpty(CROSS_COMPILE)|qnx {
    DEFINES += MAIN_QML=\\\"main.qml\\\"
} else {
    DEFINES += MAIN_QML=\\\"main.qml\\\"
}
