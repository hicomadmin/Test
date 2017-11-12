import QtQuick 2.3

Rectangle {
    id: root
    state: parent.state
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: root
                gradient: normalGradient
            }
        },
        State {
            name: "pressing"
            PropertyChanges {
                target: root
                gradient: pressingGradient
            }
        },
        State {
            name: "checkedNormal"
            PropertyChanges {
                target: root
                gradient: checkedNormalGradient
            }
        },
        State {
            name: "checkedPressing"
            PropertyChanges {
                target: root
                gradient: checkedPressingGradient
            }
        },
        State {
            name: "disabled"
            PropertyChanges {
                target: root
                gradient: disabledGradient
            }
        },
        State {
            name: "focusing"
            PropertyChanges {
                target: root
                gradient: focusingGradient
            }
        }
    ]

    property Gradient pressingGradient: pressingGradient


    property Gradient normalGradient: normalGradient
    property Gradient checkedNormalGradient: checkedNormalGradient
    property Gradient checkedPressingGradient: checkedPressingGradient
    property Gradient disabledGradient: disabledGradient
    property Gradient focusingGradient: focusingGradient

}
