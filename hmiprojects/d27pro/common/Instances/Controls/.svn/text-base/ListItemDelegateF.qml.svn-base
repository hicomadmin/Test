import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls

Rectangle {
    id: root
    width: 994
    height: 124
    property alias textL: txtLeft.text
    property alias textLColor: txtLeft.color
    property alias textR: txtRight.text
    property bool lineFlag: true
    property int themeColor;
    property alias lineWidth: bottomLine.width
    color: "transparent"
    signal clicked
    IControls.MouseArea{
        z: 1
        anchors.fill: parent
        onClicked: {
            console.log(textL)
            root.clicked()
        }
        onPressed: {
            root.color = themeColor == 0 ? '#105769' :(themeColor == 1 ? "#FF2200" : "#986142")
        }
        onReleased: {
            root.color = "transparent"
        }
        onCanceled: {
            root.color = "transparent"
        }
    }

    NonAnimationText_FontRegular {
        id: txtLeft
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 68
        font.pixelSize: 32
        color: "#FFFFFF"
    }
    NonAnimationText_FontRegular {
        id: txtRight
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        font.pixelSize: 32
        color: "#ffffff"
    }
    Image {
        id: bottomLine
        anchors.bottom: parent.bottom
        source: lineFlag?"qrc:/resources/list_lineA2.png":""
    }

}

