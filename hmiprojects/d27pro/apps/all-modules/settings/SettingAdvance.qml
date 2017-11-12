import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls

import TheXPresenter 1.0
import TheXAudio 1.0
import TheXSettings 1.0
import TheXRadio 1.0
import TheXWifi 1.0
import Bluetooth 1.0

import Apps 1.0

HSTab {
    id: root

    property bool isCopy: true

    property SystemCtl system: HSPluginsManager.get('system')
    property RadioCtl  radio : HSPluginsManager.get('radio')
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property WifiCtl wifictl : HSPluginsManager.get('wifictl')

    property real audioParamArkamys
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

    Connections {
        target: system
        onInitSettingChanged: {
            console.debug("[SettingAdvance] onInitializedChanged:", init)
            if (init) {
                system.getAllInfo()

                HmiCommon.requireSourceOn(HmiCommon.SourceRadio)
                radio.radioOpen()
                if (system.wifisw) {
                    wifictl.turnOff()
                }
                btctl.clearcontactsInfo(0)
                btctl.clearcontactsInfo(1)
                btctl.clearBTData()
                SoundCommon.getAllAudioParam()

                HSStore.datas = {}
            }
        }
    }

    Item {
        id: bg
        width: 1040
        height: 628

        ListView{
            id: setting
            width: 994
            height: 628
            model: ListModel{
                ListElement{caption:"可变氛围灯设置"; name:"lightSetting"}
                ListElement{caption:"语音提醒"; name:"siriSetting" }
                ListElement{caption:"默认互联设置"; name:"mobileSetting" }
                ListElement{caption:"恢复默认设置"; /*name:"resetSetting";*/ widLine: "1"}
                ListElement{caption:"版本信息"; name:"verInfo"; widLine: "1"}
                ListElement{caption:"版本升级"; name:"updatetest"; widLine: "1"}
                /*<add new requirement USB certify  chengzhi    20161121    begin*/
                //ListElement{caption:"Usb IF认证"; name:"usbifcerSetting"; widLine: "1"}
                /*add new requirement USB certify  chengzhi    20161121    end>*/
            }
            section.property: "widLine"
    //        section.criteria: ViewSection.FullString
            section.delegate: wideLine
            delegate: item
            clip: true
    //        snapMode: ListView.SnapToItem
            boundsBehavior: Flickable.StopAtBounds
        }
        Component{
            id: item
            IControls.ListItemDelegateF{
                textL: qsTr(caption) + ctranslator.monitor
                themeColor: interfacemodel
                onClicked: {
                    if(index == 3){
                        application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmTip.qml',{themeColor: interfacemodel,texttitle:qsTr('恢复默认设置'),textinfo:qsTr('系统将恢复默认值，是否继续？'),pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
                    }
                    else
                        application.changePage(name)
                }

            }
        }
        Component{
            id: wideLine
            Item{
                width: 1040
                height: 40
                Rectangle{
                    id: rect
                    width: 1040
                    height: 40
                    color: "#ffffff"
                    opacity: 0.06

                }
                Image {
                    id: bottomLine
                    anchors.bottom: rect.bottom
                    source: "qrc:/resources/list_lineA2.png"
                }
            }
        }
    }

    function dialogConfirmTip(dialog){
        /* BEGIN by Xiong wei, 2016.12.13
         * Press the Power button to remove the dialog
        */
        commonDialog(dialog)
        // End by xiongwei 2016.12.13
        dialog.confirmed.connect(function confirmed() {
            console.debug("[SettingAdvance] setInitialize...");
            system.initialize(system.InitSystem);
            application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogProgress.qml',{themeColor: interfacemodel,text:qsTr('恢复默认设置中')})
        });
    }
}
