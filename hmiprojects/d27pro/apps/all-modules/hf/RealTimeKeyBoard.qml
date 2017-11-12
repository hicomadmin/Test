import QtQuick 2.3
import Bluetooth 1.0
import TheXSettings 1.0
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls


ICore.Page {
    id: root
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property int telStatus

    property bool changetophone: true  //false: 手机接听模式 true: 车机接听模式
    property int answerModel
    property bool mute
    property string cachePage;
    property int interfacemodel

    onBtctlChanged: {
        telStatus = Qt.binding(function (){return btctl.telStatus});
        answerModel = Qt.binding(function (){return btctl.answerModel});
        mute = Qt.binding(function (){return btctl.mute});
        if (answerModel == 1) {
            changetophone = false;
        }
        if (answerModel == 2) {
            changetophone = true;
        }
    }

    onItemShown: {
        console.log("[RealTimeKeyBoard] btctl.getKeyBoardValue() = ", btctl.getKeyBoardValue());
        keyboard.output.text = btctl.getKeyBoardValue()
    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel});
    }

    /*telStatus: 0：来电; 1：通话中; 2：去电; 3：第三方来电;
             4：三方通话中; 5: 三方去电;  6: 通话结束*/

    onTelStatusChanged: {
        console.log("[RealTimeKeyBoard] onTelStatusChanged telStatus = ",telStatus);
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

    IControls.Keyboard_BTHF {
        id:keyboard
        keybd_posx: 251;
        themeColor: interfacemodel;

        onSend: {
            var inputValue = output.text;
            var lengthValue = inputValue.length;
            console.log("[RealTimeKeyBoard] keyboard character = ", character);
//            console.log("[RealTimeKeyBoard] keyboard lengthValue = ", lengthValue);
//            var input = inputValue.substring(lengthValue - 1 , lengthValue);
//            console.log("[RealTimeKeyBoard] keyboard output.text = ", inputValue);
//            console.log("[RealTimeKeyBoard] keyboard input = ", input);
            btctl.setKeyBoardValue(btctl.getKeyBoardValue() + character);
            btctl.callingKeyboardInput(character);
        }
    }


    IControls.IconButton_Normal {
        id: handupButton
        width: 475
        height: 147
        source: "qrc:/resources-hf/Phone_Btn_ Hang up.png"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        themeColor: interfacemodel

        onClicked: {
            //application.changePage("incallpage");
            btctl.hangUp();
            console.log("[RealTimeKeyBoard] phone hangUp()!!!");
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
        checked: changetophone;
        source: "qrc:/resources-hf/Phone_Btn_switch.png";
        bgDisabledGradient: bgGradient
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
        checked: true;
        bgCheckedNormalGradient: bgPressingGradient;
        bgCheckedPressingGradient: bgPressingGradient;
        anchors.left: parent.left
        anchors.leftMargin: 1017
        anchors.bottom: parent.bottom
        themeColor: interfacemodel;

        onClicked: {

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
