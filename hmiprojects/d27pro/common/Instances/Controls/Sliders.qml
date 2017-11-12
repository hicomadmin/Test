import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import 'qrc:/UI/Controls' as UControls

UControls.Slider {
    id: sliders
    property bool isNumber: false
    property bool isSound
    property int themeColor: 0
    property bool isVisible: false
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: 20
    stepSize: 1
    style: SliderStyle{
        groove: Rectangle {
            implicitWidth: 410
            implicitHeight: 17
            color: "#28282a"
            radius: 8
            Rectangle {
                height: parent.height
                width: styleData.handlePosition
                radius: 8
                color: themeColor == 0? "#70fcfb":(themeColor == 1? "#FF2200":"#986142")
            }
            Image{
                id: num
                anchors.bottom: parent.top
                anchors.bottomMargin: 2
                anchors.left: parent.left
                anchors.leftMargin: 7
                visible: isVisible
                source: sliders.isNumber?"qrc:/resources/set_bg_slider1.png":(sliders.isSound?"qrc:/resources/set_bg_slider2.png":"")
            }

            SliderLabel{
                id:leftRuler
                anchors.left: parent.left
                anchors.leftMargin: 20
                numTextAnchors.right: leftRuler.right
                numTextAnchors.rightMargin: isSound ? -10 : -12
                numText:isSound ? '0' : '-7'
                visible:  isSound ? (sliders.value < 1 ? false : true) : (isNumber ? (sliders.value < -6 ? false : true) : false)
            }

            SliderLabel{
                id:rightRuler
                anchors.right: parent.right
                anchors.rightMargin: 30
                numTextAnchors.right: rightRuler.right
                numTextAnchors.rightMargin: isSound ? -20 : -12
                visible: isSound ? (sliders.value > 37 ? false : true) : (isNumber ? (sliders.value > 6 ? false : true): false)
                numText: isSound ? '40' : '+7'
            }

            SliderLabel{
                id:midRuler
                anchors.right: parent.right
                anchors.rightMargin: 410/2 + 10
                numTextAnchors.right: midRuler.right
                numTextAnchors.rightMargin: isSound ? -20 : -12
                visible: (isSound || Math.abs(sliders.value) < 1) ? false :  (isNumber != isSound ? true : false)
                numText: '0'
            }
        }
        handle: BorderImage{
            source: "qrc:/resources/set_shengyin_slider.png"
            NonAnimationText_FontRegular{
                //visible: (isSound && value != minimumValue && value != maximumValue && value != 0)?true:false
                visible: (isSound || isNumber) ? true : false
                anchors.bottom: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: themeColor == 0? "#70fcfb":(themeColor == 1? "#FF2200":"#986142")
                font.pixelSize: 24
                text: value
            }
        }
    }
}

