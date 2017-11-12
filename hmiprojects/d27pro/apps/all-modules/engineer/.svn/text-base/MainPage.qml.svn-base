import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls

import TheXSettings 1.0


ICore.Page {
    property SystemCtl system: HSPluginsManager.get('system')

    property int interfacemodel: system.interfacemodel

    Item {
        id: bg
        width: 1280
        height: 124 * 3

        ListView{
            id: engineer
            width: 1280
            height: 124 * 3
            anchors.top: parent.top
            model: ListModel{
                ListElement{caption:"版本信息"; name:"verInfo"; widLine: "1"}
                ListElement{caption:"AM灵敏度调整"; name:"amLevel"; widLine: "1"}
                ListElement{caption:"Usb IF认证"; name:"usbifcerSetting"; widLine: "1"}
            }
            delegate: item
            clip: true
        }
        Component{
            id: item
            IControls.ListItemDelegateF{
                width: 1280
                lineWidth: 1280
                textL: qsTr(caption) + ctranslator.monitor
                themeColor: interfacemodel
                onClicked: application.changePage(name)
            }
        }
    }
}
