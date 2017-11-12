import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/Private' as Private
import 'qrc:/Instances/Controls' as IControls

UControls.Dialog {
    id: root
    contentWidth: 600 //282
    contentHeight: 100
    mousePenetration: true

    property int themeColor: 0
    property int autoCloseTimeout: 3000
    property bool autoClose: true
    property int value: 30
    property int sliderValue : 0

    onValueChanged:{
        console.debug("ValueChanged: ",value)
        autoCloseTimer.restart()
    }

    shadowComponent: Component {  //整个窗口背景
        Rectangle {
            color: "#000000";
            opacity: 0
        }
    }
    bgComponent: Component {   //弹出框
        Rectangle {
            id: contentBg;
            color: themeColor == 0 ? "#103c4b":(themeColor == 1 ?"#480E05":"#3c2513");
            opacity: 0.9;
        }
    }

    contentComponent: Component {   //弹出框中的内容
        Item {
            UControls.Label {
                id:lab;
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter;
                color: "#FFFFFF"
                text: qsTr('音量')
                font.pixelSize: 36
            }
            Sliders{
                id: rbtn
                anchors.left: lab.right
                anchors.leftMargin: 20
                anchors.right: val.left;
                anchors.rightMargin: 20;
                minimumValue: 0
                maximumValue: 40
                themeColor: root.themeColor
                stepSize: 1;
                value: root.value;
                onValueChanged: {
//                    root.value = value;
                    val.text = value;
                }
                onPressedChanged: {
                    if (!pressed) {
                        sliderValue = value
                    }
                }
            }
            UControls.Label {
                id:val;
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter;
                color: "#FFFFFF"
                text: root.value
                font.pixelSize: 36
            }
        }
    }

    transitionDelegate:QtObject {
//        id: root
        property Component open: Private.DialogTransition {

        }
        property Component close: Private.DialogTransition {

        }

        function getAnimation(shadowItem, mainItem, opts) {
//            var animation = opts.isOpen ? open : close;
//            return animation.createObject(opts.parent || root, {dialogItem: opts.parent, shadowItem: shadowItem, mainItem: mainItem});
            return null
        }
    }

    onOpened: {
        if (autoClose) autoCloseTimer.restart();
    }
    onClosed: {
        if (autoClose) autoCloseTimer.stop();
    }
    Timer {
        id: autoCloseTimer
        interval: autoCloseTimeout
        repeat: false
        onTriggered: { root.close(); }
    }
}


