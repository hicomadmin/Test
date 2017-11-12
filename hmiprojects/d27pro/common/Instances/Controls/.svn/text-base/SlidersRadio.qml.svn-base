import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import 'qrc:/UI/Controls' as UControls

UControls.Slider {
    id: slidersRadio
    property real dragValue
    property bool isToFixed
    property int themeColor: 0
    style: SliderStyle{
        groove: BorderImage{
            source: "qrc:/resources/radio_slider.png"
        }

        handle: Rectangle {
            anchors.centerIn: parent
            color: themeColor == 0? "#66f8b4":(themeColor == 1? "#FF2200":"#986142")
            implicitWidth: 5
            implicitHeight: 52

            Image {
                id: pop
                source: themeColor == 0? "qrc:/resources/radio_pop.png":
                                         (themeColor == 1? "qrc:/resources/radio_pop(orange).png":"qrc:/resources/radio_pop(gold).png")
                visible: control.pressed ? true:false
                anchors.bottom: parent.top
                anchors.bottomMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: -width/2 + 2
                NonAnimationText_FontRegular{
                    anchors.top: parent.top
                    anchors.topMargin: -2
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 24
                    color: "#ffffff"
                    text: isToFixed ? control.value.toFixed(1):control.value
                }
            }
        }
    }
}


