import QtQuick 2.3

Label {
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
        }
    ]

    property color normalColor
    property color pressingColor: normalColor
    property color checkedNormalColor
    property color checkedPressingColor: checkedNormalColor
    property color disabledColor
    property color focusingColor: normalColor
}
