import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
//setting text + switch
Rectangle{
    id: root
    width: 994
    height: 124
    color: "transparent"
    property alias checked: rbtn.checked
    property alias text: txt.text
    property int themeColor: 0
    signal clicked

    Switches{
        id: rbtn
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        themeColor: root.themeColor
        onClicked: {
            root.clicked()
        }


    }
    NonAnimationText_FontRegular{
        id: txt
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 68
        font.pixelSize: 32
        color: "#ffffff"
    }
    Image {
        id: bottomLine
        anchors.bottom: parent.bottom
        source: "qrc:/resources/list_lineA2.png"
    }
}

