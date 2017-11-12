import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/UI/Private' as UPrivate
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

UPrivate.Control {
    id: root

    property alias comboboxRecWidth: comboboxRec.width
    property alias comboboxRecHeight: comboboxRec.height
    property alias listViewDropHeight: listView.height
    property alias listViewHeight: listView.listHeight
    property alias devLabelText: devLabel.text
    property int bthemeflag
    property alias showState: root.state     //展开状态, dropDown:展开
    property var listViewModel;

    property alias butVisible: button.visible

    signal buttonConnectSignal(int index)
    Rectangle {
        id: comboboxRec
        smooth: true
        color: "#2c2d2f"
        opacity: 0.3

        UControls.Label {
            id: devLabel
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 68
            font.pixelSize: 32
            color: "#9fa5ab"

        }

        UControls.IconButton {
            id:button
            width: 35
            height: 35
            anchors.right: comboboxRec.right
            anchors.rightMargin: 90
            anchors.verticalCenter: comboboxRec.verticalCenter

            normalSource: bthemeflag == 0 ? "qrc:/resources-hf/Phone_Icon_ connect_right.png":
                                          (bthemeflag == 1 ? "qrc:/resources-hf/Phone_Icon_connect-right.png":"qrc:/resources-hf/Phone_Icon_ connect_right_g.png")
            pressingSource: bthemeflag == 0 ? "qrc:/resources-hf/Phone_Icon_ connect_right.png":
                                          (bthemeflag == 1 ? "qrc:/resources-hf/Phone_Icon_connect-right.png":"qrc:/resources-hf/Phone_Icon_ connect_right_g.png")


            onClicked: {
                console.debug("root.state = " + root.state);
                root.state = root.state==="dropDown"?"":"dropDown"
            }
        }
    }

    IControls.ListViewA {
        id:listView
        property variant listHeight
        anchors.left: comboboxRec.left
        anchors.top: comboboxRec.bottom
        height: 0
        width: 1038
        navbarRightMargin: 10;
        model: listViewModel

        delegate: ListItemDelegateA {
            id: listDelegate
            width: 1000
            btnname: showButtonText(hfpconnectState, a2dpconnectState)
            iconurl: "qrc:/resources-hf/Phone_Icon_ connect_sj.png"
            phonename: devName;
            phonestate: showPhoneStateText(hfpconnectState, a2dpconnectState, pairedState)
            thememodel: bthemeflag
            onNotifyclicked: {
                root.buttonConnectSignal(index);
                console.log("[comboxlist] hfpconnectState = ",hfpconnectState);
//                pairedDevsInfo[index].hfpconnectState
            }

        }

    }

    states:
        State {
        name: "dropDown";
        PropertyChanges { target: listView; height: 350; z: 2}
        PropertyChanges { target: button;
//            normalSource: "qrc:/resources-hf/Phone_Icon_ connect_lower.png";
//            pressingSource: "qrc:/resources-hf/Phone_Icon_ connect_lower.png"

            normalSource: bthemeflag == 0 ? "qrc:/resources-hf/Phone_Icon_ connect_lower.png":
                                          (bthemeflag == 1 ? "qrc:/resources-hf/Phone_Icon_connect-lower.png":"qrc:/resources-hf/Phone_Icon_ connect_lower_g.png")
            pressingSource: bthemeflag == 0 ? "qrc:/resources-hf/Phone_Icon_ connect_lower.png":
                                          (bthemeflag == 1 ? "qrc:/resources-hf/Phone_Icon_connect-lower.png":"qrc:/resources-hf/Phone_Icon_ connect_lower_g.png")

        }
    }


    function showButtonText(hfConncetState, a2dpConncetState) {
        var showText = (hfConncetState == 1 || a2dpConncetState == 1)?qsTr("断开"):qsTr("连接");
        return showText;
    }

    function showPhoneStateText(hfConncetState, a2dpConncetState, pairState) {
        console.log("[comboxlist] showButtonText hfConncetState = ",hfConncetState)
        console.log("[comboxlist] showButtonText a2dpConncetState = ",a2dpConncetState)
        console.log("[comboxlist] showButtonText pairState = ",pairState)

        var showText = (hfConncetState ==1 || a2dpConncetState == 1)?qsTr("已连接"):qsTr("未连接")

        if(showText === qsTr("已连接")) {
            if(hfConncetState != 1) {
                showText = qsTr("已连接(无手机音频)")
            }

            if(a2dpConncetState != 1) {
                showText = qsTr("已连接(无媒体音频)")
            }
        }

        if(showText === qsTr("未连接")) {
            showText = (pairState==1)?qsTr("已配对"):qsTr("未连接");
        }

        return showText;
    }
}


