import QtQuick.Controls 1.2
import QtQuick 2.3
import 'qrc:/UI/Controls' as Controls
import TheXAudio 1.0

Slider {
    id: root

    property bool checked: false
    property bool disabled: false
    property real focusStepSize: stepSize

    onPressedChanged: {
        if (pressed) {
            console.debug("slider UControls Beep");
            SoundCommon.beep(0);
        }
    }

    /*MouseArea is not set anchor.fill, it is invalid*/
    /*
    MouseArea {
        enabled: !root.disabled
        onClicked: root.clicked()
        onPressAndHold: root.longPressed()
        onPressed: root._pressed()
        onReleased: root.released()
    }*/
}
