import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
         home: { url: Qt.resolvedUrl('HomePage.qml'), title: qsTr(''), hideBackBtn: true,requires:['radio','usbctl','aux','ipodctl','hmiCtl','btactl','hfp']},
         main: { url: Qt.resolvedUrl('MainPage.qml'), title: qsTr('全部'), hideBackBtn: false},
         media: { url: Qt.resolvedUrl('MediaPage.qml'), title: qsTr('多媒体'), hideBackBtn: false}
    })
    initialPage: 'main'
}
