import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQml.Models 2.2
import Bluetooth 1.0
import TheXSettings 1.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
import Apps 1.0

HSTab {
    id: root
    property bool isCopy: false;
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')

    property var contactsInfo
//    property int downProgress
    //    property int contactsDownloadState
//    property var downPhoneBookdialog
//    property var clearphonebookdialog

    property var currentDialog

    property int pairedDevCount;
    property int powerState;
    property int connectState;
    property int interfacemodel

    property var phonebooklistmodel: ListModel { id: listModel }

    property int contactsCount
    property int contactsDownloadState

    property bool isSync: false;

    onItemHiden: {
        console.log("[phonebook] onItemHiden!!!")
        item.enabled = false;
    }

    onVisibleChanged: {
        console.log("[phonebook] onVisibleChanged visible = " + visible)
        console.log("[phonebook] onVisibleChanged currentDialog = " + currentDialog)
//        for(var key in currentDialog) {
//            console.log("[phonebook] onVisibleChanged currentDialog["+key+"] = " + currentDialog[key])
//        }

        if(currentDialog) {
            if(!visible) {
                currentDialog.close()
            } else {
                console.log("[phonebook] downloadState = " + downloadState)
                currentDialog = undefined
//                currentDialog.visible = true //open()
            }
        }
    }

    onItemShown: {
        item.enabled = true;
        console.log('[phonebook] onItemShown!!!')
        console.log('[phonebook] onItemShown firstDownLoad=', btctl.firstDownLoad)
        console.debug('[phonebook] onItemShown contactsCount = ', btctl.contactsCount);

        switchShow()
        recLoader.visible = true
    }

    onBtctlChanged: {
        contactsInfo = Qt.binding(function (){return btctl.contactsInfo});

        contactsCount = Qt.binding(function (){return btctl.contactsCount});
        contactsDownloadState = Qt.binding(function (){return btctl.contactsDownloadState});

        powerState = Qt.binding(function (){return btctl.powerState});
        pairedDevCount = Qt.binding(function (){return btctl.pairedDevCount});
        connectState = Qt.binding(function (){return btctl.connectState});
        console.debug('[phonebook] onConnectChanged connect.powerState = ',btctl.powerState);

//        if(powerState === 2){
//            if((connectState&0xf0) !== 0x10 /*&& (connectState&0x0f) !== 0x01*/){
//                recLoader.sourceComponent = com3;
//            }else {
//                recLoader.sourceComponent = com1;
//            }
//        }

    }

    onSystemChanged: {
            interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

//    onContactsInfoChanged: {
//        console.debug('[phonebook] onContactsInfoChanged contactsInfo.length = ',contactsInfo.length);

//        if(contactsInfo) {
//            listModel.clear();
//            for (var i = 0; i < contactsInfo.length; i++) {
//                listModel.append(contactsInfo[i])
//            }
//            if((connectState&0xf0) === 0x10){
//                recLoader.sourceComponent = com2;
//            }
//        }
////        if(downPhoneBookdialog) {
////            downPhoneBookdialog.close();
////        }
//    }

    onContactsDownloadStateChanged: {
        //0: 未定义 1: 开始下载 2: 下载中 3: 下载完成 4: 取消下载 5: 下载失败
        console.debug('[phonebook] oonContactsDownloadStateChanged contactsDownloadState = ',contactsDownloadState);
        switch(contactsDownloadState) {
            case 1:
                break;
            case 2:
                if(currentDialog == undefined) {
                    application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("正在同步通讯录，请稍等…"),autoCloseTimeout: 120000}, commonDialog);
                }
                break;
            case 3:
                if(currentDialog) {
                    currentDialog.close();
                }
                if(isSync) {
                    application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("同步通讯录已完成"),autoCloseTimeout: 2000}, commonDialog);
                    isSync = false;
                }
                if(contactsCount > 0) {
                    recLoader.sourceComponent = com2;
                    btctl.getcontactsInfo(0,0);
                    recLoader.item.initComponent();
                }
                break;
            case 4:
                break;
            case 5:
                if(currentDialog) {
                    currentDialog.close();
                    application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("同步通讯录失败"),autoCloseTimeout: 3000 }, commonDialog);
                }
                break;
        }
    }

    onContactsCountChanged: {
        console.debug('[phonebook] page onContactsCountChanged contactsCount = ',contactsCount);
        if(contactsCount === 0) {
            listModel.clear();
        }
    }

    onPowerStateChanged: {
//        if(powerState === 2){
//            if((connectState&0xf0) !== 0x10/*&& (connectState&0x0f) !== 0x01*/){
//                recLoader.sourceComponent = com3;
//            }else {
//                recLoader.sourceComponent = com1;
//            }
//        }
        switchShow()
    }

    onConnectStateChanged: {
        switchShow()
    }

    Item{
        id: item
        anchors.fill: parent

        Loader{
            id:recLoader
            visible: false
            active:true
            anchors.fill: item;
//            sourceComponent: com1;
        }

        Component{
            id:com1;

            Item{
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
                    themeColor: interfacemodel;

                    onClicked: {
                        console.debug('[PhoneBook] com1 First Synchronize:downloadContacts(0)!!!');
                        isSync = true;
                        btctl.downloadContacts(0);
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
                    source: interfacemodel == 0 ? "qrc:/resources-hf/Phone_Icon_character.png":
                             (interfacemodel == 1 ? "qrc:/resources-hf/Phone_Icon-character.png":"qrc:/resources-hf/Phone_Icon_character_g.png")

                }

                UControls.NonAnimation_Text {
                    id: noPhoneLabel
                    anchors.horizontalCenter: noCallLogo.horizontalCenter
                    anchors.top: bgRec.top
                    anchors.topMargin: 299

                    text: qsTr("无联系人")
                    font.pixelSize: 32
                    color: '#ffffff'
                }
            }
        }

        Component{
            id:com2;

            Item{
                id: phoneRec
                anchors.fill: parent;

                function initComponent() {
                   phoneBookList.listView.listView.currentIndex = 0
//                   phoneBookList.listView.paginationLoaderDelegate.page = 1;
                   phoneBookList.listView.paginationLoaderDelegate.refreshed()
                }
                IControls.ListViewA {
                    id:phoneBookList
                    height: 500
                    anchors.left: parent.left
                    anchors.top: parent.top
                    navbarRightMargin: 75
                    model: phonebooklistmodel

                    delegate: IControls.ListItemDelegateB {
                        id: listDelegate
                        width: 1000
                        iconurl: interfacemodel == 0 ? "qrc:/resources-hf/Phone_Icon_ character.png":
                                 (interfacemodel == 1 ? "qrc:/resources-hf/Phone_Icon_-character.png":"qrc:/resources-hf/Phone_Icon_ character_g.png")

                        contactname: {
                            var itemName;

                            // 超长省略
                            if(name != ""){
                                    itemName = name;
                            }
                            else{
                                itemName = qsTr("未知");
                            }

                            itemName;

                            //listModel.get(index).name != "" ? listModel.get(index).name : qsTr("未知");
                        }
                        //contactname: qsTr("未知");//listModel.get(index).name != "" ? listModel.get(index).name : qsTr("未知");
                        contactnum: listModel.get(index).number;
                        themeColor: interfacemodel;
                        onClicked: {
                            btctl.phoneCallTask(listModel.get(index).number);
                            console.debug("[phonebook] call number:",listModel.get(index).number);
                        }
                    }
                    listView.usePaginationLoader: true;
                    listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {

                        function loadPageAsync(page, cb) {
                            btctl.contactsInfoChanged.connect(function handler(contactsInfo){
                                btctl.contactsInfoChanged.disconnect(handler);
                                cb(null, contactsInfo) ;
                            });
                            btctl.getcontactsInfo(page - 1, 0);
                        }

                    }
                }

                IControls.RoundLabButtonA {
                    id: sysButton
                    anchors.left: parent.left
                    anchors.leftMargin: 77
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    themeColor: interfacemodel
                    width: 273
                    height: 104

                    onClicked: {
//                        console.debug('[PhoneBook] Second Synchronize:getcontactsInfo(0,0)!!!');
//                        btctl.getcontactsInfo(0,0);
//                        application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("正在同步通讯录，请稍等…"),autoCloseTimeout: 30000},dialogDownPhoneBook);
//                        btctl.clearcontactsInfo(0)
                        isSync = true
                        btctl.downloadContacts(0);
                    }
                }

                UControls.NonAnimation_Text {
                    anchors.centerIn: sysButton
                    font.pixelSize: 32
                    text: qsTr('同步')
                    color: '#ffffff'
                }

                IControls.RoundLabButtonA {
                    id: searchButton
                    anchors.left: sysButton.right
                    anchors.leftMargin: 27
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 273
                    height: 104
                    themeColor: interfacemodel;
                    onClicked: {
                        btctl.clearMatchList();
                        application.changePage("keyboardpage");
                    }
                }

                UControls.NonAnimation_Text {
                    anchors.centerIn: searchButton
                    font.pixelSize: 32
                    text: qsTr('搜索')
                    color: '#ffffff'
                }

                IControls.RoundLabButtonA {
                    id: deleteButton
                    anchors.left: searchButton.right
                    anchors.leftMargin: 27
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    width: 273
                    height: 104
                    themeColor: interfacemodel;
                    onClicked: {
                        application.createTipDialogAsync('qrc:/Instances/Controls/DialogConfirmTip.qml',{themeColor: interfacemodel,textinfo: qsTr("此操作不会影响到手机通讯录，\n确定要清除通讯录？"),texttitle:qsTr("清除通讯录"),pixelSizeinfo:system.language === 0 ? 36 : 30},dialogclearphonebook);
                    }
                }

                UControls.NonAnimation_Text {
                    anchors.centerIn: deleteButton
                    font.pixelSize: 32
                    text: qsTr('清空')
                    color: '#ffffff'
                }

            }

        }

//        Component{
//            id:com3;
//            Item {
//                id: noConnectRec
//                anchors.fill: parent;

//                Image {
//                    id: noConnectIcon
//                    height: 123
//                    width: 124
//                    anchors.left: noConnectRec.left
//                    anchors.leftMargin: 474
//                    anchors.top: noConnectRec.top
//                    anchors.topMargin: 289-92
//                    source: "qrc:/resources-hf/Phone_Icon_No record.png";

//                }

//                UControls.NonAnimation_Text {
//                    id: noConnectLabel
//                    anchors.horizontalCenter: noConnectIcon.horizontalCenter
//                    anchors.top: noConnectIcon.bottom
//                    anchors.topMargin: 21

//                    text: qsTr("未连接手机，请在蓝牙连接页签中连接手机")
//                    font.pixelSize: 32
//                    color: '#ffffff'
//                }

//            }
//        }
    }

    function commonDialog(dialog){
        console.debug("[phonebook] commonDialog !!!");
        currentDialog = dialog;
        console.debug("[phonebook] currentDialog[text]" , currentDialog['text']);
    }

    function dialogclearphonebook(dialog){
        console.debug("[Phonebook] dialogclearphonebook!!!");

        currentDialog = dialog

        dialog.canceled.connect(function canceled(info){
        });
        dialog.confirmed.connect(function confirmed(info){
            btctl.clearcontactsInfo(0)
            recLoader.sourceComponent = com1;
            application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("清空联系人成功"),autoCloseTimeout: 3000}, commonDialog);
        });
    }

    //切换界面显示
    function switchShow() {
        if(powerState === 2) {
            if(((btctl.connectState)&0xf0) === 0x10){
                if(contactsCount > 0) {
                    recLoader.sourceComponent = com2;
                    btctl.getcontactsInfo(0,0);
                    recLoader.item.initComponent();
                } else {
                    recLoader.sourceComponent = com1;
                }
            } else {
                listModel.clear();
                //to do switch page  dialnumber
                recLoader.sourceComponent = com1;
            }
        } else {
            listModel.clear();
            btctl.clearcontactsInfo(0)
            recLoader.sourceComponent = com1;
            // to do switch page btconnected
        }
    }
}

