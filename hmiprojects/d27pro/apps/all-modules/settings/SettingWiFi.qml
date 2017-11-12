import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import TheXWifi 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id: root

    property bool isCopy: false
    property WifiCtl wifictl: HSPluginsManager.get('wifictl')
    property SystemCtl system: HSPluginsManager.get('system')
    property string codemethod;
    property var dialog;
    property var txtIndex;
    property bool set: false

    property string ssid: wifictl.ssid
    property string passwd: wifictl.passwd
    property int keymodel: wifictl.keymodel
    property int apmodel: wifictl.apmodel
    property int interfacemodel: system.interfacemodel

    /* BEGIN by Xiong wei, 2016.12.13
     * Press the Power button to remove the dialog
    */
    property var currentDialog

    function commonDialog(dialog){
        currentDialog = dialog;
        console.debug("[SettingAdvance] currentDialog[text]" , currentDialog['text']);
    }

    onVisibleChanged: {
        console.log("[SettingAdvance] onVisibleChanged visible ")
        if(currentDialog) {
            if (!visible) {
                currentDialog.close()
            }
        }

    }
    // End by xiongwei 2016.12.13

    onItemShown: {
        switch (keymodel) {
        case 0: codemethod = "OPEN"; break
        case 1: codemethod = "WPA-PSK"; break
        case 2: codemethod = "WPA-2-PSK"; break
        }
    }

    Item {
        width: 1040
        height: 628
        IControls.ListItemDelegateF {
            id: ssidde
            anchors.top: parent.top
            themeColor: interfacemodel
            textL: qsTr("SSID")
            textR: ssid
            onClicked: {
                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmInput.qml',{themeColor: interfacemodel,texttitle:qsTr('SSID'),textinfo: ssid},dialogSSIDInput);
            }
        }
        IControls.ListItemDelegateH {
            id: radioSwitch
            anchors.top: ssidde.bottom
            themeColor: interfacemodel
            text: qsTr("SSID广播")
            checked: apmodel === 1
            onClicked: {
                wifictl.setApConfig(ssid, passwd, keymodel, checked ? 1 : 0)
            }
        }
        IControls.ListItemDelegateF {
            id: codeMethod
            anchors.top: radioSwitch.bottom
            themeColor: interfacemodel
            textL: qsTr("加密方式")
            textR: qsTr(codemethod)
            onClicked: {
                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmSelected.qml',{themeColor: interfacemodel,texttitle:qsTr('加密方式'),index:keymodel},dialogConfirmselected)
//                root.dialog.close();
            }
        }
        IControls.ListItemDelegateF{
            id: code
            anchors.top: codeMethod.bottom
            themeColor: interfacemodel
            textL: qsTr("密码")
            textR: passwd
            onClicked: {
                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmInput.qml',{themeColor: interfacemodel,texttitle:qsTr('密码'),textinfo: passwd},dialogPasswdInput);
            }
        }
//        IControls.ListItemDelegateF{
//            id: wlan
//            anchors.top: btName.bottom
//            textL: qsTr("WLAN热点设置")
//            onClicked: {
//                application.changePage('connectSetting')
//            }
//        }

    }
    function dialogConfirmselected(dialog){
//                root.dialog = dialog;
        commonDialog(dialog)
        dialog.canceled_info.connect(function canceled(info){
            console.debug("dialogConfirmselected cb canceled:", info);
        });
        dialog.confirmed_info.connect(function confirmed(info){
            console.debug("dialogConfirmselected cb confirmed:", info);

            wifictl.setApConfig(ssid, passwd, info, apmodel);

            if(info === 0) {
                codemethod = "OPEN"
            }
            else if(info === 1) {
                codemethod = "WPA-PSK"
            }
            else if(info === 2) {
                codemethod = "WPA-2-PSK"
            }
        });
    }

    function dialogSSIDInput(dialog){
        console.debug("dialogSSID open");
        commonDialog(dialog)
        dialog.confirmed_info.connect(function (info){
            console.debug(" dialog.confirmed_info", info);
            wifictl.setApConfig(info, passwd, keymodel, apmodel)
        })
    }

    function dialogPasswdInput(dialog){
        console.debug("dialogPasswd open");
        commonDialog(dialog)
        dialog.confirmed_info.connect(function (info){
            console.debug(" dialog.confirmed_info", info);
            wifictl.setApConfig(ssid, info, keymodel, apmodel)
        })
    }
}

