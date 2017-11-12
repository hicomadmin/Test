import QtQuick 2.3

ButtonState {
    id: root

//    property alias border: rectangle.border
//    property alias radius: rectangle.radius
//    property alias rectangle: rectangle
    property alias contentcompent: bgLoader.sourceComponent

    property alias gradient: linearGradient.normalGradient
    property alias normalGradient: linearGradient.normalGradient
    property alias pressingGradient: linearGradient.pressingGradient
    property alias checkedNormalGradient: linearGradient.checkedNormalGradient
    property alias checkedPressingGradient: linearGradient.checkedPressingGradient
    property alias disabledGradient: linearGradient.disabledGradient
    property alias focusingGradient: linearGradient.focusingGradient

    property alias normalGradientDirection: linearGradient.normalGradientDirection
    property alias pressingGradientDirection: linearGradient.pressingGradientDirection
    property alias checkedNormalGradientDirection: linearGradient.checkedNormalGradientDirection
    property alias checkedPressingGradientDirection: linearGradient.checkedPressingGradientDirection
    property alias disabledGradientDirection: linearGradient.disabledGradientDirection
    property alias focusingGradientDirection: linearGradient.focusingGradientDirection

    ButtonStateGradient {
        id: linearGradient
        anchors.fill: parent
    }

    Loader {
        id: bgLoader
        active: true
        anchors.centerIn: parent
    }
}
