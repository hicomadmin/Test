import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

IControls.Dialog{
    id: root;
    contentWidth: parentwidth //282
    contentHeight: 100

    property int autoCloseTimeout: 3000
    property bool autoClose: true
    property string text: ''
    property int pixelSize: 36

    property int parentwidth: 0;
    property int parentheight: 0

    contentComponent: Component {   //弹出框中的内容
        Item {
            UControls.Label {
                anchors.centerIn: parent
                color: "#FFFFFF"
                text: qsTr(root.text)
                font.pixelSize: root.pixelSize
                Component.onCompleted: {
                    parentwidth = width + 128;
                    parentheight = height;
                }
            }
        }
    }

    onOpened: {
        if (autoClose) autoCloseTimer.restart();
    }
    onClosed: {
        if (autoClose) autoCloseTimer.stop();
    }
    Timer {
        id: autoCloseTimer
        interval: autoCloseTimeout
        repeat: false
        onTriggered: { root.close(); }
    }
}
