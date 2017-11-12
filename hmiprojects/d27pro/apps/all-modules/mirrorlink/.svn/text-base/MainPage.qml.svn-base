import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Core' as UCore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import TheXAudio 1.0

import TheXMirrorlink 1.0
import TheXDevice 1.0
import TheXSettings 1.0
import TheXMRev 1.0

ICore.Page {
    id: mainPage

    property MirrorlinkCtl mirrorlink: HSPluginsManager.get('mirrorlink')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property MrevCtl mrev: HSPluginsManager.get('mrev')

    property int devState;
    property int devType;
    property string runState;
    property string connectState;
    property string languageState;
    property string muteState;
    property real mobileState;
    property int interfacemodel;
    property real mediaCommon;
    property real soundValue;
    property real volumeValue;
    property string backPressed;

    property bool hasStartMirrorlink : false
    property bool hasDisplayDialog : true

    property bool hasVoiceBarEnable : false
    property bool mirrorlinkDemoAlive : false

    onMirrorlinkChanged: {
        console.log("[MBC][Mirrorlink] onMirrorlinkChanged")
        connectState = Qt.binding(function (){return mirrorlink.connectState})
        languageState = Qt.binding(function (){return mirrorlink.languageState})
        muteState = Qt.binding(function (){return mirrorlink.muteState})
        volumeValue = Qt.binding(function (){return mirrorlink.volumeValue})
        backPressed = Qt.binding(function (){return mirrorlink.backPressed})
    }

    onDevctlChanged: {
        console.log("[MBC][Mirrorlink] onDevctlChanged")
        devState = Qt.binding(function (){return devctl.deviceInfo.devState});
        devType =  Qt.binding(function (){return devctl.deviceInfo.devType});
    }

    onSystemChanged: {
        console.log("[MBC][Mirrorlink] onSystemChan ged")
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
        mobileState = Qt.binding(function(){return system.mobileState})
    }

    onItemShowing: {

        mirrorlinkDemoAlive = (devctl.checkMobileProcessAlive(3) === 1);

        console.debug("[MBC][Mirrorlink] onItemShowing mirrorlinkDemoAlive=",mirrorlinkDemoAlive," connectState=",connectState)

        if((mirrorlinkDemoAlive) && connectState === "4" && devState === 1){
            console.debug("[MBC][Mirrorlink] onItemShowing not draw icon")
            mirrorlink.setMirrorlinkSrc("1");
            load.sourceComponent = connectSucces
            help.visible = false;
            quit.visible = false;
        }else{
            console.debug("[MBC][Mirrorlink] onItemShowing draw icon")

            load.sourceComponent = connectIcon;
            help.visible = true;
            quit.visible = true;
        }
    }

    Connections {
        target: mrev

        onRevStatusChanged: {
            console.log("[MBC][Mirrorlink] [onRevStatusChanged]{interrupt} status",mrev.revStatus)

            if (mrev.revStatus) {
                mirrorlink.setMirrorlinkSrc("2")
            }
            else {
                mirrorlink.setMirrorlinkSrc("1")
            }
        }
    }

    onItemShown: {
        console.debug("[MBC][Mirrorlink] onItemShown mirrorlinkDemoAlive=",mirrorlinkDemoAlive," connectState=",connectState)

        if((mirrorlinkDemoAlive) && connectState === "4" && devState === 1){
            console.debug("[MBC][Mirrorlink] onItemShown not init mirrolink")
            //hasStartMirrorlink = true;
        }else{
            console.debug("[MBC][Mirrorlink] onItemShown init mirrolink")
            checkSysConnectState()
            mirrorlink.initMirrorlink();
            startMirrorlinkEntry()
        }
    }

    onDevStateChanged: {
        console.debug("[MBC][Mirrorlink] onDevStateChanged(),devState : ", devState, "devType : ", devType)
        /*
        if(devState === 1) { // 设备为插入
            if(devType === 4) { //Android
                load.sourceComponent = connecting;
                help.visible = false;
                quit.visible = false;
            }
        }
        else
        {
            if(4 === devType){
                if (application.wndlinkFlag !== true)
                {
                    application.multiApplications.remove('mirrorlink')
                }
            }
        }*/
        checkSysConnectState()
    }

    onDevTypeChanged:{
        console.debug("[MBC][Mirrorlink] onDevTypeChanged,devState : ", devState, "devType : ", devType)
        /*
        if(devState === 1) { // 设备为插入
            if(devType === 4) { //Android
                load.sourceComponent = connecting;
                help.visible = false;
                quit.visible = false;
            }
        }
        else
        {
            if(4 === devType){
                if (application.wndlinkFlag !== true)
                {
                    application.multiApplications.remove('mirrorlink')
                }
            }
        }*/
        checkSysConnectState()
    }


    /*
       connectState: “1”:无连接，”2”:设备插入, ”3”:连接中，”4“:连接成功，”5“:连接错误-连接不稳定，”6“连接错误-手机系统不支持，”7“连接错误-其他
    */
    property var lastConnectState : 0;
    onConnectStateChanged: {
        console.debug("[MBC][Mirrorlink] onConnectStateChanged,connect : ", connectState)
        switch(connectState){
        case "1":
        case "2":
        case "3":

            break;
        case "4":
            if(devState === 1 && lastConnectState !== "4"){
                load.sourceComponent = connectSucces
                help.visible = false;
                quit.visible = false;
            }
            break;
        case "5":
        case "6":
        case "7":
        default:
            load.sourceComponent = connectIcon;
            help.visible = true;
            quit.visible = true
            break;
        }
        lastConnectState = connectState
    }

    onMuteStateChanged: {

    }

    onLanguageStateChanged: {

    }    

    Connections {
        target: SoundCommon

        Component.onCompleted: {
            mediaCommon = Qt.binding(function() {
                console.log("[MBC][Mirrorlink] SoundCommon: value", SoundCommon.mediaVolume," hasStartMirrorlink ",hasStartMirrorlink)
                if(hasVoiceBarEnable === true){
                    mirrorlink.setSoundParams(SoundCommon.mediaVolume, interfacemodel)
                }else{
                    hasVoiceBarEnable = true
                }
            })
        }
    }

    onVolumeValueChanged: {
        console.log("[MBC][Mirrorlink] onVolumeValueChanged: value", volumeValue)
        SoundCommon.setMediaVolume(volumeValue)
    }

    onBackPressedChanged: {
        console.log("[MBC][Mirrorlink] onBackPressedChanged: value", backPressed)
        if("1" === backPressed)
        {
            //mirrorlink.setMirrorlinkSrc("2");
            application.multiApplications.back()
        }
    }

/*--------------*/
    function checkSysConnectState(){

        if(devState === 1) { // 设备为插入
            if(devType === 4) { //Android
                mirrorlink.setMirrorlinkSrc("1")
                load.sourceComponent = connecting;
                help.visible = false;
                quit.visible = false;
            }
        }
        else
        {
            if(4 === devType){
                if (application.wndlinkFlag !== true)
                {
                    application.multiApplications.remove('mirrorlink')
                }else{

                }
            }
            load.sourceComponent = connectIcon;
            help.visible = true;
            quit.visible = true;
            //mirrorlink.setMirrorlinkSrc("2")
        }

    }


    function startMirrorlinkEntry(){
        console.log("-----[MBC][Mirrorlink] startMirrorlinkEntry default-mobile(",mobileState,")")
        //TUHAOMING   startMirrorlink.start();
        if(hasStartMirrorlink === false){
            if(mobileState === 3){
                hasDisplayDialog = false
            }else{
                hasDisplayDialog = true;
                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,textinfo:qsTr('是否将MirrorLink设置为默认车机互联?'),autoClose:true,autoCloseTimeout:3000,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
            }
            hasStartMirrorlink = true;
        }else{
            console.log("-----[MBC][Mirrorlink] startMirrorlinkEntry already start mirrorlink not again")
        }
    }

    function dialogConfirmTip(dialog){
        console.log("-----[MBC][Mirrorlink] dialogConfirmTip")

        hasDisplayDialog = false;

        dialog.confirmed.connect(function confirmed(){
            console.debug("-----[MBC][Mirrorlink]setMobileState:");
            system.setMobileState(3);
        });
    }
/*------------------*/
    Timer {
        id: startMirrorlink
        interval: 3000;
        running: false;
        repeat: false;
        triggeredOnStart: false;
        onTriggered: mirrorlink.setMirrorlinkSrc("1");
    }

    Image {
        id: bg
        source: "qrc:/resource-mirrorlink/bg.png"
        Image {
            id: quit
            visible: true
            source: "qrc:/resource-mirrorlink/mirrorlink_Return.png"
            x: 96
            y: 62
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    mirrorlink.setMirrorlinkSrc("2");
                    application.multiApplications.back()
                }
            }
        }
        Image {
            id: help
            visible: true
            source: "qrc:/resource-mirrorlink/Return_problem.png"
            anchors.right: bg.right
            anchors.rightMargin: 80
            anchors.top: bg.top
            anchors.topMargin: 50
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    /*
                    if(startMirrorlink.running){
                       startMirrorlink.stop()
                    }*/
                    mirrorlink.setMirrorlinkSrc("2");
                    application.changePage('mlHelp');
                }
            }
        }
    }

    Item {
        id: root
        width: 1280
        height:720

        Loader{
            id: load
            width: 1280
            height: 720
            anchors.centerIn: parent;
        }

        Component{
            id: connectIcon
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 227
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-mirrorlink/mirrorlink_Mobile Internet.png"
                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 60
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("请连接手机和车载系统")
                        font.pixelSize: 48
                        color: '#FFFFFF'
                    }
                }
            }
        }


        Component{
            id: connectSucces
            Item{
                width: 1280
                height: 720
                Rectangle {
                    anchors.fill: parent
                    color: '#000001'
                }
            }
        }


        Component{
            id: connecting
            Item{
                width: 1280
                height: 720
                Image {
                    id: di
                    anchors.top: parent.top
                    anchors.topMargin: 174
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-mirrorlink/MirrorLink_buffer.png"
                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 63
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("连接中...")
                        font.pixelSize: 38
                        color: '#0875E4'
                    }
                    Image {
                        id: xuanzhuan
                        source: "qrc:/resource-mirrorlink/mirrorlink_buffer_sel.png"
                        RotationAnimation on rotation{
                            from: 0
                            to: 360
                            duration: 500
                            loops: Animation.Infinite
                        }
                    }
                }
            }
        }
    }
}
