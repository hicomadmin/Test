import QtQuick 2.3

Rectangle {
    id: root
    state: parent.state
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: root
                color: normalColor
            }
        },
        State {
            name: "pressing"
            PropertyChanges {
                target: root
                color: pressingColor
            }
        },
        State {
            name: "checkedNormal"
            PropertyChanges {
                target: root
                color: checkedNormalColor
            }
        },
        State {
            name: "checkedPressing"
            PropertyChanges {
                target: root
                color: checkedPressingColor
            }
        },
        State {
            name: "disabled"
            PropertyChanges {
                target: root
                color: disabledColor
            }
        },
        State {
            name: "focusing"
            PropertyChanges {
                target: root
                color: focusingColor
            }
        },
        /* BEGIN by Xiong wei, 2016.12.27
         *  Add longpress states
        */
        State {
            name: "longPressing"
            PropertyChanges {
                target: root
                color: longPressingColor
            }
        }
        //End by xiongwei 2016.12.27

    ]

    property color normalColor
    property color pressingColor: normalColor
    property color checkedNormalColor
    property color checkedPressingColor: checkedNormalColor
    property color disabledColor
    property color focusingColor: normalColor
    /* BEGIN by Xiong wei, 2016.12.27
     *  Add longpress states
    */
    property color longPressingColor: normalColor
    //End by xiongwei 2016.12.27
}
