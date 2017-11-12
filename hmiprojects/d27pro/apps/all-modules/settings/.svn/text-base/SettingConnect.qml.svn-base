import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/Core' as UCore
import TheXSettings 1.0

ICore.Page {
    id: mainPage
//    anchors.fill: parent
    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    IControls.TabBar{
        id: tab
        anchors.fill: parent
        application: mainPage.application
        themeColor: interfacemodel
        tabs: ({
               connectManage:{url: Qt.resolvedUrl('ConnectionManage.qml')},
               wifiSetting:{url: Qt.resolvedUrl('SettingWiFi.qml')}
               })
        initialTab: 'connectManage'
        tabsModel: [
            {
                tab:'connectManage',
                tabTitle: qsTr('连接管理')
            },
            {
                tab:'wifiSetting',
                tabTitle: qsTr('WiFi设置')
            }
        ]
    }
}
