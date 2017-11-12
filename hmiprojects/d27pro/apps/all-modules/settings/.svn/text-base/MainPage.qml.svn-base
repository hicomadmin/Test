import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/Core' as UCore
import TheXSettings 1.0

ICore.Page {
    id: mainPage
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
               commonSetting:  { url: Qt.resolvedUrl('SettingCommon.qml')  },
               networkSetting: { url: Qt.resolvedUrl('SettingNetwork.qml') },
               soundSetting:   { url: Qt.resolvedUrl('SettingSound.qml')   },
               advanceSetting: { url: Qt.resolvedUrl('SettingAdvance.qml') }
               })
        initialTab: 'commonSetting'
        tabsModel: [
            {
                tab:'commonSetting',
                tabTitle: qsTr('通用设置') + ctranslator.monitor
            },
            {
                tab:'networkSetting',
                tabTitle: qsTr('网络设置') + ctranslator.monitor
            },
            {
                tab:'soundSetting',
                tabTitle: qsTr('声音设置') + ctranslator.monitor
            },
            {
                tab:'advanceSetting',
                tabTitle: qsTr('高级设置') + ctranslator.monitor
            },
        ]
    }
}
