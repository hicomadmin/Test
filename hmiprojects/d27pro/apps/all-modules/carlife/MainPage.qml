import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Core' as UCore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import TheXCarlife 1.0
import TheXDevice 1.0
import Bluetooth 1.0
import TheXSettings 1.0
import TheXVideo 1.0
import TheXPower 1.0
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

ICore.Page {
    id: mainPage

    property CarlifeCtl carlife: HSPluginsManager.get('carlife')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property VideoCtl videoctl: HSPluginsManager.get('videoctl')
    property PowerCtl power: HSPluginsManager.get('power')

    property int interfacemodel : system.interfacemodel
    property int connection
    property int connProgress
    property int display
    property int btConnection
    property int devState
    property int devType
    property bool clickFlag: false
    property int powerState
    property bool hasDisplayDialog : true
    property bool macSet : false
    property int telStatus
    property int groundState
    property int powerPower

    property int _MOBILE_PROCESS_CARLIFE :       1;
    property int _MOBILE_PROCESS_ECOLINK :       2;
    property int _MOBILE_PROCESS_MIRRORLINK :    3;
    property int _MOBILE_PROCESS_ADB :           4;

    property real mobileState;
    property bool errorDisplayState : false
    property bool hasStartCarlifeEntry : false
    property bool hasStartCarlifeApp : false

    property bool carlifeUsbPlugIn: false

    property bool carlifeMediaVolumn: false

    property bool carlifeGoHome: false

    property bool carlifeStartBackGround: false

    property bool mrevStatus: false

    onCarlifeChanged: {
        console.log("[MBC] <carlife> [onCarlifeChanged]{interrupt}")
        if(carlife.connection === 6)
        {
            carlifeGoHome = true
        }
        connection = Qt.binding(function (){return carlife.connection})
        connProgress = Qt.binding(function (){return carlife.connProgress})
        btConnection = Qt.binding(function (){return carlife.btConnection})
        display = Qt.binding(function (){return carlife.display})
        groundState = Qt.binding(function (){return carlife.groundState})
    }

    onDevctlChanged: {
        console.log("[MBC] <carlife> [onDevctlChanged]{interrupt}")
        devState = Qt.binding(function (){return devctl.deviceInfo.devState});
        devType =  Qt.binding(function (){return devctl.deviceInfo.devType});

        if ( devctl.checkMobileProcessAlive(2) === 1 ){
            console.log("[MBC] <carlife> [onDevctlChanged] kill ecolink && mirrorlink ")
            devctl.killMobileProcess(2);
            devctl.killMobileProcess(3);
        }

        if ( devctl.GetUsbSwtichConfig() === 2 ){
            console.log("[MBC] <carlife> [onDevctlChanged] switch usb config -> 2 ")
            devctl.UsbSwtichConfig(1);
        }
    }

    onBtctlChanged: {
        console.log("[MBC] <carlife> [onBtctlChanged]{interrupt}")
        telStatus = Qt.binding(function (){return btctl.telStatus})
        powerState = Qt.binding(function (){return btctl.powerState});
        //sendMacAddress();
    }

    onSystemChanged: {
        console.log("[MBC] <carlife> [onSystemChanged]{interrupt}")
        mobileState = Qt.binding(function(){return system.mobileState})
    }

    onPowerChanged: {
        powerPower = Qt.binding(function(){return power.power})
        console.log("[MBC] <carlife> [onPowerChanged]{interrupt} powerPower", powerPower)
    }

    onItemShowing: {
        console.log("[MBC] <carlife> [onItemShowing]{interrupt}")
        startCarlifeEntry()
        
    }

    Connections {
        target: HSStabilizer

        onDispatch: {
            if (id !== 'mrev.revStatus') return
            console.log("[MBC] <carlife> [onRevStatusChanged]{interrupt} status(",status,") powerPower(",powerPower,")")
            mrevStatus = status;

            if (status) {
                carlife.displayCarlife(0)
            }
            else {
                if(powerPower)
                {
                    JSLibs.setTimeout(function() {
                        if (connection === 2 || connection === 6)
                        {
                            carlife.displayCarlife(1)
                        }
                        //videoctl.setOverlay(1, 0x000001, 255)
                    }, 200)
                }
            }
        }
    }

    Connections {
        target: carlife

        onIPhoneCallChanged: {
            console.log("[MBC] <carlife> [onIPhoneCallChanged]{interrupt} command(",carlife.iPhoneCall[0],") phoneNum(",carlife.iPhoneCall[1],") dtmfCode(",carlife.iPhoneCall[2],")");
            btctl.phoneCallTask(carlife.iPhoneCall[1]);
        }
    }

    onItemShown: {
        console.log("[MBC] <carlife> [onItemShown]{interrupt}")

        if(carlife.connection === 0) {
            load.sourceComponent = connectIcon;
        }
        else if(carlife.connection === 1) {
            load.sourceComponent = connecting;
        }
        else if(carlife.connection === 2) {
            load.sourceComponent = success;
        }
        else if(carlife.connection === 3) {
            load.sourceComponent = fail;
        }
        else if(carlife.connection === 4) {
            load.sourceComponent = twoCode;
        }
        /*else if(carlife.connection === 6) {
            carlife.displayCarlife(0)
            application.multiApplications.back()
        }*/
        //sendMacAddress();
    }

    onDevStateChanged: {
        console.log("[MBC] <carlife> [onDevStateChanged]{interrupt} dialog-display(",hasDisplayDialog,") usb-plug(",(devState==1)?"in":"out",") dev-tpye(",devType,")")

        if(hasDisplayDialog === true)
            return;

        detectUSBConnectForStartCarlife()
    }

    onDevTypeChanged: {
        console.log("[MBC] <carlife> [onDevTypeChanged]{interrupt} dialog-display(",hasDisplayDialog,") usb-plug(",(devState==1)?"in":"out",") dev-tpye(",devType,")")

        if(hasDisplayDialog === true)
            return;

        detectUSBConnectForStartCarlife()
    }

    onDisplayChanged: {
        console.log("[MBC] <carlife> [onDisplayChanged]{interrupt} display(",display,") connection(",connection,")")

        if(display == 0){
            carlife.displayCarlife(display)
            load.sourceComponent = restart
            quit.visible = true
            help.visible = true
            clickFlag = false
        }
        else if((display === 1) && (connection === 2 || connection === 6)){
            load.sourceComponent = success
            carlife.displayCarlife(display)
        }
    }

    /*
      telStatus: 0：来电; 1：通话中; 2：去电; 3：第三方来电;
             4：三方通话中; 5: 三方去电;  6: 通话结束
    */
    onTelStatusChanged: {
        console.log("[MBC] <carlife> [onTelStatusChanged]{interrupt} telStatus(",telStatus,"){3h,7d}")

        switch(telStatus){
        case 0:
        case 1:
        case 2:
        case 3:
            carlife.displayCarlife(0);
            break;
        case 7:
            //carlife.displayCarlife(1);
            break;
        default:
            break;
        }
    }

    onPowerStateChanged: {
        console.log("[MBC] <carlife> [onPowerStateChanged]{interrupt} bt-power(",(powerState == 1)?"on":"off",") connection-state(",connection,")")

        if (powerState === 1)
        {
            if (connection === 2)
            {
                if (btMACCheck() === 1){
                    console.debug("[Carlife App]Carlife onPowerStateChanged conn:%d, type:%d", connection, devType);
                    sendMacAddress();
                }
            }
        }
    }

    onConnectionChanged: {
        console.log("[MBC] <carlife> [onConnectionChanged]{interrupt} connection(",connection,") switch carlife(",(application.wndlinkFlag)?"button":"home",")")

        if(connection === 0) {
            if(errorDisplayState === false)
                load.sourceComponent = connectIcon;

            quit.visible = true
            help.visible = true

            carlifeStartBackGround = false
            macSet = false
        }
        else if(connection === 1) {
            load.sourceComponent = connecting;
            errorDisplayState = false

            carlifeStartBackGround = false
        }
        else if(connection === 2) {
            console.log("[MBC] <carlife> [onConnectionChanged]{interrupt} connection(",connection,") carlifeStartBackGround(",carlifeStartBackGround,")")
            if(carlifeStartBackGround === false)
            {
                load.sourceComponent = success;
            }
            else
            {
                carlifeStartBackGround = false
                load.sourceComponent = restart
                quit.visible = true
                help.visible = true
                clickFlag = false
            }

            sendMacAddress();
            errorDisplayState = false
        }
        else if(connection === 3) {
            load.sourceComponent = fail;
            quit.visible = true
            help.visible = true
            errorDisplayState = true

            carlifeStartBackGround = false
        }
        else if(carlife.connection === 4) {
            load.sourceComponent = twoCode;
            quit.visible = true
            help.visible = true
            errorDisplayState = true

            carlifeStartBackGround = false
        }
        else if(carlife.connection === 6) {
            console.log("[MBC] <carlife> [onConnectionChanged]{interrupt} carlifeGoHome(",carlifeGoHome,")")

            carlifeStartBackGround = false

            if(carlifeGoHome === false)
            {
                carlife.displayCarlife(0)
                errorDisplayState = true
                application.multiApplications.remove('carlife')
            }
            else
            {
                carlifeGoHome = false
            }
        }
        else if(carlife.connection === 7) {
            //iPhone Device Remove to home
            errorDisplayState = true

            carlifeStartBackGround = false

            if (application.wndlinkFlag !== true)
            {
                application.multiApplications.remove('carlife')
            }
            //application.multiApplications.changeApplication('home',{properties: {initialPage: 'home'}});
        }
        console.log("[MBC] <carlife> [onConnectionChanged]{interrupt} connection-state(",connection,") need-display-error-dialog(",errorDisplayState,")")
    }

    onGroundStateChanged: {
        console.log("[MBC] <carlife> [onGroundStateChanged]{interrupt} groundState(",groundState,"), connection(",connection,")")

        if(groundState === 1) {
           if(connection === 1)
           {
                carlifeStartBackGround = true
           }
        }

        console.log("[MBC] <carlife> [onConnectionChanged]{interrupt} groundState-state(",groundState,") carlifeStartBackGround(",carlifeStartBackGround,")")
    }


    function startCarlifeApp(id){
        console.log("-----[MBC] <carlife> [startCarlifeApp] carlife-alive(",( devctl.checkMobileProcessAlive(_MOBILE_PROCESS_CARLIFE) === 0)?"n":"y",") id(",id,") if-no-run-startCarlife")

        if((devctl.checkMobileProcessAlive(_MOBILE_PROCESS_CARLIFE) === 0) ||
                ((devctl.checkMobileProcessAlive(_MOBILE_PROCESS_CARLIFE) === 1) && (connection !== 1 && connection !== 2 && connection !== 6))){
            carlife.startCarlife(id)
        }else{

        }

    }



    function startCarlifeEntry(){
        console.log("-----[MBC] <carlife> [startCarlifeEntry] default-mobile(",mobileState,") already-startCarlifeEntry(",hasStartCarlifeEntry,") mrevStatus(",mrevStatus,")")
        if(hasStartCarlifeEntry === false){
            if(mobileState === 1){
                hasDisplayDialog = false;
                detectUSBConnectForStartCarlife()
            }else{
                if (connection !== 2 && connection !== 6)
                {
                    hasDisplayDialog = true;
                    timeStartCarlife.stop();
                    timeStartCarlife.start();
                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,textinfo:qsTr('是否将CarLife设置为默认车机互联?'),autoClose:true,autoCloseTimeout:3000,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
                }
                else
                {
                    hasDisplayDialog = false;
                    detectUSBConnectForStartCarlife()
                }
            }
            hasStartCarlifeEntry = true;
        }else{
            if(connection === 2 && (!mrevStatus))/*devState === 1*/
                carlife.displayCarlife(1)
            console.log("-----[MBC] <carlife> [startCarlifeEntry] already-start-carlife-not-again-just-display(",(connection === 2 && carlifeUsbPlugIn === true)?"y":"n",") connection(",connection,") carlifeUsbPlugIn(",carlifeUsbPlugIn,")")/*devState === 1*/
        }
    }

    function startCarlifeTimeOut(){
        console.log("-----[MBC] <carlife> [startCarlifeTimeOut]")
        hasDisplayDialog = false;
        detectUSBConnectForStartCarlife()
    }

    function detectUSBConnectForStartCarlife(){
        console.log("-----[MBC] <carlife> [detectUSBConnectForStartCarlife] usb-plug(",(devState==1)?"in":"out",") dev-type(",devType,") carlife-alive(",(devctl.checkMobileProcessAlive(_MOBILE_PROCESS_CARLIFE) === 0)?"n":"y",")")
        console.log("-----[MBC] <carlife> [detectUSBConnectForStartCarlife] switch carlife(",(application.wndlinkFlag)?"button":"home",")")

        switch(devState){
        case 1:
            switch(devType){
            case 5:
            case 3:
                 if (carlifeUsbPlugIn === false)
                 {
                    startCarlifeApp(1)
                    carlifeUsbPlugIn = true
                 }
                 break;
             case 4:
                 startCarlifeApp(0)
                 carlifeUsbPlugIn = true
                 break;
             default:
                 break;
            }
            break;
        case 2:
            switch(devType){
             case 3:
                 //quit.visible = true
                 //help.visible = true
                 carlifeUsbPlugIn = false
                 break;
             case 4:
                 quit.visible = true
                 help.visible = true
                 carlifeUsbPlugIn = false
                 if (application.wndlinkFlag !== true)
                 {
                     application.multiApplications.remove('carlife')
                 }
                 break;
            }

            break;
        default:
            break;
        }
    }

    function sendMacAddress(){
        console.log("-----[MBC] <carlife> sendMacAddress macSet:",macSet)

        if(macSet){
            return;
        }
        var sAddr = btctl.nativeDevInfo.addr;
        var dType = devctl.deviceInfo.devType;
        if( btMACCheck(sAddr) && (dType === 4 || dType === 3 || dType === 5) ){
            console.debug("[Carlife App]sendMacAddress,sAddr : ",sAddr);
            carlife.sendMacAddress(sAddr);
            macSet = true;
        }
    }

    function btMACCheck(sAddr){
        console.log("-----[MBC] <carlife> btMACCheck,sAddr : ",sAddr)

        var temp = sAddr;
        var flag = 1;
        if (temp.length === 17)
        {
            for (var j = 0; j < temp.length; j++)
            {
                if (j === 2 || j === 5 || j === 8
                        || j === 11 || j === 14)
                {
                    if (temp[j] !== ':')
                    {
                        flag = 0;
                        break;
                    }
                }
                else
                {
                    if (('0' <= temp[j] && temp[j] <= '9')
                            || ('a' <= temp[j] && temp[j] <= 'f')
                            || ('A' <= temp[j] && temp[j] <= 'F'))
                    {

                    }
                    else
                    {
                        flag = 0;
                        break;
                    }
                }
            }
        }
        else
        {
            flag = 0;
        }
        return flag;
    }

    function dialogConfirmTip(dialog){
        ///console.log("-----[MBC] <carlife> [dialogConfirmTip]")

        dialog.confirmed.connect(function confirmed(){
            console.log("-----[MBC] <carlife> [dialogConfirmTip](confirmed)")
            hasDisplayDialog = false;
            system.setMobileState(1);
            timeStartCarlife.running();
            timeStartCarlife.stop();
        });

        dialog.canceled.connect(function canceled(){
            console.log("-----[MBC] <carlife> [dialogConfirmTip](canceled)")
            hasDisplayDialog = false;
            timeStartCarlife.running();
            timeStartCarlife.stop();
        });
    }


    /*
     *-------------------UI component---------------------
    */
    Timer {
        id: timeStartCarlife
        interval: 4000;
        running: false;
        repeat: false;
        triggeredOnStart: false;
        onTriggered: startCarlifeTimeOut()
    }

    Image {
        id: bg
        source: "qrc:/resource-carlife/bg.png"
        Image {
            id: quit
            //visible: (connection === 1)||(connection === 2) ? false : true
            source: "qrc:/resource-carlife/carlife_Return.png"
            x: 96
            y: 62
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    application.multiApplications.back()
                }
            }
        }
        Image {
            id: help
            //visible: (connection === 1)||(connection === 2) ? false : true
            source: "qrc:/resource-carlife/Return_problem.png"
            anchors.right: bg.right
            anchors.rightMargin: 80
            anchors.top: bg.top
            anchors.topMargin: 50
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    application.changePage('help');
                }
            }
        }
    }

    Item {
        id: root
        width: 1280
        height: 720

        Loader{
            id: load
            width: 1280
            height: 720
            anchors.centerIn: parent;
            sourceComponent: connectIcon
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
                    source: "qrc:/resource-carlife/carlife_Mobile Internet.png"
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
            id: twoCode
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 53
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-carlife/carlife_QR code.png"
                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 48
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("手机端未安装百度 CarLife,请扫描二维码下载")
                        font.pixelSize: 48
                        color: '#FFFFFF'
                        Image {
                            id: button
                            anchors.top: parent.bottom
                            anchors.topMargin: 50
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "qrc:/resource-carlife/carlife_currency_box.png"
                            IControls.NonAnimationText_FontLight{
                                anchors.centerIn: parent
                                text: qsTr("重新连接")
                                font.pixelSize: 38
                                color: "#FEFEFE"
                            }
                            IControls.MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.log("[MBC] <carlife> [twoCode-dialog]{check}")
                                    errorDisplayState = false
                                    if(devType === 3)//apple
                                        startCarlifeApp(1)
                                    else if(devType === 4)//andriod
                                        startCarlifeApp(0)
                                }
                            }
                        }
                    }
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
                    source: "qrc:/resource-carlife/carlife_buffer.png"
                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 63
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("连接中...") + "  " + connProgress + "%"
                        font.pixelSize: 38
                        color: '#0875E4'
                    }
                    Image {
                        id: xuanzhuan
                        source: "qrc:/resource-carlife/carlife_buffer_sel.png"
                        RotationAnimation on rotation{
                            from: 0
                            to: 360
                            duration: 500
                            loops: Animation.Infinite
                        }
                    }

                }

                Component.onCompleted: {
                    console.log("[MBC] <carlife> [connecting]{onCompleted}")
                    quit.visible = false
                    help.visible = false
                }
            }
        }

        Component{
            id: success
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 194
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-carlife/baidu carlife_logo.png"
                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 51
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Baidu CarLife")
                        font.pixelSize: 38
                        color: '#FFFFFF'
                    }

                }
                IControls.MouseArea{
                    z:10
                    anchors.fill: parent
                    enabled: connection === 2 ? true : false
                    onPressed: {
                        carlife.sendTouchDataDown(mouseX,mouseY)
                    }
                    onReleased: {
                        carlife.sendTouchDataUp(mouseX,mouseY)
                    }
                    onPositionChanged: {
                        carlife.sendTouchDataMove(mouseX,mouseY)
                    }
                }
                Rectangle {
                    anchors.fill: parent
                    color: '#000001'
                }

                Component.onCompleted: {
                    console.log("[MBC] <carlife> [success]{onCompleted}")
                    quit.visible = false
                    help.visible = false
                    //videoctl.setOverlay(1, 0x000001, 255)
                }
            }
        }
        Component{
            id: fail
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 227
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-carlife/carlife_Mobile Internet.png"
                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 60
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("连接失败，未识别到连接")
                        font.pixelSize: 48
                        color: '#FFFFFF'
                        Image {
                            anchors.top: parent.bottom
                            anchors.topMargin: 70
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "qrc:/resource-carlife/carlife_currency_box.png"
                            IControls.NonAnimationText_FontLight{
                                anchors.centerIn: parent
                                text: qsTr("重新连接")
                                font.pixelSize: 38
                                color: "#FEFEFE"
                            }

                            IControls.MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    console.log("[MBC] <carlife> [fail-dialog]{check}")

                                    if(devType === 3)//apple
                                        startCarlifeApp(1)
                                    else if(devType === 4)//andriod
                                        startCarlifeApp(0)
                                }
                            }
                        }
                    }
                }
            }

        }
        Component{
            id: restart
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 189
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-carlife/carlife_phone.png"
                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 60
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("请重新点击手机端百度 CarLife")
                        font.pixelSize: 48
                        color: '#FFFFFF'
                        Image {
                            anchors.top: parent.bottom
                            anchors.topMargin: 70
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "qrc:/resource-carlife/carlife_currency_box.png"
                            IControls.NonAnimationText_FontLight{
                                anchors.centerIn: parent
                                text: qsTr("启动百度 CarLife")
                                font.pixelSize: 38
                                color: "#FEFEFE"
                            }

                            IControls.MouseArea{
                                anchors.fill: parent
                                enabled: !clickFlag
                                onClicked: {
                                    console.log("[MBC] <carlife> [restart-dialog]{check}")

                                    if(!clickFlag){
                                        carlife.displayCarlife(1)
                                        clickFlag = true
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }
        Component{
            id: call
            Item{
                width: 1280
                height: 720
                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 111
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/resource-carlife/carlife_call hone.png"
                    IControls.NonAnimationText_FontLight{
                        anchors.top: parent.bottom
                        anchors.topMargin: 51
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("通话中...")
                        font.pixelSize: 38
                        color: '#FFFFFF'
                        Image {
                            anchors.top: parent.bottom
                            anchors.topMargin: 83
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "qrc:/resource-carlife/carlife_currency_box.png"
                            IControls.NonAnimationText_FontLight{
                                anchors.centerIn: parent
                                text: qsTr("启动百度 CarLife")
                                font.pixelSize: 38
                                color: "#FEFEFE"
                            }

                            IControls.MouseArea{
                                anchors.fill: parent
                                enabled: !clickFlag
                                onClicked: {
                                    console.log("[MBC] <carlife> [call-dialog]{check}")

                                    if(!clickFlag){
                                        carlife.displayCarlife(1)
                                        clickFlag = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
