import QtQuick 2.3

Button {
    id: root

    property alias bgSourceComponent: bgLoader.sourceComponent
    property bool layerDisp;

    property alias normalColor:image.normalColor
    property alias pressingColor:image.pressingColor
    property alias checkedNormalColor: image.checkedNormalColor
    property alias checkedPressingColor: image.checkedPressingColor
    property alias disabledColor:image.disabledColor
    property alias focusingColor: image.focusingColor

    property alias normalOpacity:image.normalOpacity
    property alias pressingOpacity:image.pressingOpacity
    property alias checkedNormalOpacity: image.checkedNormalOpacity
    property alias checkedPressingOpacity: image.checkedPressingOpacity
    property alias disabledOpacity:image.disabledOpacity
    property alias focusingOpacity: image.focusingOpacity


    Loader {
        id: bgLoader
        active: true
        z: layerDisp ? 2:1;
        anchors.fill: parent
    }
    ButtonStateImageOverlay {
        id: image
        z: layerDisp ? 1:2;
        anchors.fill: parent
    }
}


