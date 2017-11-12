import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import 'qrc:/UI/Controls' as UControls

UControls.Slider {
    id: slidersRadio
    minimumValue: 87.5
    maximumValue: 108
    value: 90
    stepSize: 0.1
    onValueChanged: {
        console.log(value)
    }

    style: SliderStyle{
        groove: BorderImage{
            source: "qrc:/resources/home_Slider_radio_Bg.png"
            NonAnimationText_FontRegular {
                id: left
                anchors.left: parent.left
                anchors.leftMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 30
                text: "87.5"
                font.pixelSize: 18
                color: "#FFFFFF"
            }
            NonAnimationText_FontRegular {
                id: right
                anchors.right: parent.right
                anchors.rightMargin: -10
                anchors.top: parent.top
                anchors.topMargin: 30
                text: "108"
                font.pixelSize: 18
                color: "#FFFFFF"
            }
        }

        handle: BorderImage{
            source: "qrc:/resources/home_Slider_radio.png"
        }
    }
}


