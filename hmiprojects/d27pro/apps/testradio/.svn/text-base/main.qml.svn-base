import QtQuick 2.3
import QtQuick.Controls 1.2
import LowDATest.Multimedia 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("RadioDemo")

    RadioCtl {
        id: radioCtl
        onModelAttrChanged: {
            console.log('radioCtl onModelAttrChanged: ', attr, value);
        }
        onPchItemReplaced: {
            console.log(pchIndex, frequency);
        }
        onScanItemAppended: {
            console.log(frequency);
        }
    }
    Column {
        Grid {
            id: properties
            columns: 4
            PropertyLabel {
                text: radioCtl.state === RadioCtl.ActiveState ? qsTr("ActiveState") : qsTr("StoppedState")
            }
            PropertyLabel {
                text: radioCtl.bandGroup
            }
            PropertyLabel {
                text: radioCtl.band
            }
            PropertyLabel {
                text: radioCtl.frequency
            }
        }
        Grid {
            id: slots
            columns: 4
            width: parent.width
            SlotButton {
                text: "start"
                onClicked: radioCtl.start()
            }
            SlotButton {
                text: "stop"
                onClicked: radioCtl.stop()
            }
            SlotButton {
                text: "<"
                onClicked: radioCtl.tuneDown();
            }
            SlotButton {
                text: ">"
                onClicked: radioCtl.tuneUp();
            }
        }
    }
}
