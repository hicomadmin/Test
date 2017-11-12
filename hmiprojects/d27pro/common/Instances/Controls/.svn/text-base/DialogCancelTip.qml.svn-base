import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

IControls.Dialog{
    id: root;
    contentWidth: 692
    contentHeight: 280

    property real progress;
    property int autoCloseTimeout: 3000
    property bool autoClose: true
    property string text: ''
    property int pixelSize: 28

    property int parentwidth: 0;
    property int parentheight: 0;

    signal canceled;

    contentComponent: Component {   //弹出框中的内容
        Item {
            id:content;
            width: root.width;
            height: root.height;

            IControls.NonAnimationText_FontLight{
                id: info;
                anchors.top: parent.top;
                anchors.topMargin: 70;
                anchors.horizontalCenter: parent.horizontalCenter;
                color: "#FFFFFF";
                font.pixelSize: root.pixelSize;
                text: qsTr(root.text);
            }

            IControls.ImageButton {
                id: confirmBtn
                width: 570;
                height: 104;
                anchors.top: parent.top;
                anchors.topMargin: 150;
                anchors.horizontalCenter: parent.horizontalCenter;
                onClicked: root.canceled();
                themeColor: root.themeColor;
                normalSource: "qrc:/resources/setting_completed_exe.png";
                pressingSource: themeColor ==0 ?"qrc:/resources/setting_completed_exe_blue.png":(themeColor == 1?"qrc:/resources/setting_completed_exe_orange.png":"qrc:/resources/setting_completed_exe_gold.png");
            }
            UControls.Label{
                anchors.centerIn: confirmBtn;
                color: "#FFFFFF";
                font.pixelSize: 36;
                text:qsTr("取消")
            }
        }
    }

    onOpened: {
        if (autoClose) autoCloseTimer.restart();
    }
    onClosed: {
        if (autoClose) autoCloseTimer.stop();
    }
    onCanceled: close();

    Timer {
        id: autoCloseTimer
        interval: autoCloseTimeout
        repeat: false
        onTriggered: { root.close(); }
    }
}


