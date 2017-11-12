# for build config
include($$PWD/build-config.pri)

# 引入共通配置
include($$PWD/../../../../shared/includes-pris/base-qml-plugin.pri)

#引入的头文件
INCLUDEPATH += $$PWD/../base/ \
    $$PWD/../../qmlplugins/service_modules/

LIBS += -lmvc-plugin
