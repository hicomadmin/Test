import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

IControls.Dialog{
    id: root;
    contentWidth: 732;
    contentHeight: 430;

    property var infoComponent;
    property string texttitle: '';
    property int pixelSizetitle: 36;
    property bool autoCloseAfterConfirmed: true;
    property bool isEnable: true
    signal confirmed;
    signal canceled;
    property int autoCloseTimeout: 3000
    property bool autoClose: false
    property string textinfo: '';
    property int pixelSizeinfo: 36;
    property real stringWidth

    contentComponent: Component {
        Item {
            width: root.contentWidth;
            height: root.contentHeight;
            enabled: root.isEnable

            Rectangle{
                anchors.fill: parent;
                color: themeColor == 0 ?"#103c4b":(themeColor == 1? "#480E05":"#3c2513")

                IControls.NonAnimationText_FontLight {
                   id: text
                   anchors {
                       top: parent.top;
                       topMargin: 86; // fixme
                       //horizontalCenter: parent.horizontalCenter;
                       left: parent.left
                       leftMargin: 20
                       right: parent.right
                       rightMargin: 20
                       bottom: parent.bottom
                       bottomMargin: 20
                   }
                   color: "#FFFFFF";
                   text: qsTr(root.textinfo);
                   font.pixelSize: root.pixelSizeinfo;
                   wrapMode: Text.WordWrap
                   horizontalAlignment: (stringWidth < 732) ? Text.AlignHCenter : Text.AlignLeft

                   Component.onCompleted: {
                       stringWidth = text.contentWidth
                   }
               }
            }

            Item {
                width: parent.width;
                height: confirmBtn.height
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 25  // fixme
                }
                IControls.ImageButton {
                    id: confirmBtn
                    width: 340;
                    height: 104;
                    anchors.left: parent.left
                    anchors.leftMargin: 16;
                    onClicked: root.confirmed();
                    themeColor: root.themeColor;
                    normalSource: "qrc:/resources/setting_completed_exe.png";
                    pressingSource: themeColor ==0 ?"qrc:/resources/setting_completed_exe_blue.png":(themeColor == 1?"qrc:/resources/setting_completed_exe_orange.png":"qrc:/resources/setting_completed_exe_gold.png");
                    IControls.NonAnimationText_FontLight{
                        anchors.centerIn: parent;
                        color: "#FFFFFF";
                        font.pixelSize: 36;
                        text:qsTr("确认")
                    }
                }
                IControls.ImageButton {
                    id: cancelBtn
                    width: 340;
                    height: 104;
                    anchors.right: parent.right;
                    anchors.rightMargin: 16;
                    onClicked: root.canceled();
                    themeColor: root.themeColor;
                    normalSource: "qrc:/resources/setting_completed_exe.png";
                    pressingSource: themeColor ==0 ?"qrc:/resources/setting_completed_exe_blue.png":(themeColor == 1?"qrc:/resources/setting_completed_exe_orange.png":"qrc:/resources/setting_completed_exe_gold.png");
                    IControls.NonAnimationText_FontLight{
                        anchors.centerIn: parent;
                        color: "#FFFFFF";
                        font.pixelSize: 36;
                        text:qsTr("取消")
                    }
                }




            }
        }
    }


    onCanceled: close()
    onConfirmed: if (autoCloseAfterConfirmed) close()

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


