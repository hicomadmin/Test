import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
                wndlink: { url: Qt.resolvedUrl('WNDLinkPage.qml'), title: qsTr('WindLink'), hideBackBtn: false },
                wndlinksetting: { url: Qt.resolvedUrl('SettingMobile.qml'), title: qsTr('WindLink设置'), hideBackBtn: false },
                wndlinkmanual: { url: Qt.resolvedUrl('ManualPage.qml'), title: qsTr('帮助'), hideBackBtn: false },

            })
    initialPage: 'wndlink'
}
