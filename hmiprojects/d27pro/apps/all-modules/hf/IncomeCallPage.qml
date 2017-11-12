import QtQuick 2.0
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
    property string cachePage;
    property bool threeincomecallflag: false;
    property int interfacemodel

    onBtctlChanged: {
        telStatus = Qt.binding(function (){return btctl.telStatus})
        phoneCallNumber = Qt.binding(function (){return btctl.currentTalkInfo.number});
        phoneCallName = Qt.binding(function (){return btctl.currentTalkInfo.name});
    }

    /*telStatus: 0：来电; 1：通话中; 2：去电; 3：第三方来电;
             4：三方通话中; 5: 三方去电;  6: 通话结束*/

    onTelStatusChanged: {
        console.debug("[IncomeCallPage] onTelStatusChanged telStatus = ",telStatus);
    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    Image {
        id: headLogo
        height: 319
        width: 319
        anchors.left: parent.left
        anchors.leftMargin: 129
        anchors.top: parent.top
        anchors.topMargin: 169-92
        source: interfacemodel==0 ? "qrc:/resources-hf/Phone_Telephone_head.png":
                (interfacemodel==1 ? "qrc:/resources-hf/Phone_Telephone-head.png":"qrc:/resources-hf/Phone_Telephone_head_g.png")
    }

    UControls.NonAnimation_Text {
        id: nameLabel
        anchors.left: headLogo.right
        anchors.leftMargin: 243
        anchors.top: parent.top
        anchors.topMargin: 174-92
        text: textOverMaxLength(phoneCallName)
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
        text: phoneCallNumber;
        font.pixelSize: 42
        height: 42
        color: '#bac9cd'
        width:550
        elide:Text.ElideRight
    }

    UControls.NonAnimation_Text {
        id: callstateLabel
        anchors.left: headLogo.right
        anchors.leftMargin: 243
        anchors.top: numberLabel.bottom
        anchors.topMargin: 138
        text: qsTr("来电…")
        font.pixelSize: 42
        height: 42
        font.bold: true
        color: '#ffffff'
    }

    IControls.IconButton_Normal {
        id: connectButton
        width: 640
        height: 147
        source:"qrc:/resources-hf/Phone_Btn_ call.png"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        themeColor: interfacemodel;

        onClicked: {
            btctl.answerCall(true);
            //modify by gaojun -begin (threeincomecallflag is unused, if called answerCall(false),the first call will be hangup)
//            console.log("[IncomeCallPage] threeincomecallflag = ",threeincomecallflag);
//            if(threeincomecallflag){
//                btctl.answerCall(true);
//                console.log("[IncomeCallPage] threeincomecall answerCall()!!!");
//            }else{
//                btctl.answerCall(false);
//            }
            //-end
        }
    }

    Image {
        id: image1
        height: 147
        width: 8
        anchors.left: parent.left
        anchors.leftMargin: 640
        anchors.bottom: parent.bottom
        source: "qrc:/resources-hf/Phone_Button_Line.png"
        z: 2
    }

    IControls.IconButton_Normal {
        id: handupButton
        width: 640
        height: 147
        source: "qrc:/resources-hf/Phone_Btn_ Hang up.png"
        anchors.left: parent.left
        anchors.leftMargin: 640+8
        anchors.bottom: parent.bottom
        themeColor: interfacemodel;

        onClicked: {
            btctl.refuseCall();
            if(threeincomecallflag){
                //application.changePage("incallpage");
                console.log("[IncomeCallPage] threeincomecall refuseCall()!!!");
            }else{
                //application.back();
                console.log('[IncomeCallPage] refuseCall()!!!')
            }

        }

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



