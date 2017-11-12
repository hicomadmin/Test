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
    property bool connectStates: false
    property bool phoneflag: true

    property bool changetophone: true  //false: 手机接听模式 true: 车机接听模式

    property bool mute
    property int answerModel
    property bool isFirstCall: false
    property int seconds: 0
    property int interfacemodel

    property int telStatus

    property string phoneCallNumber: ''
    property string phoneCallName: ''
    property string bgphoneCallNumber: ''
    property string bgphoneCallName: ''

    onBtctlChanged: {
        telStatus = Qt.binding(function (){return btctl.telStatus});
        phoneCallNumber = Qt.binding(function (){return btctl.currentTalkInfo.number});
        phoneCallName = Qt.binding(function (){return btctl.currentTalkInfo.name});

        bgphoneCallNumber = Qt.binding(function (){return btctl.backTalkInfo.number});
        bgphoneCallName = Qt.binding(function (){return btctl.backTalkInfo.name});

        answerModel = Qt.binding(function (){return btctl.answerModel});
        mute = Qt.binding(function (){return btctl.mute});
        console.log('[ThreeCalling] firstCallTime = ',application.pageStack.findById('inCallPage').item.firstCallTime)

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

    /*telStatus: 0：来电; 1：通话中; 2：去电; 3：第三方来电;
             4：三方通话中; 5: 三方去电;  6: 通话结束*/
    onTelStatusChanged: {
        console.log("[ThreeCalling] telStatus = ",telStatus);
    }

    onAnswerModelChanged: {
        console.debug("[ThreeCalling] onAnswerModelChanged answerModel = ",answerModel);
        if (answerModel == 1) {
            changetophone = false;
        }
        if (answerModel == 2) {
            changetophone = true;
        }
    }

    onItemShowing: {
        console.debug("[ThreeCalling] onItemShowing callingTime.start()");
        callingTime.start();
        application.isThreeCalling = true;
        application.secondNumber = phoneCallNumber;
    }

    Timer {
        id: callingTime
        interval: 1000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            seconds ++;
            application.secondCallSeconds = seconds;
            console.debug("[onTimerTriggered] second call time = ", seconds);
            var hour, minute, second;
            hour = getInt(Math.floor(seconds / 3600));
            minute = getInt(Math.floor((seconds % 3600) / 60));
            second = getInt(Math.floor((seconds % 3600) % 60));
            if(isFirstCall) {
                //callTimeLabel.text = application.pageStack.findById('incallpage').item.firstCallTime;
                callTimeLabel.text = application.firstCallTime;
            } else {
                callTimeLabel.text = hour + ":" + minute + ":" + second;
            }

        }
        function getInt (number) {
            if (number < 10)
                number = "0" + number;
            return number;
        }
    }

    Rectangle {
        id: timeRec
        width: 151
        height: 84
        anchors.left: parent.left
        anchors.leftMargin: 1280-41-151
        anchors.top: parent.top
        anchors.topMargin: 123
        color: "#00000000"
        UControls.NonAnimation_Text {
            id:callTimeLabel
            anchors.centerIn: timeRec
            text: ''
            font.pixelSize: 36
            color: "#ffffff"
        }
    }

    IControls.RoundLabButtonC {
        id: changebutton
        width: 151
        height: 84
        anchors.left: parent.left
        anchors.leftMargin: 1280-41-151
        anchors.top: parent.top
        anchors.topMargin: 328
        themeColor: interfacemodel;

        UControls.NonAnimation_Text {
            anchors.centerIn: changebutton
            text: qsTr("切换")
            font.pixelSize: 36
            color: "#ffffff"
        }
        onClicked: {
            //fix bug-1655 by gaojun 2017-1-18
//            if(phoneflag){
//                phoneflag = false;
//            }else {
//                phoneflag = true;
//            }
            isFirstCall = !isFirstCall;

            btctl.switchCalls()
        }
    }

    //电话一
    Image {
        id: headLogo1
        height: 203
        width: 203
        anchors.left: parent.left
        anchors.leftMargin: 71
        anchors.top: parent.top
        anchors.topMargin: 125-92
        source: interfacemodel==0 ? "qrc:/resources-hf/Phone_Telephone_head2.png":
                (interfacemodel==1 ? "qrc:/resources-hf/Phone_Telephone-head2.png":"qrc:/resources-hf/Phone_Telephone_head2.png")
    }

    UControls.NonAnimation_Text {
        id: nameLabel1
        anchors.left: headLogo1.right
        anchors.leftMargin: 13
        anchors.top: parent.top
        anchors.topMargin: 170-92
        //fix bug-1655 by gaojun 2017-1-18
        //text: textOverMaxLength(phoneflag ? phoneCallName:bgphoneCallName)
        text: textOverMaxLength(phoneCallName)
        font.pixelSize: 48
        color: '#8fece2'
        width:503
        elide:Text.ElideRight
    }

    UControls.NonAnimation_Text {
        id: numberLabel1
        anchors.left: headLogo1.right
        anchors.leftMargin: 13
        anchors.top: nameLabel1.bottom
        anchors.topMargin: 37
        //fix bug-1655 by gaojun 2017-1-18
        //text: phoneflag ? phoneCallNumber:bgphoneCallNumber
        text: phoneCallNumber
        font.pixelSize: 36
        color: '#ffffff'
        width:760
        elide:Text.ElideRight
    }

    //电话二
    Image {
        id: headLogo2
        height: 203
        width: 203
        anchors.left: parent.left
        anchors.leftMargin: 71
        anchors.top: headLogo1.bottom
        anchors.topMargin: 21
        source: interfacemodel==0 ? "qrc:/resources-hf/Phone_Telephone_head2.png":
                (interfacemodel==1 ? "qrc:/resources-hf/Phone_Telephone-head2.png":"qrc:/resources-hf/Phone_Telephone_head2.png")
    }

    UControls.NonAnimation_Text {
        id: nameLabel2
        anchors.left: headLogo2.right
        anchors.leftMargin: 13
        anchors.top: parent.top
        anchors.topMargin: 184-92+215
        //fix bug-1655 by gaojun 2017-1-18
        //text:textOverMaxLength(phoneflag ? bgphoneCallName:phoneCallName)
        text:textOverMaxLength(bgphoneCallName)
        font.pixelSize: 48
        color: '#8fece2'
        width:503
        elide:Text.ElideRight
    }

    UControls.NonAnimation_Text {
        id: numberLabel2
        anchors.left: headLogo2.right
        anchors.leftMargin: 13
        anchors.top: nameLabel2.bottom
        anchors.topMargin: 37
        //fix bug-1655 by gaojun 2017-1-18
        //text: phoneflag ? bgphoneCallNumber:phoneCallNumber;
        text: bgphoneCallNumber
        font.pixelSize: 36
        color: '#ffffff'
        width:760
        elide:Text.ElideRight
    }

    Image {
        id: separationLogo
        height: 8
        width: 1174
        anchors.left: parent.left
        anchors.leftMargin: 53
        anchors.top: headLogo1.bottom
        anchors.topMargin: 6
        source: "qrc:/resources-hf/Phone_Telephone_division.png"
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
            console.log("[ThreeCalling] phone hangUp()!!!");
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
        checked: changetophone
        source: "qrc:/resources-hf/Phone_Btn_switch.png";
        bgCheckedNormalGradient: changetophone ? bgPressingGradient:bgGradient;
        bgCheckedPressingGradient: changetophone ? bgPressingGradient:bgGradient;
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 483
        themeColor: interfacemodel;

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
        checked: !mute;
        source:  "qrc:/resources-hf/Phone_Btn_Mute.png"
        bgCheckedNormalGradient: !mute ? bgPressingGradient:bgGradient;
        bgCheckedPressingGradient: !mute ? bgPressingGradient:bgGradient;
        anchors.left: parent.left
        anchors.leftMargin: 750
        anchors.bottom: parent.bottom
        themeColor: interfacemodel;

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
        source:  "qrc:/resources-hf/Phone_Btn_Whole.png";
        bgCheckedNormalGradient: bgPressingGradient;
        bgCheckedPressingGradient: bgPressingGradient;
        anchors.left: parent.left
        anchors.leftMargin: 1017
        anchors.bottom: parent.bottom
        themeColor: interfacemodel;

        onClicked: {
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
