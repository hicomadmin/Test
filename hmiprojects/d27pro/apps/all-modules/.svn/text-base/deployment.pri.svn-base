#/*********************************************************************************
#  *Copyright(C),2010-2016,Shenzhen Hangsheng electronics Co.,Ltd.
#  *FileName: src.pro
#  *Author: Blavik Zou
#  *Version:  V1.0
#  *Date: 2016/06/20
#  *Description: 默认编译规则
#  *Notice：
#  *Others:
#  *History:
#     1.Date:
#       Author:
#       Modification:
#**********************************************************************************/
android-no-sdk {
    target.path = /data/user/qt
    export(target.path)
    INSTALLS += target
} else:android {
    x86 {
        target.path = /libs/x86
    } else: armeabi-v7a {
        target.path = /libs/armeabi-v7a
    } else {
        target.path = /libs/armeabi
    }
    export(target.path)
    INSTALLS += target
} else:unix {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /usr/app/apps
        }
        export(target.path)
    }
    INSTALLS += target
}

export(INSTALLS)
