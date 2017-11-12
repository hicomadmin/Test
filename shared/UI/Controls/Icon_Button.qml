import QtQuick 2.0

import 'qrc:/UI/Controls' as Controls

Controls.Button {
    id: root
    
    property alias bgOpacity: bgRect.opacity
    property alias bgRadius: bgRect.radius

    property alias bgGradient: bgRect.normalGradient
    property alias bgPressingGradient: bgRect.pressingGradient
    property alias bgCheckedNormalGradient: bgRect.checkedNormalGradient
    property alias bgCheckedPressingGradient: bgRect.checkedPressingGradient
    property alias bgFocusingGradient: bgRect.focusingGradient
    property alias bgDisabledGradient: bgRect.disabledGradient


    property alias source: icon.source
    property alias text: text.text
    property alias font: text.font
    property alias textColor: text.color

    ButtonState_GradientRect{
        id:bgRect
        width: root.width
        height: root.height
        anchors.centerIn: root
    }
    Icon {
        id: icon
        source: source
        anchors.centerIn: root
    }
    Text{
        id:text
        anchors.centerIn: root

    }
}
