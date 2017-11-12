import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import Bluetooth 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id: root

    property bool isCopy: true
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property int powerState: btctl.powerState
    property int interfacemodel: system.interfacemodel
    property bool btStatus: powerState === 2 //system.btsw

    property var currentDialog


    Component.onCompleted: {
        btctl.getLocalDevInfo();
        btSwitch.checked = btStatus
        btSwitch.checkedChanged.connect(function() {
            if (btSwitch.checked) {
                console.log(powerState)
                btctl.turnOn()
                application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("正在开启蓝牙"),autoCloseTimeout: 3000 },dialogBTOpen);
            }
            else {
                console.log(powerState)
                btctl.turnOff()
                application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("正在关闭蓝牙"),autoCloseTimeout: 3000 },dialogBTOpen);
            }
        })

        if (powerState === 2) {
            btctl.scanMode(true)
        }
    }

    /* BEGIN by Xiong wei, 2016.12.13
     * Press the Power button to remove the dialog
    */
    onVisibleChanged: {
        console.log("[SettingCommon] onVisibleChanged visible ")
        if(currentDialog) {
            if (!visible) {
                currentDialog.close()
            }
        }

        if (!visible) {
            btctl.scanMode(false)
        }
    }

    onItemHiden: {
        btctl.scanMode(false)
    }

    function commonDialog(dialog){
        currentDialog = dialog;
        if(!visible) {
            dialog.close()
        }
        console.debug("[SettingNetwork] currentDialog[text]" , currentDialog['text']);
    }
    //End by xiongwei 2016.12.13

    /* BEGIN by Zhang Yi, 2016.11.19
     * Bt state should be remembered when switch changed.
    */
    Connections {
        target: btctl
        onPowerStateChanged: {
            system.setBtsw(powerState === 2)
            if (powerState === 2) {
                btctl.scanMode(true)
            }
        }
        onPairStateChanged: {
            console.debug('[SettingNetwork] onPairStateChanged: ',pairState);

            if(pairState == 2){
                if(currentDialog) {
                    currentDialog.closed();
                }
                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmTip.qml',{themeColor: interfacemodel,textinfo:
                            qsTr("蓝牙设备\"") + btctl.curPairedDevInfo.devName + qsTr("\"请求连接,\n配对密钥为:")+ btctl.pairingPhonePIN
                             +qsTr("，请确认"),texttitle:qsTr("配对中"),pixelSizeinfo:system.language === 0 ? 36 : 30},dialogPairPin);
            }
            if(pairState == 4) {
                if(currentDialog) {
                    currentDialog.close()
                }
            }
        }
    }
    /* END - by Zhang Yi, 2016.11.19 */

    Item {
        width: 1040
        height: 628
        IControls.ListItemDelegateH {
            id: btSwitch
            checked: btStatus
            anchors.top: parent.top
            text: qsTr("车载蓝牙")
            themeColor: interfacemodel
        }
        IControls.ListItemDelegateF{
            id: btName
            themeColor: interfacemodel
            anchors.top: btSwitch.bottom
            textL: qsTr("蓝牙名称")
            textR: btctl.nativeDevInfo.name
            onClicked: {
                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmInput.qml',{themeColor: interfacemodel,texttitle:qsTr('蓝牙显示名'),textinfo: btctl.nativeDevInfo.name},dialogConfirmInput);
            }
        }
        IControls.ListItemDelegateF{
            id: wlan
            themeColor: interfacemodel
            anchors.top: btName.bottom
            textL: qsTr("WLAN热点设置")
            enabled: false
            textLColor:"#373737"
            onClicked: {
                application.changePage('connectSetting')
            }
        }

    }
    function dialogBTOpen(dialog){
        console.debug("dialogBTOpen open");
        commonDialog(dialog)
        dialog.closed.connect(function closed(){
            console.debug("dialogBTOpen auto closed:");
            if(btSwitch.checked) {
                var showText = qsTr("开启失败");
                if(powerState == 2) {
                    showText = qsTr("开启成功");
                }
                application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: showText },commonDialog);
            }
        })

        dialog.opened.connect(function (){
            console.debug("dialog opened:",powerState);
            if(dialog) {
                dialog.close();
            }
        })
    }

    function dialogConfirmInput(dialog){
        console.debug("dialogBTOpen open");
        //modify by xiongwei 2016.12.13
        commonDialog(dialog)
        //modify by xiongwei 2016.12.13
//        openBTdialog = dialog
        dialog.confirmed_info.connect(function (info){
            btctl.setDevName(info);
        })
        dialog.canceled_info.connect(function (info){
//            btctl.setDevName(info);
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
}

