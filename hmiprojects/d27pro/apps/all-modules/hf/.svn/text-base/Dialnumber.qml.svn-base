import QtQuick 2.0
import Bluetooth 1.0
import TheXSettings 1.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import Apps 1.0

HSTab {
    id: root;
    property bool isCopy: false;
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')

    property int telStatus;
    property int connectState;
    property string phonenumber:""

    property int powerState;
    property bool diallag: false;
    property int interfacemodel;

    onItemHiden: {
        item.enabled = false;
    }

    onItemShown: {
        console.log("[Dialnumber] onItemShown!!!")
        item.enabled = true;
    }

    onBtctlChanged: {
        powerState = Qt.binding(function (){return btctl.powerState});
        connectState = Qt.binding(function (){return btctl.connectState});

        console.debug("[Dialnumber] onConnectChanged powerState = ",powerState);
        console.debug("[Dialnumber] onConnectChanged connectState = ",connectState);

        if(powerState === 2 && isConnect()){
            diallag = true;
        } else {
            diallag = false;
        }
    }

    onSystemChanged: {
           interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    onPowerStateChanged: {
        if(powerState === 2 && isConnect()){
            diallag = true;
        } else {
            diallag = false;
        }
    }

    onConnectStateChanged: {
        if(powerState === 2 && isConnect()){
            diallag = true;
        } else {
            diallag = false;
        }
    }

    function isConnect() {
        console.log('[Dialnumber] isConnect = ', connectState)
        return (connectState&0xf0) === 0x10 || (connectState&0xff) === 0x11
    }

    Item {
        id: item
        anchors.fill: parent;

        IControls.Keyboard_BTHF {
            id: numberKeyboard
            keybd_posx: 130
            themeColor: interfacemodel;
            zeroLongPress: true
        }

        IControls.IconButton_PhoneDIalCall {
            source: "qrc:/resources-hf/Phone_Btn_ call.png"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            themeColor: interfacemodel

            onClicked: {
                if(numberKeyboard.output.text === "*#*#2846579#*#*") {
                    application.multiApplications.changeApplication('engineer')
                    console.debug("[Dialnumber] start engineer mode")
                    return
                }
                console.log('[Dialnumber] diallag = ', diallag)
                if(diallag){
                    if(numberKeyboard.output.text !== ""){
                        phonenumber = numberKeyboard.output.text
                        btctl.phoneCallTask(phonenumber);
                        console.debug("[Dialnumber] phonenumber = ",phonenumber)
                    }
                    else{
                        console.debug("[Dialnumber] Dialnumber is NULL");
                    }
                }else{
                    application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("无法访问移动网络") });
                    //                    application.changePage("threecalling");
                    //                    console.log('change to threecalling!!!')
                }
            }
        }
        /* BEGIN by Ge Wei, 2016.11.15
         * See: Bug #458
         */
//        UControls.GradientBar {
//            anchors.bottom: parent.bottom
//            anchors.left: parent.left
//            gradient_width: 1038
//            underBtnGradient: Gradient {

//                GradientStop{
//                    position: 0.0
//                    color:"#4b4b4b"
//                }
//                GradientStop{
//                    position: 0.5
//                    color:"#a6a8a7"
//                }
//                GradientStop{
//                    position: 1.0
//                    color: "#4b4b4b"
//                }
//            }
//        }
        /*
         * End by Ge Wei, 2016.11.15
         */
    }

}

