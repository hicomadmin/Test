#/*********************************************************************************
#  *Copyright(C),2010-2016,Shenzhen Hangsheng electronics Co.,Ltd.
#  *FileName: src.pro
#  *Author: Blavik Zou
#  *Version:  V1.0
#  *Date: 2016/06/20
#  *Description: 所有HMI工程所依赖的基础工程文件，主要用于固定生成目录和规范化生成的文件名称
#                规范化的翻译模块导入
#  *Notice：
#  *Others:
#  *History:
#     1.Date: 2016/10/15
#       Author: Nolan
#       Modification:
#**********************************************************************************/

# ROOT路径
ROOT_DIR = $$PWD/../../

# APP前缀
APP_PREFIX = hs-main-app

#应用程序模板变量: app, lib, subdirs
TEMPLATE = app

#描述应用格式
QT += qml quick

#指定生成的应用程序名
TARGET = $${APP_PREFIX}.$${APP_NAME}
TIZEN_APP_ID = TARGET

#指定生成的应用程序放置的目录
DEFINES += DEBUG
DESTDIR = $${ROOT_DIR}/output/apps

#定义QML插件的根目录，引擎可查找
DEFINES += QMLPLUGINS_PATH

#!debug {
#    DEFINES -= DEBUG
#    DESTDIR = $${ROOT_DIR}/release/$${PROJECT_NAME}/$${RELEASE_VERSION}/Desktop/apps
#}

#定义宏 （项目，APP）
DEFINES += PRO_$${PROJECT_NAME} APP_$${APP_NAME}
#CONFIG(release, debug|release): DEFINES += QT_NO_DEBUG_OUTPUT

#引入的头文件
INCLUDEPATH += $$PWD/../base/\
            += $$PWD/../include/
#头文件
HEADERS += \
    $$PWD/../base/baseappconfig.h

#源文件
SOURCES += \
    $$PWD/../base/baseappconfig.cpp

#添加QML导入库路径
QML_IMPORT_PATH +=

#Release模式下引入的库文件
Release:LIBS +=

#Debug模式下引入的库文件
Debug:LIBS +=

#配置信息
# qt部分告诉qmake这个应用程序是使用Qt来连编的。这也就是说qmake在连接和为编译添加所需的包含路径的时候会考虑到Qt库的
# warn_on部分告诉qmake要把编译器设置为输出警告信息的
# release部分告诉qmake应用程序必须被连编为一个发布的应用程序。在开发过程中，程序员也可以使用debug来替换release
CONFIG += qt warn_on c++11 $${PROJECT_NAME}

#使用翻译国际化
use_translation {
    # 设置默认语言
    LOCAL_NAME = en_US

    INCLUDEPATH += $$PWD/../translator/

    HEADERS += \
        $$PWD/../translator/ctranslator.h

    SOURCES += \
        $$PWD/../translator/ctranslator.cpp

    #定义宏是否使用翻译
    DEFINES += USE_TRANSLATION

#    指定需要 国际化 的源文件
#    TRANSLATIONS += $${ROOT_DIR}/output/$${PROJECT_NAME}/translations/$${APP_NAME}_$${LOCAL_NAME}.ts

#    !debug {
#        TRANSLATIONS += $${ROOT_DIR}/release/$${PROJECT_NAME}/translations/$${APP_NAME}_$${LOCAL_NAME}.ts
#    }

    lupdate_only {
        SOURCES += \
            $$PWD/../UI/Controls/*.qml
    }
}

#部署环境特殊配置
#deploy {
#    TARGET = $${APP_PREFIX}$${APP_NAME}

#    DESTDIR = $${ROOT_DIR}/output/$${PROJECT_NAME}/$${PLATFORM_NAME}/apps

#    !debug {
#        DESTDIR = $${ROOT_DIR}/release/$${PROJECT_NAME}/$${RELEASE_VERSION}/$${PLATFORM_NAME}/apps
#    }
#    # 设置编译选项，如PROJECT_NAME: XXX, PLATFORM_NAME: arm，则会添加TIZEN_PLATFORM, TIZEN_arm_PLATFORM, XXX_TIZEN_arm_PLATFORM等编译选项
#    DEFINES += TIZEN_PLATFORM TIZEN_$${PLATFORM_NAME}_PLATFORM $${PROJECT_NAME}_TIZEN_$${PLATFORM_NAME}_PLATFORM

#   # CONFIG += TIZEN_STANDALONE_PACKAGE

#    # load(tizen_app)
#}

ui_source {
    RESOURCES += $$PWD/../UI/UI.qrc
}

ui_binary {
    DEFINES += UI_BINARY
}

LIBS += -L$$PWD/../library/ARM -lHSSocket
LIBS += -L$$PWD/../library/ARM -lHSPluginBaseController

#使用dlt模块 => CONFIG += use_dlt
use_dlt {
    DEFINES += USE_DLT
    LIBS += -ldlt
}
