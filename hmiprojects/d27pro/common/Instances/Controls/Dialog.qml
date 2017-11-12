import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls

UControls.Dialog {
    id: root
    property int themeColor
    shadowComponent: Component {  //整个窗口背景
        Rectangle {
            color: "#000000";
            opacity: 0.85
        }
    }
    bgComponent: Component {   //弹出框
        Rectangle {
            id: contentBg;
            color: themeColor == 0 ? "#103c4b":(themeColor == 1 ?"#480E05":"#3c2513");
            opacity: 0.9;
        }
    }
}

