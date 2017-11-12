
import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Core' as UCore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

import TheXEcolink 1.0
import TheXDevice 1.0
import TheXSettings 1.0
import TheXVideo 1.0
import TheXPresenter 1.0
import TheXMRev 1.0
import  Bluetooth 1.0
import TheXAudio 1.0

import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant

ICore.Page {
    id: mainPage

    property EcolinkCtl ecolink: HSPluginsManager.get('ecolink')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property VideoCtl videoctl: HSPluginsManager.get('videoctl')
    property MrevCtl mrev: HSPluginsManager.get('mrev')
    property BtCtl btctl: HSPluginsManager.get('btctl')

    property int devState;
    property int devType;
    property int runState;
    property int interfacemodel;
    property real mobileState;
    property string devConnectState;
    property string viewImageState;

    property int displayState;
    property string languageState;
    property int muteState;
    property var navInfo;
    property int volumeDialogState;

    readonly property string _EK_DISPLAY_STATE_DISPLAY         :"1"
    readonly property string _EK_DISPLAY_STATE_HIDE            :"2"

    readonly property string _EK_RUN_STATE_RUN                 :"run"
    readonly property string _EK_RUN_STATE_STOP                :"stop"

    readonly property string _EK_CONNECT_STATE_PLUG_IN         :"devPlugin"
    readonly property string _EK_CONNECT_STATE_PLUG_OUT        :"devPlugout"
    readonly property string _EK_CONNECT_STATE_CONNECTING      :"devConnecting"
    readonly property string _EK_CONNECT_STATE_DISCONNECT      :"devDisconnected"
    readonly property string _EK_CONNECT_STATE_CONNECTED       :"devConnected"
    readonly property string _EK_CONNECT_STATE_IOSNREADY       :"devIosNotReady"
    readonly property string _EK_CONNECT_STATE_ADBERROR        :"devAdbNotOpened"
    readonly property string _EK_CONNECT_STATE_APPVERSIONERROR :"devAppVersionMismatch"
    readonly property string _EK_CONNECT_STATE_OTHERERROR      :"devOtherError"
    readonly property string _EK_CONNECT_STATE_APPINSTALLING   :"devAppInstalling"

    //viewImageState
    readonly property string _EK_VIEW_STATE_IOSBACK         :"viewIosOnBack"
    readonly property string _EK_VIEW_STATE_IOSFRONT        :"viewIosOnFront"
    readonly property string _EK_VIEW_STATE_ANDROIDSLEEP    :"viewAndroidSleep"
    readonly property string _EK_VIEW_STATE_ANDROIDWAKE     :"viewAndroidWake"
    readonly property string _EK_VIEW_STATE_ANDROIDBACK     :"viewAndroidBack"
    readonly property string _EK_VIEW_STATE_ANDROIDFRONT    :"viewAndroidFront"
    readonly property string _EK_VIEW_STATE_IOSCALLIN       :"viewIOSCallIn"



    readonly property string _EK_DISPLAY_CMD_DIS               :"1"
    readonly property string _EK_DISPLAY_CMD_HID               :"2"
    readonly property string _EK_DISPLAY_QML_CMD_DIS               :"3"
    readonly property string _EK_DISPLAY_QML_CMD_HID               :"4"

    readonly property int _SYS_CONNECT_STATE_PLUG_IN           :1
    readonly property int _SYS_CONNECT_STATE_PLUG_OUT          :2

    readonly property int _SYS_CONNECT_TYPE_IPHONE             :5
    readonly property int _SYS_CONNECT_TYPE_ANDROID            :4
    readonly property int _SYS_CONNECT_TYPE_IOS                :3

    property bool changeUsbState:false
    property bool hasDisplayDialog : true
    property int lastComToHelp
    property bool ecolinkUsbPlugIn: false
    property bool ecolinkDemoAlive: false
    property bool ecolinkInitComplete: false

    property string lastDevConnectState :  _EK_CONNECT_STATE_PLUG_OUT

    property bool ecolinkDisplayBall : false

    property var lastSource

    onEcolinkChanged: {
        console.log("[MBC] <ecolink> [onConnectionChanged]{interrupt}")
        devConnectState = Qt.binding(function (){return ecolink.devConnectState})
        displayState = Qt.binding(function (){return ecolink.displayState})
        languageState = Qt.binding(function (){return ecolink.languageState})
        muteState = Qt.binding(function (){return ecolink.muteState})
        volumeDialogState = Qt.binding(function (){return ecolink.volumeDialogState})
        viewImageState = Qt.binding(function (){return ecolink.viewImageState})
    }

    onDevctlChanged: {
        console.log("[MBC] <ecolink> [onDevctlChanged]{interrupt} if-already-connect(",(devConnectState === _EK_CONNECT_STATE_CONNECTED && devState === _SYS_CONNECT_STATE_PLUG_IN)?"y":"n",")-dont-check-usb-state")
        devState = Qt.binding(function (){return devctl.deviceInfo.devState});
        devType =  Qt.binding(function (){return devctl.deviceInfo.devType});
    }

    onVolumeDialogStateChanged: {
        console.log("[MBC] <ecolink> [onVolumeDialogStateChanged]{interrupt} ecolink.voiceDialogState:",ecolink.volumeDialogState," ",volumeDialogState)
        if(volumeDialogState === 1){
            ecolink.setWndDisplay(_EK_DISPLAY_QML_CMD_DIS);
            ecolink.setTouchRectDisable(340,310,940,410);
        } else {
            ecolink.setTouchRectDisable(0,0,0,0);
        }
    }

    onSystemChanged: {
        console.log("[MBC] <ecolink> [onSystemChanged]{interrupt}")
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
        mobileState = Qt.binding(function(){return system.mobileState})
    }
    
    onItemHiding:{
        console.log("[MBC] <ecolink> [onItemHiding]{interrupt}")
        ecolink.setWndDisplay(_EK_DISPLAY_CMD_HID);
    }
    
    onItemShowing: {
        console.log("[MBC] <ecolink> [onItemShowing]{interrupt}")

        ecolinkPrepareShowing()
    }

    onItemShown: {
        console.log("[MBC] <ecolink> [onItemShown]{interrupt} volumeDialogState=",volumeDialogState)

        ecolinkPrepareShowned()

        if (devConnectState === _EK_CONNECT_STATE_CONNECTED && devState === _SYS_CONNECT_STATE_PLUG_IN){

        }else{
            checkNeedRestartUSBPower()
        }

        if ( (devConnectState === _EK_CONNECT_STATE_CONNECTED) && (ecolinkDemoAlive === true) ){
            ecolink.setTouchRectDisable(0,0,0,0);

            if(mrev.revStatus === true) {
                ecolink.setWndDisplay("2")
            }
        } else {
            if (ecolinkInitComplete === false){
                ecolinkSysUsbStateCheck()
            }
        }
        ecolinkInitComplete = true
    }

    Connections {
        target: SoundCommon
        onAudioSourceChanged: {
            console.debug("[MBC] -MBC-Hmi.source =", HmiCommon.source," audioSource=",audioSource)
            if ( (devConnectState === _EK_CONNECT_STATE_CONNECTED) && (ecolinkDemoAlive === true) ){
                switch (audioSource) {
                case HmiCommon.SourceECOLink:
                    btctl.setAudioStreamMode(0);
                    console.debug("[MBC] [open bt-audio]")
                    break
                default:
                    break
                }
            }
        }
    }

    onDevConnectStateChanged: {
        console.log("[MBC] <ecolink> [onDevConnectStateChanged]{interrupt} status-from-les dialog-is-play(",(hasDisplayDialog === true)?"y":"n",")-dont-connect")
        if(hasDisplayDialog === true)
            return;
        detectConnectStateForDisplayEcolink();
    }

    onViewImageStateChanged: {
        console.log("[MBC] <ecolink> [onViewImageStateChanged]{interrupt} viewImageState=",viewImageState)
        ecolinkEventShow(viewImageState)
        /*
        switch(viewImageState){
            case _EK_VIEW_STATE_IOSBACK:
                //load.sourceComponent = viewIOSBack
                ecolinkDisplayUI(viewIOSBack)
                break;
            case _EK_VIEW_STATE_IOSFRONT:
                //load.sourceComponent = connectSuccess
                ecolinkDisplayUI(connectSuccess)
                break;
            case _EK_VIEW_STATE_ANDROIDSLEEP:
                //load.sourceComponent = viewAndroidSleep
                ecolinkDisplayUI(viewAndroidSleep)
                break;
            case _EK_VIEW_STATE_ANDROIDWAKE:
                //load.sourceComponent = connectSuccess
                ecolinkDisplayUI(connectSuccess)
                break;
            case _EK_VIEW_STATE_ANDROIDBACK:
                ecolinkDisplayBall = true
                //load.sourceComponent = connectSuccess
                ecolinkDisplayUI(connectSuccess)
                break;
            case _EK_VIEW_STATE_ANDROIDFRONT:
                ecolinkDisplayBall = false
                //load.sourceComponent = connectSuccess
                ecolinkDisplayUI(connectSuccess)
                break;

            case _EK_VIEW_STATE_IOSCALLIN:
                ecolinkDisplayUI(viewIOSCallIn)
                break;
            default:
                break;
        }*/
    }


    onDisplayStateChanged: {
        console.log("[MBC] <ecolink> [onDisplayStateChanged]{interrupt} display=(",(1 === displayState)?"y":"n",") <",displayState,">")
        if(1 === displayState){
            videoctl.setOverlay(1, 0x000001, 255)
        }
        else if(2 === displayState){

        }
    }

    onDevStateChanged:{
        console.log("[MBC] <ecolink> [onDevStateChanged]{interrupt} ecolinkInitComplete=",ecolinkInitComplete," if-true-check-usb")
        if( ecolinkInitComplete === true ){
            ecolinkSysUsbStateCheck()
        }
    }

    onDevTypeChanged:{
        console.log("[MBC] <ecolink> [onDevTypeChanged]{interrupt} ecolinkInitComplete=",ecolinkInitComplete," if-true-check-usb")
        if( ecolinkInitComplete === true ){
            ecolinkSysUsbStateCheck()
        }
    }

    Connections {
        target: HSStabilizer

        onDispatch: {
            if (id !== 'mrev.revStatus') return
            console.log("[MBC] <ecolink> [onRevStatusChanged]{interrupt} status",mrev.revStatus)

            if (status) {
                ecolink.setWndDisplay("2")
                load.sourceComponent = connectSuccess
            }
            else {
                JSLibs.setTimeout(function() {
                    ecolinkDisplayUI(lastSource)
                    ecolink.setWndDisplay("1")
                    videoctl.setOverlay(1, 0x000001, 255)
                }, 200)
            }
        }
    }


    /*
    Connections {
        target: mrev

        onRevStatusChanged: {
            console.log("[MBC] <ecolink> [onRevStatusChanged]{interrupt} status",mrev.revStatus)

            if (mrev.revStatus) {
                ecolink.setWndDisplay("2")
                load.sourceComponent = connectSuccess
            }
            else {
                ecolinkDisplayUI(lastSource)
                ecolink.setWndDisplay("1")
                videoctl.setOverlay(1, 0x000001, 255)
            }
        }
    }*/

    Timer {
        id: timeConnectTimeOut
        interval: 30000;
        running: false;
        repeat: false;
        triggeredOnStart: false;
        onTriggered: connectTimeOut()
    }

    function ecolinkPrepareShowned(){
        /* 如果ecolink在后台连接成功,显示ecolink界面 */
        if ( (ecolinkDemoAlive === true) && (devConnectState === _EK_CONNECT_STATE_CONNECTED) ){
            ecolinkStopConnectTimer()
            ecolink.setWndDisplay(_EK_DISPLAY_CMD_DIS);
        }else{
            /* 杀死mirror进程 */
            devctl.killMobileProcess(3)
        }

        /* 如果默认为ecolink,不显示dialog */
        if( mobileState === 2 ){
            hasDisplayDialog = false
        }else{
            /* 如果为ecolink在后台连接成功,不显示dialog */
            if( ecolinkDemoAlive === true ){
                hasDisplayDialog = false;
            }else{
                hasDisplayDialog = true;
                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,textinfo:qsTr('是否将EcoLink设置为默认车机互联?'),autoClose:true,autoCloseTimeout:3000,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
            }
        }
    }

    function ecolinkPrepareShowing(){
        /* 判断ecolink进程是否存在 */
        ecolinkDemoAlive = (devctl.checkMobileProcessAlive(2) === 1);

        /* 如果ecolink在后台连接成功,不显示连接界面 */
        if ( (ecolinkDemoAlive === true) && (devConnectState === _EK_CONNECT_STATE_CONNECTED) ){
            if(1 === displayState)
                ecolinkDisplayUI(connectSuccess)
            else
                ecolinkEventShow(viewImageState)
        }else{
            ecolinkDisplayUI(connectIcon)
        }

    }

    function ecolinkStartConnectTimer(){
        timeConnectTimeOut.stop();
        timeConnectTimeOut.start();
    }

    function ecolinkStopConnectTimer(){
        timeConnectTimeOut.stop();
    }

    function ecolinkEventShow(state){
        switch(state){
            case _EK_VIEW_STATE_IOSBACK:
                //load.sourceComponent = viewIOSBack
                ecolinkDisplayUI(viewIOSBack)
                break;
            case _EK_VIEW_STATE_IOSFRONT:
                //load.sourceComponent = connectSuccess
                ecolinkDisplayUI(connectSuccess)
                break;
            case _EK_VIEW_STATE_ANDROIDSLEEP:
                //load.sourceComponent = viewAndroidSleep
                ecolinkDisplayUI(viewAndroidSleep)
                break;
            case _EK_VIEW_STATE_ANDROIDWAKE:
                //load.sourceComponent = connectSuccess
                ecolinkDisplayUI(connectSuccess)
                break;
            case _EK_VIEW_STATE_ANDROIDBACK:
                ecolinkDisplayBall = true
                //load.sourceComponent = connectSuccess
                ecolinkDisplayUI(connectSuccess)
                break;
            case _EK_VIEW_STATE_ANDROIDFRONT:
                ecolinkDisplayBall = false
                //load.sourceComponent = connectSuccess
                ecolinkDisplayUI(connectSuccess)
                break;

            case _EK_VIEW_STATE_IOSCALLIN:
                ecolinkDisplayUI(viewIOSCallIn)
                break;
            default:
                break;
        }
    }


    function ecolinkDisplayUI(Component){
        switch(Component){
        case connecting:
            help.visible = false
            quit.visible = false
            lastComToHelp = 2
            break;

        case connectIcon:
            help.visible = true
            quit.visible = true
            lastComToHelp = 1
            break;

        case connectSuccess:
            help.visible = false
            quit.visible = false
            lastComToHelp = 1
            break;

        case failRetry:
            help.visible = true
            quit.visible = true
            lastComToHelp = 3
            break;

        case failNoApp:
            help.visible = true
            quit.visible = true
            lastComToHelp = 4
            break;

        case appInstall:
            help.visible = true
            quit.visible = true
            lastComToHelp = 3
            break;

        case failNoApp:
            help.visible = true
            quit.visible = true
            lastComToHelp = 4
            break;

        case viewIOSBack:
            break;

        case viewAndroidSleep:
            break;

        case viewIOSCallIn:
            break;

        default:
            Component = connectIcon
            help.visible = false
            quit.visible = false
            lastComToHelp = 2
            break;
        }
        lastSource = Component
        load.sourceComponent = Component
    }



    function ecolinkSysUsbStateCheck(){
        switch(devState){
        case _SYS_CONNECT_STATE_PLUG_IN:
            switch(devType){
                case _SYS_CONNECT_TYPE_ANDROID:
                    ecolinkStartConnectTimer()
                    ecolinkUsbPlugIn = true;
                    console.log("-----[MBC] <ecolink> [ecolinkSysUsbStateCheck] (ReStart Ecolink Demo)")
                    /*  杀死 ecolink 进程  */
                    ecolink.stopEcolinkDemo();
                    /* 开启 ecolink 进程*/
                    ecolink.startEcolinkDemo();
                    btctl.setAudioStreamMode(0);
                    console.debug("[MBC] [open bt-audio]")

                    changeUsbState = false
                    ecolinkDisplayUI(connecting)
                    break;
                case _SYS_CONNECT_TYPE_IPHONE:
                case _SYS_CONNECT_TYPE_IOS:
                    ecolinkStartConnectTimer()

                    if(devctl.GetUsbSwtichConfig() === 1){
                        console.log("-----[MBC] <ecolink> [ecolinkSysUsbStateCheck] (Switch Usb)")
                        devctl.UsbSwtichConfig(2);
                    }
                    ecolinkUsbPlugIn = true;
                    btctl.setAudioStreamMode(0);
                    console.debug("[MBC] [open bt-audio]")

                    console.log("-----[MBC] <ecolink> [ecolinkSysUsbStateCheck] (ReStart Ecolink Demo)")
                    /* 杀死 ecolink 进程 */
                    ecolink.stopEcolinkDemo();
                    /* 开启 ecolink 进程*/
                    ecolink.startEcolinkDemo();
                    changeUsbState = false

                    ecolinkDisplayUI(connecting)
                    break;
                default:
                    break;
            }
            break;

        case _SYS_CONNECT_STATE_PLUG_OUT:
            switch(devType){
             case _SYS_CONNECT_TYPE_ANDROID:
                 ecolinkUsbPlugIn = false;
                 ecolinkDisplayUI(connectIcon)
                 ecolinkStopConnectTimer()
                 ecolink.stopEcolinkDemo();
                 /*  杀死 ecolink 进程  */
                 ecolink.stopEcolinkDemo();

                 if(changeUsbState == false && application.wndlinkFlag !== true){
                     console.log("-----[MBC] <ecolink> [ecolinkSysUsbStateCheck] usb-plug-out && exit()")
                     application.multiApplications.remove('ecolink')
                 }

                 break;
             case _SYS_CONNECT_TYPE_IPHONE:
                 ecolinkUsbPlugIn = false;
                 ecolinkDisplayUI(connectIcon)
                 ecolinkStopConnectTimer()
                 ecolink.stopEcolinkDemo();
                 /*  杀死 ecolink 进程  */
                 ecolink.stopEcolinkDemo();

                 if(changeUsbState == false && application.wndlinkFlag !== true){
                     console.log("-----[MBC] <ecolink> [ecolinkSysUsbStateCheck] usb-plug-out && exit()")
                     application.multiApplications.remove('ecolink')
                 }
                 break;
             default:
                 break;
            }
            break;
        default:
            break;
        }
        console.log("-----[MBC] <ecolink> [ecolinkSysUsbStateCheck] usb-plug(",(devState==_SYS_CONNECT_STATE_PLUG_IN)?"y":"n",") dev-type(",devType,") ecolinkUsbPlugIn(",ecolinkUsbPlugIn,") changeUsbState(",changeUsbState,")")

    }

    function checkNeedRestartUSBPower(){
        console.log("-----[MBC] <ecolink> [checkNeedRestartUSBPower] reset-usb-power(",(((devctl.getUsbRole() !== 1)&&(devctl.checkMobileProcessAlive(1) === 1)) || (devctl.checkMobileProcessAlive(5) === 1))?"y":"n",")",devctl.getUsbRole(),devctl.checkMobileProcessAlive(5),(devctl.checkMobileProcessAlive(1) === 1))

        //devctl.getUsbRole():get usb role is devices or host, 0:device 1:host
        //devctl.checkMobileProcessAlive(5):get CarIphone is zerb process 1:y 0:n
        //reset usb when carlife is alive && role == 0            ecolink.setWndDisplay(_EK_DISPLAY_QML_CMD_HID);

        if(((devctl.getUsbRole() !== 1)&&(devctl.checkMobileProcessAlive(1) === 1)) /*|| (devctl.checkMobileProcessAlive(5) === 1)*/){
            changeUsbState = true
            devctl.UsbVbusReset();
        }else{

        }
    }

    function dialogConfirmTip(dialog){
        console.log("-----[MBC] <ecolink> [dialogConfirmTip]")

        hasDisplayDialog = false;

        dialog.confirmed.connect(function confirmed(){
            console.debug("setInitialize:");
            system.setMobileState(2);
        });
    }


    function detectConnectStateForDisplayEcolink(){

        switch(devConnectState){
            case _EK_CONNECT_STATE_PLUG_IN:
                break;
            case _EK_CONNECT_STATE_PLUG_OUT:
                break;
            case _EK_CONNECT_STATE_CONNECTING:
                if(ecolinkUsbPlugIn === true){
                    ecolinkDisplayUI(connecting)
                    ecolinkStartConnectTimer()
                }
                break;
            case _EK_CONNECT_STATE_DISCONNECT:
                if(lastDevConnectState === _EK_CONNECT_STATE_CONNECTED){
                    ecolinkDisplayUI(failRetry)
                }
                break;
            case _EK_CONNECT_STATE_CONNECTED:
                if(ecolinkUsbPlugIn === true){
                    ecolinkStopConnectTimer()
                    console.log("-----[MBC] <ecolink> ecolinkDisplayUI(connectSuccess) ret=",(devType===_SYS_CONNECT_TYPE_ANDROID))

                    ecolinkDisplayUI(connectSuccess)
                }
                break;
            case _EK_CONNECT_STATE_IOSNREADY:
                if(ecolinkUsbPlugIn === true){
                    ecolinkStopConnectTimer()
                    ecolinkDisplayUI(failRetry)
                }
                break;
            case _EK_CONNECT_STATE_ADBERROR:

                if(ecolinkUsbPlugIn === true){
                    ecolinkStopConnectTimer()
                    ecolinkDisplayUI(failRetry)
                }
                break;
            case _EK_CONNECT_STATE_APPVERSIONERROR:
                if(ecolinkUsbPlugIn === true){
                    ecolinkStopConnectTimer()
                    ecolinkDisplayUI(failNoApp)
                }
                break;
            case _EK_CONNECT_STATE_OTHERERROR:
                ecolinkStopConnectTimer()
                ecolinkDisplayUI(failRetry)
                break;

            case _EK_CONNECT_STATE_APPINSTALLING:
                ecolinkStopConnectTimer()
                ecolinkDisplayUI(appInstall)
                break;

            default:
                break;
        }

        if(_EK_CONNECT_STATE_CONNECTED === devConnectState && ecolinkUsbPlugIn === true/*devState == _SYS_CONNECT_STATE_PLUG_IN*/){
            //ecolink.setWndDisplay(_EK_DISPLAY_QML_CMD_HID);
            if(mrev.revStatus === true) {
                ecolink.setWndDisplay(_EK_DISPLAY_CMD_HID);
            }else{
                ecolink.setWndDisplay(_EK_DISPLAY_CMD_DIS);
            }

            ecolink.startNavTrans();

            ecolink.setWndDisplay(_EK_DISPLAY_QML_CMD_DIS);
            //ecolink.setTouchRectDisable(0,0,0,0);

        }else{
                ecolink.setWndDisplay(_EK_DISPLAY_CMD_HID);
        }

        lastDevConnectState = devConnectState
        console.log("-----[MBC] <ecolink> [detectConnectStateForDisplayEcolink] connect-state(",devConnectState,") display-carlife(",(_EK_CONNECT_STATE_CONNECTED === devConnectState && ecolinkUsbPlugIn === true/*devState == _SYS_CONNECT_STATE_PLUG_IN*/)?"y":"n",")")
    }

    function exitEcolink(){
        console.log("-----[MBC] <ecolink> [exitEcolink] ")
        ecolink.exitNavTrans();
        ecolink.stopEcolinkDemo();
        changeUsbState = true

        if((devType === _SYS_CONNECT_TYPE_IOS || devType === _SYS_CONNECT_TYPE_IPHONE) && ecolinkUsbPlugIn === true/*devState === _SYS_CONNECT_STATE_PLUG_IN*/){
            //if ios is connecte need to reset usb config
            devctl.UsbSwtichConfig(1);
        }
    }


    function connectTimeOut(){
        console.log("-----[MBC] <ecolink> [connectTimeOut] ")
        ecolinkDisplayUI(failRetry)
    }

    function restartTryConnect(){
        console.log("-----[MBC] <ecolink> [restartTryConnect] ")
        //devctl.killMobileProcess(4);
        changeUsbState = true
        devctl.UsbVbusReset();
        ecolinkDisplayUI(connectIcon)
    }

    function touchEventFilter(x,y){
        var home_left = 10
        var home_right = home_left + 100
        var home_top = 330
        var home_bottom = home_top + 100
        //if( home.visible === false )
        //    return 0

        if( x > home_left && x < home_right && y > home_top && y < home_bottom ){
            console.log("-----[MBC] <ecolink> [touchEventFilter]{home key press}")
            ecolink.sendKeyBackMainPage();
            return 1
        }

        return 0
    }


    Image {
        id: bg
        source: "qrc:/resource-leecolink/bg.png"

        Image {
            id: quit
            visible: true
            source: "qrc:/resource-leecolink/ecolink_Return.png"
            x: 96
            y: 62
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    application.multiApplications.remove('ecolink')
                    exitEcolink()
                }
            }
        }

        Image {
            id: help
            visible: true
            source: "qrc:/resource-leecolink/return_problem.png"
            anchors.right: bg.right
            anchors.rightMargin: 73
            anchors.top: bg.top
            anchors.topMargin: 49
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    quit.visible = false
                    help.visible = false
                    load.sourceComponent = helpPage;
                }
            }
        }
    }

    Item {
        id: rootzImage
        width: 1280
        height:720

        Loader{
            id: load
            width: 1280
            height: 720
            anchors.centerIn: parent;
        }

        Component{
            id: connecting
            Item{
                id:l1
                width: 1280
                height: 720
                Image {
                    id: di
                    anchors.top: l1.top
                    anchors.topMargin: 194
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-leecolink/ecolink_buffer.png"
                    IControls.NonAnimationText_FontLight{
                        id:con
                        anchors.top: parent.bottom
                        anchors.topMargin: 185
                        anchors.horizontalCenter: di.horizontalCenter
                        text: qsTr("连接中...")
                        font.pixelSize: 48
                        color: '#0875E4'
                    }
                    Image {
                        id: xuanzhuan
                        anchors.top: di.top
                        anchors.topMargin: -78
                        anchors.horizontalCenter: di.horizontalCenter

                        source: "qrc:/resource-leecolink/ecolink_buffer_sel.png"
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

        Component{
            id: helpPage
            Item{
                width: 1280
                height: 720

                IControls.BgImageButtonInstance {
                    id: helpBc
                    clip:false
                    height: 51;
                    width: 40;
                    anchors.left: parent.left
                    anchors.leftMargin: 113
                    anchors.top: parent.top
                    anchors.topMargin: 55
                    bgSource: "qrc:/resource-leecolink/connection_help.png"
                    themeColor: interfacemodel
                    onClicked: {
                        console.log("-----[MBC] <ecolink> [helpPage]{checked} ")
                        help.visible = true
                        quit.visible = true
                        switch(lastComToHelp){
                        case 1:
                            load.sourceComponent = connectIcon;
                            break;
                        case 2:
                            load.sourceComponent = connecting;
                            break;
                        case 3:
                            load.sourceComponent = failRetry;
                            break;
                        case 4:
                            load.sourceComponent = failNoApp;
                            break;
                        default:
                            break;
                        }
                    }
                }

                IControls.NonAnimationText_FontRegular{
                    id: helpRt
                    anchors.left: helpBc.left
                    anchors.leftMargin: 50
                    anchors.top: helpBc.top
                    anchors.topMargin: -5
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 38
                    text: qsTr("连接帮助")
                    color: "#FEFEFE"
                }

                IControls.NonAnimationText_FontRegular{
                    id: helpTxt
                    anchors.left: parent.left
                    anchors.leftMargin: 200
                    anchors.top: helpRt.bottom
                    anchors.topMargin: 20
                    font.pixelSize: 48
                    text: qsTr("请扫描下方二维码获取帮助")
                    color: "#FEFEFE"
                }

                Image {
                    id: android_help
                    anchors.left: parent.left
                    anchors.leftMargin: 290
                    anchors.top: helpTxt.bottom
                    anchors.topMargin: 20
                    source: "qrc:/resource-leecolink/android_help_rd.png"
                }

                IControls.NonAnimationText_FontRegular{
                    anchors.top: android_help.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: android_help.horizontalCenter
                    font.pixelSize: 48
                    text: qsTr("安卓手机")
                    color: "#FEFEFE"
                }


                Image {
                    id: ios_help
                    anchors.left: parent.left
                    anchors.leftMargin: 780
                    anchors.top: helpTxt.bottom
                    anchors.topMargin: 20
                    source: "qrc:/resource-leecolink/ios_help_rd.png"
                }

                IControls.NonAnimationText_FontRegular{
                    anchors.top: android_help.bottom
                    anchors.topMargin: 20
                    anchors.horizontalCenter: ios_help.horizontalCenter
                    font.pixelSize: 48
                    text: qsTr("苹果手机")
                    color: "#FEFEFE"
                }
            }
        }


        Component{
            id: connectIcon
            //connectIcon
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 227
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-leecolink/ecolink_Mobile Internet.png"
                    UControls.NonAnimation_Text {
                        z:10
                        id: connecttxt
                        anchors.top: parent.bottom
                        anchors.topMargin: 80//55
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("请连接手机和车载系统")
                        font.pixelSize: 48
                        color: '#ffffff'
                    }
                }
            }
        }


        Component{
            id: connectSuccess
            Item{
                width: 1280
                height: 720

                Rectangle {
                    anchors.fill: parent
                    color: '#000001'
                }

                Image {
                    id:home
                    visible: (devType===_SYS_CONNECT_TYPE_ANDROID && ecolinkDisplayBall === true)
                    x: 10
                    y: 330
                    height: 100;
                    width: 100;
                    source: "qrc:/resource-leecolink/float-button.png"
                    IControls.MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.log("-----[MBC] <ecolink> [home-key] press")
                        }
                    }
                }

                IControls.MouseArea{
                    z:10
                    anchors.fill: parent
                    enabled: true
                    onPressed: {
                        console.log("-----[MBC] <ecolink> [onPressed]{",mouse.x,"}{",mouse.y,"}")
                    }
                    onReleased: {
                        console.log("-----[MBC] <ecolink> [onReleased]{",mouse.x,"}{",mouse.y,"}")
                        touchEventFilter(mouse.x,mouse.y)
                    }
                    onPositionChanged: {
                        console.log("-----[MBC] <ecolink> [onPositionChanged]{",mouse.x,"}{",mouse.y,"}")
                    }
                }
            }
        }



        Component{
            id: failNoApp
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 49
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-leecolink/ecolink_ios_app.png"
                    UControls.NonAnimation_Text {
                        id: connecttxt
                        anchors.top: parent.bottom
                        anchors.topMargin: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("手机端没有安装乐视EcoLink")
                        font.pixelSize: 48
                        color: '#ffffff'
                    }
                    IControls.NonAnimationText_FontLight{
                        anchors.top: connecttxt.bottom
                        anchors.topMargin: 15
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("请扫描二维码下载")
                        font.pixelSize: 48
                        color: '#ffffff'

                        IControls.BgImageButtonInstance {
                            id: itemNoAppRetry
                            clip:false
                            height: 104;
                            width: 420;
                            anchors.top: parent.bottom
                            anchors.topMargin: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                            bgSource: "qrc:/resource-leecolink/ecolink_currency_box.png"
                            themeColor: interfacemodel
                            onClicked: {
                                console.log("-----[MBC] <ecolink> [failNoApp]{checked} ")
                                if(devType === _SYS_CONNECT_TYPE_IPHONE || devType === _SYS_CONNECT_TYPE_IOS){
                                    ecolink.stopEcolinkDemo();
                                    changeUsbState = true
                                    devctl.UsbSwtichConfig(2);
                                    ecolink.startEcolinkDemo();
                                }                                
                            }
                        }
                        IControls.NonAnimationText_FontRegular{
                            anchors.centerIn: itemNoAppRetry
                            font.pixelSize: 38
                            text: qsTr("重新连接")
                            color: "#FEFEFE"
                        }
                    }
                }
            }
        }

        Component{
            id: failRetry
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 227
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-leecolink/ecolink_Mobile Internet.png"

                    UControls.NonAnimation_Text {
                        id: connecttxt
                        anchors.top: parent.bottom
                        anchors.topMargin: 45
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("连接失败，未识别到连接")
                        font.pixelSize: 48
                        color: '#ffffff'
                    }

                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 110
                        anchors.horizontalCenter: parent.horizontalCenter
                        IControls.BgImageButtonInstance {
                            id: itemFailRetry
                            clip:false
                            height: 104;
                            width: 420;
                            anchors.top: parent.bottom
                            anchors.topMargin: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                            bgSource: "qrc:/resource-leecolink/ecolink_currency_box.png"
                            themeColor: interfacemodel
                            onClicked: {
                                console.log("-----[MBC] <ecolink> [failRetry]{checked} ")
                                restartTryConnect();
                            }
                        }
                        IControls.NonAnimationText_FontRegular{
                            anchors.centerIn: itemFailRetry
                            font.pixelSize: 38
                            text: qsTr("重新连接")
                            color: "#FEFEFE"
                        }
                    }
                }
            }
        }



/*
        Component{
            id: appInstall
            Item{
                width: 1280
                height: 720
                UControls.NonAnimation_Text {
                    id: connecttxt1
                    anchors.top: parent.top
                    anchors.topMargin: 250
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("请按手机侧提示完成客户端的安装,")
                    font.pixelSize: 48
                    color: '#ffffff'
                }

                UControls.NonAnimation_Text {
                    id: connecttxt2
                    anchors.top: connecttxt1.bottom
                    anchors.topMargin: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("然后重新连接")
                    font.pixelSize: 48
                    color: '#ffffff'
                }

                IControls.NonAnimationText_FontLight{
                    anchors.top: connecttxt2.bottom
                    anchors.topMargin: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    IControls.BgImageButtonInstance {
                        id: itemFailRetry
                        clip:false
                        height: 104;
                        width: 420;
                        anchors.top: parent.bottom
                        anchors.topMargin: 40
                        anchors.horizontalCenter: parent.horizontalCenter
                        bgSource: "qrc:/resource-leecolink/ecolink_currency_box.png"
                        themeColor: interfacemodel
                        onClicked: {
                            console.log("-----[MBC] <ecolink> [failRetry]{checked} ")
                            restartTryConnect();
                        }
                    }
                    IControls.NonAnimationText_FontRegular{
                        anchors.centerIn: itemFailRetry
                        font.pixelSize: 38
                        text: qsTr("重新连接")
                        color: "#FEFEFE"
                    }
                }
            }
        }*/

        Component{
            id: appInstall
            Item{
                width: 1280
                height: 720

                Image {
                    source: "qrc:/resource-leecolink/install_0.png"
                }

                Image {
                    id:i_2
                    anchors.top: parent.top
                    anchors.topMargin: 198
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-leecolink/install_2.png"
                }

                Image {
                    id:i_1
                    anchors.top: i_2.top
                    anchors.topMargin: 36
                    anchors.right: i_2.left
                    anchors.rightMargin: 112
                    source: "qrc:/resource-leecolink/install_1.png"
                }

                Image {
                    id:i_3
                    anchors.top: i_2.top
                    anchors.topMargin: 51
                    anchors.left: i_2.right
                    anchors.leftMargin: 112
                    source: "qrc:/resource-leecolink/install_3.png"
                }

                Image {
                    id:i_4
                    anchors.top: i_1.bottom
                    anchors.topMargin: 62
                    anchors.left: parent.left
                    anchors.leftMargin: 265
                    source: "qrc:/resource-leecolink/install_4.png"
                }


                IControls.NonAnimationText_FontRegular{
                    anchors.top: i_1.bottom
                    anchors.topMargin: 63
                    anchors.left: parent.left
                    anchors.leftMargin: 355
                    font.pixelSize: 38
                    text: qsTr('请注意手机屏幕,按提示 "允许" 和 "确认"')
                    color: "#B4B4B5"
                }

                IControls.NonAnimationText_FontRegular{
                    anchors.top: i_1.bottom
                    anchors.topMargin: 150
                    anchors.left: parent.left
                    anchors.leftMargin: 265
                    font.pixelSize: 45
                    text: qsTr('正在安装乐视车联,请勿断开USB连接线')
                    color: "#FFFFFF"
                }


            }
        }


        Component{
            id: viewIOSBack
            Item{
                width: 1280
                height: 720
                Image {
                    source: "qrc:/resource-leecolink/backgroundtip.jpg"
                }
            }
        }

        Component{
            id: viewAndroidSleep
            Item{
                width: 1280
                height: 720
                Image {
                    source: "qrc:/resource-leecolink/screenoff.jpg"
                }
            }
        }

        Component{
            id: viewAndroidBack
            Item{
                width: 1280
                height: 720
                Image {
                    source: "qrc:/resource-leecolink/ecolink_Mobile Internet.png"
                }
            }
        }
        Component{
            id: viewIOSCallIn
            Item{
                width: 1280
                height: 720
                Image {
                    source: "qrc:/resource-leecolink/callingin.jpg"
                }
            }
        }
    }
}
