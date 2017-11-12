import QtQuick 2.3
import 'qrc:/UI/Controls' as Controls

Controls.Button {
    id: root
    property alias bgSourceComponent: bgLoader.sourceComponent

    property alias source: icon.source
    property alias normalSource: icon.normalSource
    property alias pressingSource: icon.pressingSource
    property alias checkedNormalSource: icon.checkedNormalSource
    property alias checkedPressingSource: icon.checkedPressingSource
    property alias disabledSource: icon.disabledSource
    property alias focusingSource: icon.focusingSource
    property alias icon: icon

    Loader {
        id: bgLoader
        active: true
        anchors.fill: parent
    }
    ButtonStateImage {
        id: icon
        anchors.centerIn: parent
    }
}
