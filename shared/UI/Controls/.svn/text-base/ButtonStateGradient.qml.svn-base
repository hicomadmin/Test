import QtQuick 2.3
import QtGraphicalEffects 1.0

LinearGradient {
    id: root;
    anchors.fill: parent;
    start: Qt.point(0, 0)
    end: Qt.point(0, root.height)

    state: parent.state
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: root
                start: normalGradientDirection.start
                end: normalGradientDirection.end
                gradient: normalGradient
            }
        },
        State {
            name: "pressing"
            PropertyChanges {
                target: root
                start: pressingGradientDirection.start
                end: pressingGradientDirection.end
                gradient: pressingGradient
            }
        },
        State {
            name: "checkedNormal"
            PropertyChanges {
                target: root
                start: checkedNormalGradientDirection.start
                end: checkedNormalGradientDirection.end
                gradient: checkedNormalGradient
            }
        },
        State {
            name: "checkedPressing"
            PropertyChanges {
                target: root
                start: checkedPressingGradientDirection.start
                end: checkedPressingGradientDirection.end
                gradient: checkedPressingGradient
            }
        },
        State {
            name: "disabled"
            PropertyChanges {
                target: root
                start: disabledGradientDirection.start
                end: disabledGradientDirection.end
                gradient: disabledGradient
            }
        },
        State {
            name: "focusing"
            PropertyChanges {
                target: root
                start: focusingGradientDirection.start
                end: focusingGradientDirection.end
                gradient: focusingGradient
            }
        },
        /* BEGIN by Xiong wei, 2016.12.27
         *  Add longpress states
        */
        State {
            name: "longPressing"
            PropertyChanges {
                target: root
                start: longPressingGradientDirection.start
                end: longPressingGradientDirection.end
                gradient: longPressingGradient
            }
        }
        //End by xiongwei 2016.12.27
    ]

    property Gradient normalGradient
    property Gradient pressingGradient: normalGradient
    /* BEGIN by Xiong wei, 2016.12.27
     *  Add longpress states
    */
    property Gradient longPressingGradient: normalGradient
    //End by xiongwei 2016.12.27
    property Gradient checkedNormalGradient
    property Gradient checkedPressingGradient: checkedNormalGradient
    property Gradient disabledGradient
    property Gradient focusingGradient: normalGradient

    property var normalGradientDirection
    property var pressingGradientDirection: normalGradientDirection
    /* BEGIN by Xiong wei, 2016.12.27
     *  Add longpress states
    */
    property var longPressingGradientDirection: normalGradientDirection
    //End by xiongwei 2016.12.27
    property var checkedNormalGradientDirection
    property var checkedPressingGradientDirection: checkedNormalGradientDirection
    property var disabledGradientDirection
    property var focusingGradientDirection: normalGradientDirection

//    property bool direction: true;
}

//Rectangle {
//    id: root
//    state: parent.state
//    states: [
//        State {
//            name: "normal"
//            PropertyChanges {
//                target: root
//                gradient: normalGradient
//            }
//        },
//        State {
//            name: "pressing"
//            PropertyChanges {
//                target: root
//                gradient: pressingGradient
//            }
//        },
//        State {
//            name: "checkedNormal"
//            PropertyChanges {
//                target: root
//                gradient: checkedGradient
//            }
//        },
//        State {
//            name: "checkedPressing"
//            PropertyChanges {
//                target: root
//                gradient: checkedPressingGradient
//            }
//        },
//        State {
//            name: "disabled"
//            PropertyChanges {
//                target: root
//                gradient: disabledGradient
//            }
//        },
//        State {
//            name: "focusing"
//            PropertyChanges {
//                target: root
//                gradient: focusingGradient
//            }
//        }
//    ]

//    property Gradient normalGradient
//    property Gradient pressingGradient: normalGradient
//    property Gradient checkedNormalGradient
//    property Gradient checkedPressingGradient: checkedNormalGradient
//    property Gradient disabledGradient
//    property Gradient focusingGradient: normalGradient
//}

