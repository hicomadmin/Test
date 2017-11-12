import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import TheXAudio 1.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

Rectangle{
    id: area
    width: 640
    height: 209
    color: "#00000000"

    property alias text: rbtn.text
    property alias checked: rbtn.checked
    property alias pressed: rbtn.pressed
    property alias exclusiveGroup: rbtn.exclusiveGroup
    property int themeColor: 0
    property url buttonON: themeColor == 0?"qrc:/resources/set_icon_NO.png":(themeColor == 1 ? "qrc:/resources/set_icon_NO_o.png":"qrc:/resources/set_icon_NO_g.png")
    property url buttonOff: themeColor == 0?"qrc:/resources/set_icon_off.png":(themeColor == 1 ? "qrc:/resources/set_icon_off_o.png":"qrc:/resources/set_icon_off_g.png")

    UControls.RadioButtons {
        id: rbtn
        anchors.fill: parent
        anchors.leftMargin: 104
        style: RadioButtonStyle {
            indicator: BorderImage {
                source: control.checked ? buttonON : buttonOff
            }
            label: NonAnimationText_FontRegular {
                id: txt
                anchors.left: parent.left
                anchors.leftMargin: 44
                text: qsTr(control.text)
                font.pixelSize: 38
                color: "#FFFFFF"
            }
        }
        onPressedChanged: {
            if (pressed) {
                console.debug("RadioButtons Beep")
                SoundCommon.beep(0)
            }
        }
    }
}
