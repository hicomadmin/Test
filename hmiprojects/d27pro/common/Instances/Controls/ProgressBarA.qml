import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/JSLibs/Util.js' as Util
import QtGraphicalEffects 1.0
import TheXAudio 1.0

UControls.Slider{
    id: root
    property int themeColor: 0

    readonly property int offset: 40
    property bool pressed: false
    property bool move: false;

    style: SliderStyle{
        groove: Rectangle {
            id: bg
            implicitWidth: 868
            implicitHeight: 10
            color: "#28282a"
            Rectangle {
                height: 10
                width: styleData.handlePosition
//                color: "#70fcfb"
                color: themeColor == 0? "#66f8d4":(themeColor == 1? "#FF2200":"#986142")
//                Rectangle{
//                    width: styleData.handlePosition
//                    height: 10
//                    radius: 5
//                    LinearGradient{
//                        anchors.fill: parent
//                        start: Qt.point(0,0)
//                        end: Qt.point(styleData.handlePosition,0)
//                        gradient: Gradient{
//                            GradientStop{
//                                position: 0.0
//                                color: "#66f8d4"
//                            }
//                            GradientStop{
//                                position: 1.0
//                                color: "purple"
//                            }
//                        }
//                    }
                }
        }
        handle: BorderImage{
            source: "qrc:/resources/Media_Icon_Handle.png"
            Image {
                id: pop
                source: themeColor == 0? "qrc:/resources/radio_pop.png":
                                         (themeColor == 1? "qrc:/resources/radio_pop(orange).png":"qrc:/resources/radio_pop(gold).png")
                visible: control.pressed
                anchors.bottom: parent.top
                anchors.bottomMargin: 0
                anchors.left: parent.left

//                smooth: true
//                fillMode: Image.Stretch

                anchors.leftMargin: -parent.width/2 - 3
                NonAnimationText_FontLight{
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 18
                    color: "#ffffff"
                    text: Util.formatTime(value)
                }
            }
        }
    }

    /* BEGIN by Zhao Xing, 2016.12.28
     * OverWrite of slider mouse event.
     */
    MouseArea {
        anchors.fill: parent
        onPressed: {
            SoundCommon.beep(0);
            root.pressed = true;
            root.move = false;
        }

        onMouseXChanged: {
            if (root.move) {
                updateValue(mouseX);
            }
            root.move = true;
        }

        onReleased: {
            updateValue(mouseX);
            root.move = false;
            root.pressed = false;
            hasUpdated = false
        }
    }

    property bool hasUpdated: false

    readonly property int virMin: offset / 2
    readonly property int virMax: 868 - virMin
    readonly property int virLen: virMax - virMin

    function value2x(v) {
        return virMin + virLen * (v - root.minimumValue) / (root.maximumValue - root.minimumValue)
    }

    function x2value(x) {
        var vir_val = x - virMin
        if (vir_val < 0) vir_val = 0
        if (vir_val > virLen) vir_val = virLen
        return root.minimumValue + (root.maximumValue - root.minimumValue) * vir_val / virLen
    }

    //update slider value
    function updateValue(x) {
        var vir_x = value2x(root.value)
        console.debug(hasUpdated, vir_x, x)
        if (hasUpdated || (x > (vir_x + virMin)) || (x < (vir_x - virMin))) {
            root.value = x2value(x)
            hasUpdated = true
        }
    }
    /* END by Zhao Xing, 2016.12.28
     */
}

