import QtQuick 2.3
import Bluetooth 1.0
import TheXSettings 1.0
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant

ICore.Page {
    id: root
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property int telStatus
    property string phoneCallNumber: ''
    property string phoneCallName: ''
    property string cachePage
    property int interfacemodel

    property var currentTalkInfo

    onBtctlChanged: {
        telStatus = Qt.binding(function (){return btctl.telStatus})
        phoneCallNumber = Qt.binding(function (){return btctl.currentTalkInfo.number});
        phoneCallName = Qt.binding(function (){return btctl.currentTalkInfo.name});
        currentTalkInfo = Qt.binding(function (){return btctl.currentTalkInfo});
    }

    onSystemChanged: {
         interfacemodel = Qt.binding(function(){return system.interfacemodel});
    }

    onItemShown: {
        console.debug("typeof :", typeof currentTalkInfo);
        if(currentTalkInfo instanceof Object) {
            console.debug("nameLabel.text = ", currentTalkInfo.name, "numberLabel.text = ", currentTalkInfo.number);
            nameLabel.text = textOverMaxLength(currentTalkInfo.name);
            numberLabel.text = currentTalkInfo.number;
        }
    }

    onCurrentTalkInfoChanged: {
        console.debug("[Callpage] onPhoneCallNumberChanged currentTalkInfo = ",currentTalkInfo)
        if(currentTalkInfo instanceof Object) {
            console.debug("[Callpage] onCurrentTalkInfoChanged currentTalkInfo.name = ",currentTalkInfo.name)
            console.debug("[Callpage] onCurrentTalkInfoChanged currentTalkInfo.number = ",currentTalkInfo.number)
            nameLabel.text = textOverMaxLength(currentTalkInfo.name);
            numberLabel.text = currentTalkInfo.number;
        }
    }

//    onPhoneCallNumberChanged: {
//        console.debug("[Callpage] onPhoneCallNumberChanged phoneCallNumber = ",phoneCallNumber)
//        console.debug("[Callpage] onPhoneCallNumberChanged phoneCallName = ",phoneCallName)
////        nameLabel.text = btctl.currentTalkInfo.name !== "" ? btctl.currentTalkInfo.name : qsTr("未知联系人");
////        numberLabel.text = btctl.currentTalkInfo.number;
//    }
    /*telStatus: 0：来电; 1：通话中; 2：去电; 3：第三方来电;
             4：三方通话中; 5: 三方去电;  6: 通话结束*/

    onTelStatusChanged: {
        console.debug("[Callpage] onTelStatusChanged telStatus = ",telStatus);

        if (application.currentPage === 'callpage' && telStatus === 2) {
            console.debug("[Callpage] incallpage = ",telStatus);
            //callLabel.text = ""
//            application.changePage("incallpage",{replace:true});
        }
    }

    Image {
        id: headLogo
        height: 319
        width: 319
        anchors.left: parent.left
        anchors.leftMargin: 129
        anchors.top: parent.top
        anchors.topMargin: 169-92
        source: interfacemodel == 0 ? "qrc:/resources-hf/Phone_Telephone_head.png":
                (interfacemodel == 1 ? "qrc:/resources-hf/Phone_Telephone-head.png":"qrc:/resources-hf/Phone_Telephone_head_g.png")
    }

    UControls.NonAnimation_Text {
        id: nameLabel
        anchors.left: headLogo.right
        anchors.leftMargin: 243
        anchors.top: parent.top
        anchors.topMargin: 174-92
        //text: currentTalkInfo.name;
        font.pixelSize: 72
        height: 72

        color: '#a2fefb'
        width:550
        elide:Text.ElideRight
    }

    UControls.NonAnimation_Text {
        id: numberLabel
        anchors.left: headLogo.right
        anchors.leftMargin: 243
        anchors.top: nameLabel.bottom
        anchors.topMargin: 31
        //text: currentTalkInfo.number;
        font.pixelSize: 42
        height: 42

        color: '#bac9cd'
        width:550
        elide:Text.ElideRight
    }

    UControls.NonAnimation_Text {
        id: callLabel
        anchors.left: headLogo.right
        anchors.leftMargin: 243
        anchors.top: numberLabel.bottom
        anchors.topMargin: 138
        text: qsTr("正在呼叫…");
        font.pixelSize: 42
        font.bold: true
        height: 42

        color: '#ffffff'
    }

    IControls.IconButton_Normal {
        id: handupButton
        width: 475
        height: 147
        source: "qrc:/resources-hf/Phone_Btn_ Hang up.png"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        themeColor: interfacemodel;

        onClicked: {
            btctl.hangUp();
            console.log("[CallPage] phone hangUp()!!!");
        }
    }

    Image {
        id: image1
        height: 147
        width: 8
        anchors.left: parent.left
        anchors.leftMargin: 483-8
        anchors.bottom: parent.bottom
        source: "qrc:/resources-hf/Phone_Button_Line.png"
        z: 2
    }

    IControls.IconButton_Normal {
        id: changeButton
        width: 259
        height: 147
        disabled: true;
        source: "qrc:/resources-hf/Phone_Btn_switch_null.png";
        bgDisabledGradient: bgGradient
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 483
        themeColor: interfacemodel;

    }

    Image {
        id: image2
        height: 147
        width: 8
        anchors.left: parent.left
        anchors.leftMargin: 750-8
        anchors.bottom: parent.bottom
        source: "qrc:/resources-hf/Phone_Button_Line.png"
        z: 2
    }

    IControls.IconButton_Normal {
        id: muteButton
        width: 259
        height: 147
        anchors.left: parent.left
        anchors.leftMargin: 750
        anchors.bottom: parent.bottom
        disabled: true;
        source: "qrc:/resources-hf/Phone_Btn_Mute_null.png"
        bgDisabledGradient: bgGradient
        themeColor: interfacemodel;

    }

    Image {
        id: image3
        height: 147
        width: 8
        anchors.left: parent.left
        anchors.leftMargin: 1017-8
        anchors.bottom: parent.bottom
        source: "qrc:/resources-hf/Phone_Button_Line.png"
        z: 2
    }

    IControls.IconButton_Normal {
        id: keyButton
        width: 263
        height: 147
        source: "qrc:/resources-hf/Phone_Btn_Wholenull.png";
        disabled: true;
        bgDisabledGradient: bgGradient
        anchors.left: parent.left
        anchors.leftMargin: 1017
        anchors.bottom: parent.bottom
        themeColor: interfacemodel;

    }

    UControls.GradientBar {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        gradient_width: 1280
        underBtnGradient: Gradient {

            GradientStop{
                position: 0.0
                color:"#4b4b4b"
            }
            GradientStop{
                position: 0.5
                color:"#a6a8a7"
            }
            GradientStop{
                position: 1.0
                color: "#4b4b4b"
            }
        }

    }

    function textOverMaxLength(text){
        var retText;

        if(text != ""){
            retText = text;
        }
        else{
            retText = qsTr("未知");
        }

        return retText;
    }

}


