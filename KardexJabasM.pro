QT += core quick sql network

CONFIG += c++17

DESTDIR = ../KardexJabasM

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        http/getcontroller.cpp \
        http/postcontroller.cpp \
        kadexproxymodel.cpp \
        kardexmodel.cpp \
        main.cpp \
        model/boleta.cpp \
        model/itemgrupokardex.cpp \
        model/itemkardex.cpp \
        model/itemsdetailboleta.cpp \
        model/proveedor.cpp \
        model/serieboleta.cpp \
        model/tipojaba.cpp \
        model/tipojabamatriz.cpp \
        model/tipooperacion.cpp \
        itemdetailboletamodel.cpp \
        proveedormodel.cpp \
        seriemodel.cpp \
        tipojabamodel.cpp \
        boletamodel.cpp \
        util.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    http/getcontroller.h \
    http/postcontroller.h \
    kadexproxymodel.h \
    kardexmodel.h \
    model/boleta.h \
    model/itemgrupokardex.h \
    model/itemkardex.h \
    model/itemsdetailboleta.h \
    model/proveedor.h \
    model/serieboleta.h \
    model/tipojaba.h \
    model/tipojabamatriz.h \
    model/tipooperacion.h \
    itemdetailboletamodel.h \
    proveedormodel.h \
    seriemodel.h \
    tipojabamodel.h \
    boletamodel.h \
    util.h

DISTFILES += \
    utils/jfieldItem.txt
