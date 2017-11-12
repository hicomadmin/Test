TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += \
    Demos.qrc \
    Instances.qrc \
    ../../../../shared/UI/UI.qrc

#引用模块输出的根目录工程文件
include($$PWD/../../common/includes-pris/build-common.pri)
#模块的类型，用于输出到目标目录
MODULE_CLASS = demo
#模块的类型，用于输出到目标目录
DESTDIR += $${COMMON_OUTPUT_ROOT}/$${MODULE_CLASS}/
include(deployment.pri)
