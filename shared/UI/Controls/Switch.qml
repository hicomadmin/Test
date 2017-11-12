import QtQuick.Controls 1.2
import TheXAudio 1.0

Switch {
    // TODO
    onClicked: {
        console.debug("UControls Beep");
        SoundCommon.beep(0);
    }
}
