import QtQuick 2.0
import 'qrc:/UI/Controls' as Controls

Controls.ColorButton {
    id: root
    transitions: [
        Transition {
            to: "*"
            ColorAnimation {
                target: root.rectangle
                duration: transDuration
            }
        }
    ]

    property int transDuration: 200
}
