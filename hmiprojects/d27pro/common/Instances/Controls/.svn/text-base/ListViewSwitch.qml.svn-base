import QtQuick 2.5
import QtQuick.Controls 1.4

Image {
    id: bg
    source: "qrc:/resources/BG.png"
    ListView{
        id: listLight
        visible: !siriSwitch.checked
        anchors.top: siriSwitch.bottom
        anchors.topMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 46
        width: 1180
        height: 464
        model:[qsTr("车门未关"),qsTr("安全带未系"),qsTr("手刹未释放"),qsTr("电源未关"),qsTr("超速"),qsTr("水温过高"),qsTr("低温结冰"),qsTr("油量不足"),qsTr("车况自检故障"),qsTr("保养"),qsTr("车灯未熄"),qsTr("钥匙未拔"),qsTr("车窗未关")]
        delegate: items
        clip: true
//        boundsBehavior: Flickable.StopAtBounds
//        snapMode: ListView.SnapToItem
    }
    Component{
        id: items
        ListDelegateSwitch{
            id: siriItems
            text: qsTr(modelData)
//            onCheckedChanged: {

//            }
        }
    }
    ListDelegateSwitch{
        id: siriSwitch
        anchors.top: bg.top
        anchors.topMargin: 92
        anchors.left: bg.left
        anchors.leftMargin: 46
        text: qsTr("语音提醒")
        checked: true
        lineFlag: false
//        onCheckedChanged: {
//            bg.vFlag = checked
//        }
        Rectangle{
            id: line
            width: 1188
            height: 40
            z: 1
            anchors.top: parent.bottom
            anchors.left: parent.left
            color: "#777c7f"
            opacity: 0.08
        }
    }
    Fixed_ScrollBar{
        y: 256
        visible: listLight.visible
        view: listLight
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
}


