import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import 'qrc:/UI/Controls' as UControls

Rectangle{
    id: root
    width: 1188
    height: 124
    color: "transparent"

    property alias checked: rbtn.checked
    property alias text: txt.text
    property bool lineFlag: true
    property int themeColor: 0
    signal siriChecked

    Switches{
        id: rbtn
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        themeColor: root.themeColor
        onCheckedChanged: {
            root.siriChecked()
        }
    }
    NonAnimationText_FontRegular{
        id: txt
        anchors.left: parent.left
        anchors.leftMargin: 55
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 32
        color: "#ffffff"
    }
    Image {
        id: bottomLine
        anchors.bottom: parent.bottom
        source: lineFlag ? "qrc:/resources/list_lineA1.png":""
    }
}

