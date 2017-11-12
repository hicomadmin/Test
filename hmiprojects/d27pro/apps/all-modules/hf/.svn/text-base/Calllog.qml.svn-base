import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQml.Models 2.2
import Bluetooth 1.0
import TheXSettings 1.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
import Apps 1.0

HSTab {
    id:root;

    property bool isCopy: false;
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')

    property int pairedDevCount;
    property int powerState;
    property int connectState;
    property int interfacemodel

    property int calllogCount
    property int calllogDownloadState

    property int telStatus

    property bool isSync: false;

//    property var downloadDialog
//    property var clearCalllogdialog

    property var currentDialog

    property var callloglistmodel: ListModel { id: listModel }

    onItemHiden: {
        console.log("[calllog] onItemHiden!!!")
        item.enabled = false;
    }

    onItemShown: {
        item.enabled = true;
        console.log("[calllog] onItemShown!!!")
        switchShow()
        rec1.visible = true
    }

    onTelStatusChanged: {
        if(telStatus == 7) {
//            rec1.sourceComponent = com2;
//            btctl.getcontactsInfo(0,1);
//            rec1.item.initComponent();
        }
    }

    onVisibleChanged: {
        console.log("[calllog] onVisibleChanged visible = " + visible)
        console.log("[calllog] onVisibleChanged currentDialog = " + currentDialog)

//        for(var key in currentDialog) {
//            console.log("[calllog] " + key + " = " + currentDialog[key])
//        }

        if(currentDialog) {
            if(!visible) {
                currentDialog.close()
            } else {
                currentDialog = undefined
//                currentDialog.visible = true //open()
            }
        }
    }

    onBtctlChanged: {
        powerState = Qt.binding(function (){return btctl.powerState});
        pairedDevCount = Qt.binding(function (){return btctl.pairedDevCount});
        connectState = Qt.binding(function (){return btctl.connectState});
        calllogCount = Qt.binding(function (){return btctl.calllogCount});
        calllogDownloadState = Qt.binding(function (){return btctl.calllogDownloadState});
        telStatus = Qt.binding(function (){return btctl.telStatus});
    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    onPowerStateChanged: {
        console.log("[calllog] onPowerStateChanged!!!")
        switchShow()
    }

    onConnectStateChanged: {
        console.log("[calllog] onConnectStateChanged!!!")
        switchShow()
    }

    onCalllogDownloadStateChanged: {
        //0: 未定义 1: 开始下载 2: 下载中 3: 下载完成 4: 取消下载 5: 下载失败
        switch(calllogDownloadState) {
            case 1:
                break;
            case 2:
                if(currentDialog == undefined){
                    application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,
                    text: qsTr("正在同步通话记录，请稍等…")
                   ,autoCloseTimeout: 15000}, commonDialog);
                }
                break;
            case 3:
                if(currentDialog) {
                    currentDialog.close();
                }
                if(isSync) {
                    application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("同步通话记录完成"),autoCloseTimeout: 3000 }, commonDialog);
                    isSync = false;
                }
                if(calllogCount > 0) {
                    rec1.sourceComponent = com2;
                    btctl.getcontactsInfo(0,1);
                    rec1.item.initComponent();
                }
                break;
            case 4:
                break;
            case 5:
                if(currentDialog) {
                    currentDialog.close();
                    application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("同步通话记录失败"),autoCloseTimeout: 3000 }, commonDialog);
                }
                break;
        }
    }

    onCalllogCountChanged: {
        console.log("[calllog] onCalllogCountChanged calllogCount=",calllogCount)
        if(calllogCount === 0) {
            listModel.clear();
        }
        console.log("[calllog] onCalllogCountChanged telStatus=",telStatus)
        if(calllogCount > 0 && telStatus == 7) {
            rec1.sourceComponent = com2;
            btctl.getcontactsInfo(0,1);
            rec1.item.initComponent();
        }
    }

    function commonDialog(dialog){
        console.debug("[calllog] commonDialog !!!");
        currentDialog = dialog;
        console.debug("[calllog] currentDialog[text]" , currentDialog['text']);
    }

    //切换界面显示
    function switchShow() {
        console.debug("[calllog] switchShow powerState = ", powerState);
        if(powerState === 2) {
            console.debug("[calllog] switchShow connectState = ", connectState);
            if((connectState & 0xf0) === 0x10){
                console.debug("[calllog] switchShow calllogCount = ", calllogCount);
                if(calllogCount > 0) {
                    rec1.sourceComponent = com2;
                    btctl.getcontactsInfo(0,1);
                    rec1.item.initComponent();
                } else {
                    rec1.sourceComponent = com1;
                }
            } else {
                listModel.clear();
                rec1.sourceComponent = com1;
//                btctl.clearcontactsInfo(1)
                //to do switch page  dialnumber
            }
        } else {
            listModel.clear();
            btctl.clearcontactsInfo(1)
            rec1.sourceComponent = com1;
            // to do switch page btconnected
        }
    }

    //来电去电图标显示
    function getPhoneUrl(phoneType){
        console.debug("[calllog] getPhoneUrl phoneType:", phoneType)
        if(phoneType == 4){
            return "qrc:/resources-hf/Phone_Icon_ character_Call.png"
        } else if(phoneType == 5) {
            return "qrc:/resources-hf/Phone_Icon_ character_Go electric.png"
        } else if(phoneType == 3) {
            return "qrc:/resources-hf/Phone_Icon_ character_Missed.png"
        }
    }

    Item {
        id: item
        anchors.fill: parent

        Loader{
            id:rec1
            visible: false
            active:true
            anchors.fill: item;
//            sourceComponent: com1
        }

        Component{
            id:com1;
            Item {
                id: bgRec
                anchors.fill: parent;

                IControls.RoundLabButtonB {
                    id: synButton
                    width: 833
                    height: 107
                    anchors.left: bgRec.left
                    anchors.leftMargin: 120
                    anchors.bottom: bgRec.bottom
                    anchors.bottomMargin: 4
                    themeColor: interfacemodel

                    onClicked: {

//                        if(btctl.getValue('clear_calllog')){
//                            btctl.setValue('clear_calllog',false);
//                            btctl.getcontactsInfo(0,1);
//                        }else {
                            isSync = true;
                            btctl.downloadContacts(1);
                            console.debug("[Calllog] Download Call History List！！！")
//                        }
                    }
                }

                UControls.NonAnimation_Text {
                    id: buttonLabel
                    anchors.centerIn: synButton
                    text: qsTr("同步")
                    font.pixelSize: 32
                    color: '#ffffff'
                }

                Image {
                    id: noCallLogo
                    height: 123
                    width: 124
                    anchors.left: bgRec.left
                    anchors.leftMargin: 474
                    anchors.top: bgRec.top
                    anchors.topMargin: 155
                    source: interfacemodel == 0 ? "qrc:/resources-hf/Phone_Icon_No phone.png":
                                                  (interfacemodel == 1 ? "qrc:/resources-hf/Phone_Icon_No-phone.png":"qrc:/resources-hf/Phone_Icon_No phone_g.png")
                }

                UControls.NonAnimation_Text {
                    id: noPhoneLabel
                    anchors.horizontalCenter: noCallLogo.horizontalCenter
                    anchors.top: bgRec.top
                    anchors.topMargin: 299

                    text: qsTr("无通话记录")
                    font.pixelSize: 32
                    color: '#ffffff'
                }
            }

        }

        Component{
            id:com2;

            Item {
                id: listRec
                anchors.fill: parent;

                function initComponent() {
                   calllogList.listView.listView.currentIndex = 0
                   calllogList.listView.paginationLoaderDelegate.refreshed()
                }

                IControls.ListViewA {
                    id:calllogList
                    height: 500
                    anchors.left: parent.left
                    anchors.top: parent.top
                    navbarRightMargin: 75
                    model: callloglistmodel
                    delegate:  IControls.ListItemDelegateCallLog {
                        id: listDelegate
                        width: 1000
                        iconurl: interfacemodel == 0 ? "qrc:/resources-hf/Phone_Icon_ character.png":
                                 (interfacemodel == 1 ? "qrc:/resources-hf/Phone_Icon_-character.png":"qrc:/resources-hf/Phone_Icon_ character_g.png")

                        //contactname: name != "" ? name : qsTr("未知");
                        contactname: {
                            var itemName;

                            if(name != ""){
                                itemName = name;
                            }
                            else{
                                itemName = qsTr("未知");
                            }

                            itemName;
                        }
                        contactnum: number;
                        calltime: time;
                        themeColor: interfacemodel;
                        stateiconurl: getPhoneUrl(BtStorageType)
                        onClicked: {
                            btctl.phoneCallTask(number);
                            console.debug("[calllog] btctl.phoneCallTask(number) number:",number)
                        }

                    }

                    listView.usePaginationLoader: true;
                    listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
                        function loadPageAsync(page, cb) {
                            btctl.allCallRecordChanged.connect(function handler(allCallRecord){
                                btctl.allCallRecordChanged.disconnect(handler);
                                cb(null, allCallRecord) ;
                            });
                            btctl.getcontactsInfo(page - 1, 1);
                        }

                    }

                }

                IControls.RoundLabButtonB {
                    id: synButton
                    width: 340
                    height: 104
                    anchors.left: listRec.left
                    anchors.leftMargin: 64
                    anchors.bottom: listRec.bottom
                    anchors.bottomMargin: 3
                    themeColor: interfacemodel;

                    onClicked: {
                        console.debug("[calllog] Synchronize Call History List！！！")
                        //                        listModel.clear();
                        isSync = true;
                        btctl.downloadContacts(1);
                    }
                }

                UControls.NonAnimation_Text {
                    id: sysLabel
                    anchors.centerIn: synButton
                    text: qsTr("同步")
                    font.pixelSize: 32
                    color: '#ffffff'
                }

                IControls.RoundLabButtonB {
                    id: cleanButton
                    width: 340
                    height: 104
                    anchors.left: synButton.right
                    anchors.leftMargin: 147
                    anchors.bottom: listRec.bottom
                    anchors.bottomMargin: 3
                    themeColor: interfacemodel;

                    onClicked: {
                        console.debug("[calllog] Clear Call History List！！！")
                        application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmTip.qml',{themeColor: interfacemodel,textinfo: qsTr("此操作不会影响到手机通讯记录，\n确定要清除全部通话记录？"),texttitle:qsTr("清除通话记录"),pixelSizeinfo:system.language === 0 ? 36 : 30},dialogClearCallList);
                    }
                }

                UControls.NonAnimation_Text {
                    id: cleanLabel
                    anchors.centerIn: cleanButton
                    text: qsTr("清空")
                    font.pixelSize: 32
                    color: '#ffffff'
                }

                function dialogClearCallList(dialog){
                    console.debug("[calllog] open Clear Call history list dialog !!!");
                    currentDialog   = dialog
                    dialog.canceled.connect(function canceled(info){
                        console.debug("[calllog] cancel Clear Call History List dialog !!!");
                    });
                    dialog.confirmed.connect(function confirmed(info){
                        btctl.clearcontactsInfo(1)
                        rec1.sourceComponent = com1;
                        application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("清空通话记录成功"),autoCloseTimeout: 3000}, commonDialog);
                    });
                }
            }
        }

    }
}
