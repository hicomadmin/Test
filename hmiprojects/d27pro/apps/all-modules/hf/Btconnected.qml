import QtQuick 2.0
import Bluetooth 1.0
import TheXSettings 1.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import Apps 1.0

HSTab {
    property bool isCopy: false
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')

    //bt pair devices info
    property int pairedDevCount
    property var pairedDevs

    // bug 167 74
    // bt discover device
    property var discoveredDevs

    //bt device status
    property int powerState
    property int connectState

    //bt pair status
    property int pairState
    property string pairingPhonePIN

    property int interfacemodel

    /** denfine attribute start **/
    //connect bt last phone
    property var lastPhone

    property var curPairedDevInfo

    property bool btOpen : false

    property bool isConnected : false  //connect
    property var curConnectDevMac;
    property var curConnectDevInfo;
    property var curDisConnectDevMac;

//    property int lastPhoneConnected

//    property var openBTdialog
//    property var openPairdialog
//    property var pairingDialog
//    property var connectdialog
//    property var disconnectdialog
//    property var disconnectingdialog
//    property bool openBTdialogClose: false

    property var currentDialog
    /** denfine attribute end **/

    /** Attribute change funcation start **/
    onItemHiden: {
        item.enabled = false
    }

    onItemShown: {
        console.log("[Btconnected] onItemShown!!!")
        item.enabled = true
    }

    onBtctlChanged: {
        powerState = Qt.binding(function (){return btctl.powerState})
        connectState = Qt.binding(function (){return btctl.connectState})

        pairedDevCount = Qt.binding(function (){return btctl.pairedDevCount})
        pairedDevs = Qt.binding(function (){return btctl.pairedDevsInfo})
        discoveredDevs = Qt.binding(function (){return btctl.availableDevInfo})

        pairState = Qt.binding(function (){return btctl.pairState})

        curPairedDevInfo = Qt.binding(function (){return btctl.curPairedDevInfo})

        curConnectDevInfo = Qt.binding(function (){return btctl.curConnectDevInfo})

        console.log("[Btconnected] onConnectChanged powerState = ",btctl.powerState)
        console.log("[Btconnected] onConnectChanged pairedDevCount = ",btctl.pairedDevCount)
        console.log("[Btconnected] onConnectChanged connectState = ",btctl.connectState)

        initViewData()
    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    onVisibleChanged: {
        console.log("[Btconnected] onVisibleChanged visible = " + visible)
        console.log("[Btconnected] onVisibleChanged currentDialog = " + currentDialog)
        if(currentDialog) {
            if(!visible) {
                currentDialog.close()
            } else {
//                currentDialog.visible = true //open()
            }
        }
    }

    onPowerStateChanged: {
        /* BEGIN by Zhang Yi, 2016.11.19
         * Bt state should be remembered when switch changed.
        */
        system.setBtsw(powerState === 2)
        /* END - by Zhang Yi, 2016.11.19 */
        initViewData()

        console.debug("onPowerStateChanged  btOpen :" + btOpen);
        console.debug("onPowerStateChanged  powerState :" + powerState);
        if(btOpen && (powerState == 0 || powerState == 1)) {
            btOpen = false
            application.createTipDialogAsync(
                'qrc:/Instances/Controls/DialogTip.qml',
                {themeColor:interfacemodel,text:qsTr("蓝牙打开失败")},
                 commonDialog)
        }
    }

    onConnectStateChanged: {
        console.debug('[Btconnected] onConnectStateChanged connectState: ',connectState)

        if(isConnect()) {
            console.debug('[Btconnected] onConnectStateChanged btctl.hfpconnectdev: ',btctl.hfpconnectdev)
            if(btctl.hfpconnectdev.name) {
                lastPhone = btctl.hfpconnectdev
                lastPhone.devName = btctl.hfpconnectdev.name
            }
            for (var pairedkey in pairedDevs){
                if(pairedDevs[pairedkey]['hfpconnectdev'] || pairedDevs[pairedkey]['a2dpconnectdev']) {
                    console.debug('[Btconnected] devAddr: ',pairedDevs[pairedkey]['devAddr'])
                    lastPhone = pairedDevs[pairedkey]
                }
            }
        }
        initViewData()
    }

    onCurConnectDevInfoChanged: {
        console.debug('[Btconnected] isConnected: ', isConnected)
        console.debug('[Btconnected] curConnectDevMac: ', curConnectDevMac)
        console.debug('[Btconnected] curDisConnectDevMac: ', curDisConnectDevMac)
        console.debug('[Btconnected] curConnectDevInfo.devAddr: ', curConnectDevInfo.devAddr)
        console.debug('[Btconnected] curConnectDevInfo.connectState: ', curConnectDevInfo.connectState)
        if(curDisConnectDevMac != "" && curConnectDevInfo.devAddr == curDisConnectDevMac) {
            if((curConnectDevInfo.connectState&0xff) === 0x22) {
                curDisConnectDevMac = ""
            }
            return
        }
        if(isConnected) {
            if((curConnectDevInfo.connectState&0xf0) === 0x10 || (curConnectDevInfo.connectState&0x0f) === 0x01) {
                currentDialog.close();
                isConnected = false
                curConnectDevMac = ""
            }

            if(curConnectDevInfo.devAddr == curConnectDevMac) {
                if((curConnectDevInfo.connectState&0xf0) == 0x40 || (curConnectDevInfo.connectState&0xf0) == 0x20) {
                    currentDialog.close();
                    isConnected = false
                    curConnectDevMac = ""

                    application.createTipDialogAsync(
                        'qrc:/Instances/Controls/DialogTip.qml',{
                            themeColor: interfacemodel,
                            text: qsTr("连接失败"),
                            autoCloseTimeout: 2000},commonDialog)
                }
            }
        }
    }

    onPairedDevCountChanged: {
        console.debug('[Btconnected] onPairedDevCountChanged pairedDevCount = ',pairedDevCount)
    }

    onPairedDevsChanged: {
        console.debug('[Btconnected] onPairedDevsChanged pairedDevs: ',pairedDevs)
        if(pairedDevs.length == 0) {
            lastPhone = undefined
        }

        initViewData()
        updateDisDevslistModel()
    }

    onDiscoveredDevsChanged: {
        console.debug('[Btconnected] onDiscoveredDevsChanged discoveredDevs = ',discoveredDevs)
        updateDisDevslistModel()
    }

    onPairStateChanged: {
        console.debug('[Btconnected] onPairStateChanged: ',pairState);
        if(pairState == 2){
            btctl.confirmPIN(true);
        }

    }
    /** Attribute change funcation end **/

    /** js funcation start **/
    function initViewData() {
        buttonLeft.visible  = false;
        if(btctl.powerState === 2) { //已开启BT
            buttonLabel.text = qsTr("重新搜索")
            if(isConnect()) {
                linkUpLabel.text = qsTr("已连接:")
                linkDownLabel.text = lastPhone.devName
                linkDownLabel.visible = true
                buttonLeft.visible = true
                buttonLeftLabel.text = qsTr("断开")
            } else {
                linkUpLabel.text = qsTr("未检测到连接过的设备")
                showTip.anchors.topMargin = 27
                linkDownLabel.visible = false
                if(lastPhone !== undefined) {
                    showTip.anchors.topMargin = 10
//                    linkLabel.text = qsTr("最后一次连接过的\n设备 "+lastPhone.devName)
                    linkUpLabel.text = qsTr("最后一次连接过的设备:")
                    linkDownLabel.text = lastPhone.devName
                    linkDownLabel.visible = true
                    buttonLeft.visible = true
                    buttonLeftLabel.text = qsTr("连接")
                }
            }
        } else { //未开启BT
            showTip.anchors.topMargin = 27
            linkUpLabel.text = qsTr("蓝牙已关闭，使用电话功能需要打开蓝牙")
            linkDownLabel.visible = false
            buttonLabel.text = qsTr("打开蓝牙")
            disDevslistModel.clear()
        }
    }

    function isConnect() {
        console.log('[Btconnected] isConnect = ', connectState)
        return (connectState&0xf0) === 0x10 || (connectState&0x0f) === 0x01
    }

    function updateDisDevslistModel() {
        disDevslistModel.clear()

        if(pairedDevs instanceof Array) {
            pairedDevs.sort(function(a,b){
                if(b.hfpconnectState == a.hfpconnectState) {
                    if(b.lastFlag != a.lastFlag) {
                        return b.lastFlag - a.lastFlag;
                    } else {
                        if(b.devAddr > a.devAddr) {
                            return 1;
                        } else if (b.devAddr < a.devAddr) {
                            return -1;
                        } else {
                            return 0;
                        }
                    }
                }
                return b.hfpconnectState - a.hfpconnectState;
            });

            for (var pairedkey in pairedDevs){
                for(var key1 in pairedDevs[pairedkey]) {
                    console.log('[Btconnected] pairedkey['+ key1 + '] = ', pairedDevs[pairedkey][key1])
                }
                console.log('--------------------------------------------------')
                var dataMode = pairedDevs[pairedkey]
                dataMode.pairedState = 1
                disDevslistModel.append(dataMode)

                if(pairedDevs[pairedkey].lastFlag){
                    lastPhone = pairedDevs[pairedkey]
                    linkDownLabel.text = lastPhone.devName
                }
            }
        }

        if(discoveredDevs instanceof Array) {
            console.log('btctl.getScanDevValue() = ', btctl.getScanDevValue())
            if(discoveredDevs.length > 0 && btctl.getScanDevValue() == 1) {
                disDevslistModel.clear()
                discoveredDevs.sort(function(a,b){
                    if(b.pairedState == a.pairedState) {
                        if(b.pairedState == 1) {
                            if(b.lastFlag != a.lastFlag) {
                                return b.lastFlag - a.lastFlag;
                            }
                        } else {
                            if(b.devAddr > a.devAddr) {
                                return 1;
                            } else if (b.devAddr < a.devAddr) {
                                return -1;
                            } else {
                                return 0;
                            }
                        }
                    }
                    return b.pairedState - a.pairedState;
                });
                disDevslistModel.append(discoveredDevs)

                for (var key in discoveredDevs){
                    for(var key2 in discoveredDevs[key]) {
                        console.log('[Btconnected] discoveredDevs['+ key2+ '] = ', discoveredDevs[key][key2])
                    }
                }
            }
        }

        console.log('[Btconnected] disDevslistModel.count = ', disDevslistModel.count)
        if(disDevslistModel.count > 0) {
            comboBoxA.showState = "dropDown"
        }
    }

    function dialogBTOpen(dialog){
        console.debug("[Btconnected] dialogBTOpen open")

        currentDialog = dialog

        dialog.closed.connect(function (){
            console.debug("[Btconnected] dialogBTOpen auto closed:")
            btOpen = true
        })
    }

    function serachDialog(dialog){
        console.debug("[Btconnected] serachDialog open")
        currentDialog = dialog

        dialog.canceled.connect(function canceled(){
            btctl.stopScanDev()
        })

        dialog.closed.connect(function (){
            btctl.stopScanDev()
        })
    }

    function dialogPairPin(dialog){
        console.debug("[Btconnected] dialogPairPin open");
        currentDialog = dialog

        dialog.canceled.connect(function canceled(info){
            btctl.confirmPIN(false);
        });
        dialog.confirmed.connect(function confirmed(info){
            btctl.confirmPIN(true);
        });
    }

    function dialogConnecting(dialog){
        console.debug("[Btconnected] dialogConnect open")
        currentDialog = dialog
        dialog.closed.connect(function (){
            isConnected = false
            curDisConnectDevMac = ""
            curConnectDevMac = ""
            console.debug("[Btconnected] dialogConnect auto closed:")
        })
        dialog.opened.connect(function (){
            console.debug("dialog opened:",connectState)
        })
    }

    function dialogDisconnect(dialog){
        console.debug("[Btconnected] dialogDisconnect open!!!")
        currentDialog = dialog

        dialog.canceled.connect(function canceled(info){
            console.log('[Btconnected] cancel disconnected!!!')
        })
        dialog.confirmed.connect(function confirmed(info){
            btctl.disconnectDev()
            application.createTipDialogAsync(
                'qrc:/Instances/Controls/DialogTip.qml',{
                    themeColor: interfacemodel,
                    text: qsTr("连接断开"),
                    autoCloseTimeout: 2000},
                    commonDialog)
        })
    }

    function commonDialog(dialog){
        console.debug("[Btconnected] commonDialog !!!");
        currentDialog = dialog;
        console.debug("[Btconnected] currentDialog[text]" , currentDialog['text']);
    }
    /** js funcation end **/

    /** layout start **/
    Item {
        id: item
        anchors.fill: parent

        Image {
            id: btlogo
            height: 58
            width: 39
            anchors.left: parent.left
            anchors.leftMargin: 66
            anchors.top: parent.top
            anchors.topMargin: 27
            source: "qrc:/resources-hf/Phone_Icon_ connect_bt.png"
        }

        Rectangle {
            id: showTip
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: btlogo.right
            anchors.leftMargin: 27

            UControls.NonAnimation_Text {
                id: linkUpLabel
                width:625
                elide:Text.ElideRight
                color: interfacemodel == 0?'#66f8d4':(interfacemodel == 1?"#ff2200":"#986142")
                font.pixelSize: 32
            }

            UControls.NonAnimation_Text {
                id: linkDownLabel
                width:425
                anchors.top: linkUpLabel.bottom
                anchors.topMargin: 3
                elide:Text.ElideRight
                color: interfacemodel == 0?'#66f8d4':(interfacemodel == 1?"#ff2200":"#986142")
                font.pixelSize: 32
            }
        }

        IControls.RoundLabButtonA {
            id: buttonLeft
            width: 200
            height: 90
            anchors.right: buttonRight.left
            anchors.rightMargin: 10
            anchors.top: buttonRight.top
            themeColor: interfacemodel

            UControls.NonAnimation_Text {
                id: buttonLeftLabel
                anchors.centerIn: parent
                font.pixelSize: 32
                color: '#ffffff'
            }

            onClicked: {
                if(buttonLeftLabel.text === qsTr("断开")) {
                    application.createConfirmDialogAsync(
                    'qrc:/Instances/Controls/DialogConfirmTip.qml',{
                        themeColor: interfacemodel,
                        textinfo: qsTr("此操作将会断开您与该设备的连接，是否确定断开？"),
                        texttitle:qsTr("断开连接"),
                        pixelSizeinfo:system.language === 0 ? 36 : 30

                    },
                    dialogDisconnect)
                }
                if(buttonLeftLabel.text === qsTr("连接")) {
                    btctl.hfpOn(lastPhone.devAddr)
                    curConnectDevMac = lastPhone.devAddr
                    isConnected = true
                    application.createConfirmDialogAsync(
                        'qrc:/Instances/Controls/DialogProgress.qml',{
                            themeColor: interfacemodel,
                            text: qsTr("连接中"),
                            autoCloseTimeout: 40000
                         },
                         dialogConnecting)
                }
            }

        }

        IControls.RoundLabButtonA {
            id: buttonRight
            width: 200
            height: 90
            anchors.top: parent.top
            anchors.topMargin: 17

            anchors.left: parent.left
            anchors.leftMargin: 796
            themeColor: interfacemodel

            UControls.NonAnimation_Text {
                id: buttonLabel
                anchors.centerIn: parent
                font.pixelSize: 32
                color: '#ffffff'
            }

            onClicked: {
                if(buttonLabel.text === qsTr("打开蓝牙")) {
                    btctl.turnOn()
                    application.createTipDialogAsync(
                        'qrc:/Instances/Controls/DialogTip.qml', {
                            themeColor: interfacemodel,
                            text: qsTr("正在打开蓝牙"),
                            autoCloseTimeout: 10000
                         },
                        dialogBTOpen
                    )
                }

                if(buttonLabel.text === qsTr("重新搜索")){
//                    btctl.scanMode(true)
                    btctl.setScanDevValue(1);
                    btctl.startScanDev()
                    //Bug #151
                    application.createConfirmDialogAsync(
                        'qrc:/Instances/Controls/DialogCancelTip.qml',{
                            themeColor: interfacemodel,
                            text: qsTr("正在搜索..."),
                            autoCloseTimeout: 12000
                        },
                        serachDialog
                    )
                }
            }
        }

        IControls.ComboBoxList {
            id: comboBoxA
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 124

            comboboxRecWidth: 1038
            comboboxRecHeight: 60
            bthemeflag: interfacemodel

            listViewHeight: 124
            devLabelText: qsTr("可用设备")
            butVisible: false

            listViewModel:
                ListModel {
                id: disDevslistModel
            }

            onButtonConnectSignal: {
                if(disDevslistModel.get(index).hfpconnectState == 1 ||
                   disDevslistModel.get(index).a2dpconnectState == 1) {
                    application.createConfirmDialogAsync(
                    'qrc:/Instances/Controls/DialogConfirmTip.qml',{
                        themeColor: interfacemodel,
                        textinfo: qsTr("此操作将会断开您与该设备的连接，是否确定断开？"),
                        texttitle:qsTr("断开连接"),
                        pixelSizeinfo:system.language === 0 ? 36 : 30
                    },
                    dialogDisconnect)
                } else {
                    isConnected = true
                    if(btctl.hfpconnectdev && isConnect()) {
                        curDisConnectDevMac = btctl.hfpconnectdev.devAddr
                    }
                    curConnectDevMac = disDevslistModel.get(index).devAddr
                    btctl.hfpOn(disDevslistModel.get(index).devAddr)
                    application.createConfirmDialogAsync(
                        'qrc:/Instances/Controls/DialogProgress.qml',{
                            themeColor: interfacemodel,
                            text: qsTr("连接中"),
                            autoCloseTimeout: 40000
                         },
                         dialogConnecting)
                }
            }
        }
    }

}
    /** layout end **/
