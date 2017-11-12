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

    property bool changetophone: true  //false: 手机接听模式 true: 车机接听模式

    property int telStatus
    property string phoneCallNumber: ''
    property string phoneCallName: ''
    property int answerModel
    property bool mute
    //property int seconds: 0
    property string cachePage;
    property bool threeincomecallflag: false;
    property alias firstCallTime: callTimeLabel.text
    property int interfacemodel

    onItemHiden: {
//        seconds = 0;
    }

    onBtctlChanged: {
        telStatus = Qt.binding(function (){return btctl.telStatus});
        phoneCallNumber = Qt.binding(function (){return btctl.currentTalkInfo.number});
        phoneCallName = Qt.binding(function (){return btctl.currentTalkInfo.name});
        answerModel = Qt.binding(function (){return btctl.answerModel});
        mute = Qt.binding(function (){return btctl.mute});

        console.debug("[InCallPage] onHfpChanged answerModel = ",answerModel);
        if (answerModel == 1) {
            changetophone = false;
        }
        if (answerModel == 2) {
            changetophone = true;
        }
    }
    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    /*通话中：
      telStatus: 0：来电; 1：通话中; 2：去电; 3：第三方来电;
             4：三方通话中; 5: 三方去电;  6: 通话结束*/

    onTelStatusChanged: {
        //console.debug("[InCallPage] telStatus = ",telStatus);
        //console.debug("[InCallPage] onTelStatusChanged application.currentPage = ",application.currentPage);

        /* BEGIN by Zhang Yi, 2016.11.15
         * After the phone call, screen should back to the last.
         * Delete these codes because of 'application.back()' has been called by HomePage.
         * See: Bug #600, #667, #745.
        */
        /*if (application.currentPage === 'incallpage' && telStatus === 6) {
            application.back();
        } else */
        /* END - by Zhang Yi, 2016.11.15 */
//        if (application.currentPage === 'incallpage' && telStatus === 4) {
//            threeincomecallflag = true;
//            application.changePage('incomecallpage',{properties:{threeincomecallflag: threeincomecallflag}});
//        }
    }

    onMuteChanged: {
        console.debug("[InCallPage] onMuteChanged mute = ",mute);
    }

    onAnswerModelChanged: {
        console.debug("[InCallPage] onAnswerModelChanged answerModel = ",answerModel);
        if (answerModel == 1) {
            changetophone = false;
        }
        if (answerModel == 2) {
            changetophone = true;
        }
    }

    onItemShowing: {
        console.debug("[InCallPage] onItemShowing callingTime.start(), isThreeCalling= ", application.isThreeCalling);
        console.debug("[InCallPage] currentNumber = ", application.currentNumber);
        console.debug("[InCallPage] firstNumber = ", application.firstNumber);
        if (application.isThreeCalling) {
            application.isThreeCalling = false;
            if (application.currentNumber === application.firstNumber) {
                callTimeLabel.text = Qt.binding(function(){return application.firstCallTime;});
            } else {
                application.restartFirstTimer();
                callTimeLabel.text = Qt.binding(function(){return application.firstCallTime;});
                application.firstNumber = phoneCallNumber;
            }
        } else {
            application.startFirstTimer();
            callTimeLabel.text = Qt.binding(function(){return application.firstCallTime;});
            application.firstNumber = phoneCallNumber;
        }
    }



//    Timer {
//        id: callingTime
//        interval: 1000
//        repeat: true
//        triggeredOnStart: true
//        onTriggered: {
//            seconds ++;
//            console.debug("[onTimerTriggered] first call time = ", seconds);
//            var hour, minute, second;
//            hour = getInt(Math.floor(seconds / 3600));
//            minute = getInt(Math.floor((seconds % 3600) / 60));
//            second = getInt(Math.floor((seconds % 3600) % 60));
//            callTimeLabel.text = hour + ":" + minute + ":" + second;
//        }
//        function getInt (number) {
//            if (number < 10)
//                number = "0" + number;
//            return number;
//        }
//    }


    Item {
        id: bgRec
        anchors.fill: parent;

        Image {
            id: headLogo
            height: 319
            width: 319
            anchors.left: bgRec.left
            anchors.leftMargin: 129
            anchors.top: bgRec.top
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
            font.pixelSize: 72
            height: 72
            color: '#a2fefb'
            width:550
            elide:Text.ElideRight
            text: {
                var labelName;

                if(phoneCallName != ""){
                    labelName = phoneCallName;
                }
                else{
                    labelName = qsTr("未知");
                }

                labelName;
            }
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
            id: callTimeLabel
            anchors.left: headLogo.right
            anchors.leftMargin: 243
            anchors.top: numberLabel.bottom
            anchors.topMargin: 138
            text : ' '
            font.pixelSize: 30
            height: 30
            color: '#ffffff'
        }
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
            console.log("[InCallPage] phone hangUp()!!!");
            btctl.hangUp();
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
        disabled: telStatus == 3;
        checked: changetophone;
        source: "qrc:/resources-hf/Phone_Btn_switch.png";
        bgDisabledGradient: bgGradient
        bgCheckedNormalGradient: changetophone ? bgPressingGradient:bgGradient;
        bgCheckedPressingGradient: changetophone ? bgPressingGradient:bgGradient;
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 483
        themeColor: interfacemodel

        onClicked: {
            btctl.setAnswerModel();
        }

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
        disabled: telStatus == 3;
        checked: !mute;
        source: "qrc:/resources-hf/Phone_Btn_Mute.png"
        bgDisabledGradient: bgGradient
        bgCheckedNormalGradient: !mute ? bgPressingGradient:bgGradient;
        bgCheckedPressingGradient: !mute ? bgPressingGradient:bgGradient;

        anchors.left: parent.left

        anchors.leftMargin: 750
        anchors.bottom: parent.bottom
        themeColor: interfacemodel

        onClicked: {
            btctl.setMute();
        }
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
        disabled: telStatus == 3;
        source: "qrc:/resources-hf/Phone_Btn_Whole.png";
        bgDisabledGradient: bgGradient
        bgFocusingGradient: bgPressingGradient
        anchors.left: parent.left
        anchors.leftMargin: 1017
        anchors.bottom: parent.bottom
        themeColor: interfacemodel

        onClicked: {
            console.log('[incallpage] chang to realtime page!!!')
//            application.changePage("realtimeKeyboard",{properties: {cachePage: cachePage}});
            application.changePage("realtimeKeyboard");
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

}


