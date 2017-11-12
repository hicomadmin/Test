import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

IControls.Dialog{
    id: root;
    contentWidth: 732
    contentHeight: 258

    property real progress;
    property real maxvalue: 100;
    property int autoCloseTimeout: 3000
    property bool autoClose: true
    property string text: ''
    property int pixelSize: 36

    property int parentwidth: 0;
    property int parentheight: 0

    contentComponent: Component {   //弹出框中的内容
        Item {
            id:content;
            width: root.width;
            height: root.height;

            Image {
                id: runSource;
                anchors.top: parent.top;
                anchors.topMargin: 44;
                anchors.horizontalCenter: parent.horizontalCenter;
                antialiasing:true;
                smooth: true;
                source: "qrc:/resources/Popup_icon_running.png";


                NumberAnimation on rotation {
                    from: 0;
                    to:360;
                    loops: Animation.Infinite;
                    duration: 1000;
                }
            }

            UControls.Label{
                id: info;
                anchors.top: runSource.bottom;
                anchors.topMargin: 44;
                anchors.horizontalCenter: runSource.horizontalCenter;
                color: "#FFFFFF";
                font.pixelSize: 32;
                text: qsTr(root.text);
            }
        }
    }

    onOpened: {
        if (autoClose) autoCloseTimer.restart();
    }
    onClosed: {
        if (autoClose) autoCloseTimer.stop();
    }
    onProgressChanged: {
        console.debug("ProgressChanged: ",progress);
        if(progress === maxvalue){
            root.close();
        }
    }

    Timer {
        id: autoCloseTimer
        interval: autoCloseTimeout
        repeat: false
        onTriggered: { root.close(); }
    }
}
