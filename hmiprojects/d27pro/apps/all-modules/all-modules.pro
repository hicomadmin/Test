#/*********************************************************************************
#  *Copyright(C),2010-2016,Shenzhen Hangsheng electronics Co.,Ltd.
#  *FileName: src.pro
#  *Author: Blavik Zou
#  *Version:  V1.0
#  *Date: 2016/06/20
#  *Description: 此工程是针对项目的工程文件，其中包含all-modules工程
#  *Notice： 注意在添加工程的时候记住要加上'\',具体操作请查看工程实例
#  *Others:
#  *History:
#     1.Date:
#       Author:
#       Modification:
#**********************************************************************************/

# 定义该项目的APP名称，用于生成不同项目的HMI运行运行，在编译时会自动加入APP_PREFIX前缀
APP_NAME = D27

# 使用翻译
CONFIG += use_translation

#引入共通编译配置，所有的HMI工程必须强制性包含共通编译配置
include(../../common/includes-pris/app.pri)

#该项目的功能模块
include(maincontrol/module-maincontrol.pri)
include(home/module-home.pri)
include(radio/module-radio.pri)
include(hf/module-hf.pri)
include(calendar/module-calendar.pri)
include(settings/module-settings.pri)
include(usb/module-usb.pri)
include(btaudio/module-btaudio.pri)
include(theAUX/module-theAUX.pri)
include(cm/module-cm.pri)
include(carlife/module-carlife.pri)
include(leecolink/module-leecolink.pri)
include(mirrorlink/module-mirrorlink.pri)
include(manual/module-manual.pri)
include(siri/module-siri.pri)
include(power/module-power.pri)
include(menu/module-menu.pri)
include(wndlink/module-wndlink.pri)
include(engineer/module-engineer.pri)
#include(usbifcer/module-usbifcer.pri)


#指定QML插件的所在位置，用于编码时显示语法高亮
QML2_IMPORT_PATH=$$PWD/../../../../../modules/qmlplugins/
QML_IMPORT_PATH=$$PWD/../../../../../modules/qmlplugins/

#资源文件
RESOURCES += \
    qml.qrc

#HMI工程源码
SOURCES += main.cpp

use_translation {
    #指定需要 国际化 的源文件
    TRANSLATIONS += translations/d27_en_US.ts

    lupdate_only {
        SOURCES += \
            home/*.qml \
            radio/*.qml \
            hf/*.qml\
            calendar/*.qml\
            settings/*.qml\
            usb/*.qml\
            btaudio/*.qml\
            theAUX/*.qml\
            cm/*.qml\
            carlife/*.qml\
            leecolink/*.qml\
            mirrorlink/*.qml\
            manual/*.qml\
            siri/*.qml\
            wndlink/*.qml\
	    usbifcer/*.qml\
            engineer/*.qml\
            ../../common/Instances/Core/*.qml \
            ../../common/Instances/Controls/*.qml \
            *.qml
    }


    OTHER_FILES += \
        translations/d27_en_US.ts
}
#默认编译规则
include(deployment.pri)

HEADERS += \
    debuglog.h \
    signallog.h
