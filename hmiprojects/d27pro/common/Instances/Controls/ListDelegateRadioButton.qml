import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
Rectangle{
    id: root
    width: 1188
    height: 124
    color: "transparent"
//    property alias text: rbtn.text
    property alias checked: rbtn.checked
    property alias exclusiveGroup: rbtn.exclusiveGroup
    property alias text: txt.text
    property int themeColor: 0
    property url buttonON: themeColor == 0?"qrc:/resources/set_icon_NO.png":(themeColor == 1 ? "qrc:/resources/set_icon_NO_o.png":"qrc:/resources/set_icon_NO_g.png")
    property url buttonOff: themeColor == 0?"qrc:/resources/set_icon_off.png":(themeColor == 1 ? "qrc:/resources/set_icon_off_o.png":"qrc:/resources/set_icon_off_g.png")
    signal lightchecked
    IControls.MouseArea{
        z: 1
        anchors.fill: parent
        onClicked: {
            if(!checked){
                checked = true
                root.lightchecked()
            }
        }
    }
    UControls.RadioButtons{
        id: rbtn
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        style: RadioButtonStyle{
            indicator: BorderImage{
                source: control.checked ? buttonON : buttonOff
            }
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
        source: "qrc:/resources/list_lineA1.png"
    }
}

