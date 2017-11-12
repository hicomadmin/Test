import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import TheXWifi 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id: root

    property bool isCopy: true
    property WifiCtl wifictl : HSPluginsManager.get('wifictl')
    property SystemCtl system: HSPluginsManager.get('system')
    property var apconnectedlist: wifictl.apconnectedlist
    property int interfacemodel: system.interfacemodel
    property bool wifiStatus: system.wifisw

    /* BEGIN by Zhang Yi, 2016.11.19
     * Wifi state should be remembered when switch changed.
    */
    Connections {
        target: wifictl
        onPowerstateChanged: {
            system.setWifisw(wifictl.powerstate !== 0)
        }
    }
    /* END - by Zhang Yi, 2016.11.19 */

    onApconnectedlistChanged: {
        console.debug("apconnectedlist: " ,apconnectedlist);
    }

    Item {
        id: name
        width: 1040
        height: 628
        IControls.ListItemDelegateH{
            id: wifiSwitch
            anchors.top: parent.top
            themeColor: interfacemodel
            text: qsTr("WiFi热点")
            checked: wifiStatus
            onClicked: {
                if(wifiSwitch.checked) {
                    wifictl.turnOn(2);
                } else {
                    wifictl.turnOff();
                }
                application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: wifiSwitch.checked?qsTr("正在开启"):qsTr("正在关闭")})
            }
        }
        Rectangle{
            id: rect
            width: 994
            height: 60
            color: "#444547"
            opacity: 0.3
            anchors.top: wifiSwitch.bottom
        }
        IControls.NonAnimationText_FontRegular{
            anchors.left: rect.left
            anchors.leftMargin: 68
            anchors.verticalCenter: rect.verticalCenter
            font.pixelSize: 32
            color: "#ffffff"
            text: qsTr("已连接设备")
        }
        Image {
            id: bottomLine
            anchors.bottom: rect.bottom
            source: "qrc:/resources/list_lineA2.png"
        }
        ListView{
            id: pairList
            width: 996
            height: 504
            anchors.top: rect.bottom
            model: apconnectedlist//["iPhone","Andriod","Apple","Google","Mirosoft","Moto","Nokia","Sony"]
            delegate: item
            clip: true
            boundsBehavior: Flickable.StopAtBounds
        }
        Component{
            id: item
            IControls.ListItemDelegateI{
                iconurl: "qrc:/resources/Phone_Icon_ connect_sj.png"
                phonename: modelData
            }
        }
        IControls.Fixed_ScrollBar{
            y: pairList.y
            anchors.right: parent.right
            anchors.rightMargin: 10
            view: pairList
        }
    }

}

