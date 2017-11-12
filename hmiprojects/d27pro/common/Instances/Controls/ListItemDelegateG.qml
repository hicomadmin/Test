import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
//setting text + slider

Rectangle{
    id: root
    width: 994
    height: 124
    color: "transparent"

    property alias numFlag: rbtn.isNumber
    property alias text: txt.text
    property alias value: rbtn.value
    property alias pressed: rbtn.pressed
    property alias sliderWidth: rbtn.width
    property alias maximunValue: rbtn.maximumValue
    property alias minimunValue: rbtn.minimumValue
    property alias numVisibleFlag: rbtn.isVisible
    property alias soundFlag: rbtn.isSound
    property alias txtanchors: txt.anchors
    property alias rbtnanchors: rbtn.anchors
    property alias bottomLinevisible: bottomLine.visible
    property alias textFontSize: txt.font.pixelSize
    property int themeColor

    Sliders{
        id: rbtn
        themeColor: root.themeColor
        anchors.right: parent.right
        anchors.rightMargin: 10
        minimumValue: isNumber? -7:0
        maximumValue: isNumber? 7:40
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
        anchors.left: parent.left
        source: "qrc:/resources/list_lineA2.png"
    }
}

