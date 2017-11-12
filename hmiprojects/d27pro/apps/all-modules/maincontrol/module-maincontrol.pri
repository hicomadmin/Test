
QT += qml quick
CONFIG += c++11

INCLUDEPATH += \
    $$[QT_INSTALL_HEADERS]/QtQml/5.5.0/QtQml/ \
    $$[QT_INSTALL_HEADERS]/QtCore/5.5.0/ \
    $$[QT_INSTALL_HEADERS]/QtCore/5.5.0/QtCore

HEADERS += \
    $$PWD/HSPluginsManager.h \
    $$PWD/HSContainer.h \
    $$PWD/HSControl.h \
    $$PWD/HSPage.h \
    $$PWD/HSApplication.h \
    $$PWD/HSStackContainer.h \
    $$PWD/HSApps.h \
    $$PWD/HSElementContainer.h \
    $$PWD/HSDispatchable.h \
    $$PWD/HSTab.h \
    $$PWD/HSMultiApplications.h \
    $$PWD/HSContainerControl.h \
    $$PWD/HSStore.h \
    $$PWD/HSStabilizer.h

SOURCES += \
    $$PWD/HSPluginsManager.cpp \
    $$PWD/HSContainer.cpp \
    $$PWD/HSControl.cpp \
    $$PWD/HSPage.cpp \
    $$PWD/HSApplication.cpp \
    $$PWD/HSStackContainer.cpp \
    $$PWD/HSApps.cpp \
    $$PWD/HSElementContainer.cpp \
    $$PWD/HSTab.cpp \
    $$PWD/HSMultiApplications.cpp \
    $$PWD/HSContainerControl.cpp \
    $$PWD/HSStore.cpp \
    $$PWD/HSStabilizer.cpp
