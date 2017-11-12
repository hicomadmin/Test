# for build config
include($$PWD/build-config.pri)

# 设置编译模式
CONFIG += ui_source
!debug {
    CONFIG -= ui_source
    CONFIG += ui_binary
}

# 引入共通配置
include($$PWD/../../../../shared/includes-pris/base-app.pri)

ui_source {
    RESOURCES += \
        $$PWD/../Instances/Instances.qrc
}
