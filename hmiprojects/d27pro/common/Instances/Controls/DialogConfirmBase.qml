import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

IControls.Dialog{
    id: root;
//    contentWidth: 732;
//    contentHeight: 430;

    property var infoComponent;
    property string texttitle: '';
    property int pixelSizetitle: 36;
    property bool autoCloseAfterConfirmed: true;
    property bool isEnable: true
    signal confirmed;
    signal canceled;

    contentComponent: Component {
        Item {
            width: root.width;
            height: root.height;
            enabled: root.isEnable
            Rectangle{
                id:titlerect;
                width: parent.width;
                height: 110;
                color: themeColor == 0 ?"#103c4b":(themeColor == 1? "#480E05":"#3c2513");
                IControls.NonAnimationText_FontLight {
                    anchors.centerIn: parent;
                    color: "#FFFFFF";
                    text: qsTr(root.texttitle);
                    font.pixelSize: root.pixelSizetitle;
                }
            }
            Image{
                id:line;
                anchors.top: titlerect.bottom;
                source: themeColor == 0?"qrc:/resources/Popup_line.png":(themeColor == 1 ? "qrc:/resources/Popup_line_o.png":"qrc:/resources/Popup_line_g.png");
            }
            Item{
                id:inforect;
                width: parent.width;
                height: parent.height - titlerect.height;
                anchors{
                    top:line.bottom;
                }
//                color:"#103c4b";

                Loader{
                    id:contentLoader;
                    anchors.fill: parent;
                    sourceComponent: infoComponent;
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
                }
                IControls.NonAnimationText_FontLight{
                    anchors.centerIn: confirmBtn;
                    color: "#FFFFFF";
                    font.pixelSize: 36;
                    text:qsTr("确认")
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
                }
                IControls.NonAnimationText_FontLight{
                    anchors.centerIn: cancelBtn;
                    color: "#FFFFFF";
                    font.pixelSize: 36;
                    text:qsTr("取消")
                }
            }
        }
    }
    onCanceled: close()
    onConfirmed: if (autoCloseAfterConfirmed) close()
}

