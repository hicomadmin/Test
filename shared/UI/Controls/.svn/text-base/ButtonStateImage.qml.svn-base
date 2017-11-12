import QtQuick 2.0

Icon {
    id: root
    state: parent.state
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: root
                source: normalSource
            }
        },
        State {
            name: "pressing"
            PropertyChanges {
                target: root
                source: pressingSource
            }
        },
        State {
            name: "checkedNormal"
            PropertyChanges {
                target: root
                source: checkedNormalSource
            }
        },
        State {
            name: "checkedPressing"
            PropertyChanges {
                target: root
                source: checkedPressingSource
            }
        },
        State {
            name: "disabled"
            PropertyChanges {
                target: root
                source: disabledSource
            }
        },
        State {
            name: "focusing"
            PropertyChanges {
                target: root
                source: focusingSource
            }
        }
    ]

    property url normalSource
    property url pressingSource: normalSource
    property url checkedNormalSource: normalSource
    property url checkedPressingSource: normalSource
    property url disabledSource
    property url focusingSource: normalSource
}
