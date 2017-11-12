import QtQuick 2.3

Button {
    id: root

    property alias bgSourceComponent: bgLoader.sourceComponent

    property alias text: label.text
    property alias color: label.normalColor
    property alias normalColor: label.normalColor
    property alias pressingColor: label.pressingColor
    property alias checkedNormalColor: label.checkedNormalColor
    property alias checkedPressingColor: label.checkedPressingColor
    property alias disabledColor: label.disabledColor
    property alias focusingColor: label.focusingColor
    property alias label: label

    Loader {
        id: bgLoader
        anchors.fill: parent
    }
    ButtonStateLabel {
        id: label
        anchors.centerIn: parent
    }
}
