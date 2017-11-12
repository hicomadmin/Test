import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import TheXSettings 1.0
import TheXDevice 1.0
import TheXEcolink 1.0
import TheXPresenter 1.0

ICore.Page {
    id: mainPage
    property SystemCtl system: HSPluginsManager.get('system')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property EcolinkCtl ecolink: HSPluginsManager.get('ecolink')
    property bool hasinit : false

    property int interfacemodel
    property real mobileState

    property int devState;
    property int devType;
    property int whereWeGo : 0

    property int d_MENU_ID_CARLIFE:1;
    property int d_MENU_ID_ECOLINK:2;
    property int d_MENU_ID_MIRRORLINK:3;
    property int d_DEVICE_USB_PLUG_OUT:2;
    property int d_DEVICE_USB_PLUG_IN:1;

    property int d_MOBILE_PROCESS_CARLIFE :       1;
    property int d_MOBILE_PROCESS_ECOLINK :       2;
    property int d_MOBILE_PROCESS_MIRRORLINK :    3;
    property int d_MOBILE_PROCESS_ADB :           4;

    property int tmpid:0

    onSystemChanged: {
        //system.getAllInfo()
        mobileState = Qt.binding(function(){return system.mobileState})
        interfacemodel = Qt.binding(function(){return system.interfacemodel})

        console.debug("<----------Mobile Setting> onSystemChanged",mobileState,system.updataMobileState())
        hasinit = true
    }

    onDevctlChanged: {
        devState = Qt.binding(function (){return devctl.devstate});
        devType =  Qt.binding(function (){return devctl.devtype});
    }

    onMobileStateChanged: {
        console.debug("<----------Mobile Setting> onMobileStateChanged",mobileState,system.updataMobileState())
    }


    function dialogConfirmTip(dialog){
        dialog.confirmed.connect(function confirmed(){
            console.debug("DUMP dialogConfirmTip:CONFIRM");
            if(whereWeGo === d_MOBILE_PROCESS_CARLIFE){
                devctl.killMobileProcess(d_MOBILE_PROCESS_ECOLINK)
                devctl.killMobileProcess(d_MOBILE_PROCESS_MIRRORLINK)
                console.debug("**********************goto Carlife***********************************");
                application.multiApplications.changeApplication('carlife')
            }else if(whereWeGo === d_MOBILE_PROCESS_ECOLINK){
                console.debug("**********************goto Ecolink***********************************");
                //devctl.killMobileProcess(d_MOBILE_PROCESS_CARLIFE)
                devctl.killMobileProcess(d_MOBILE_PROCESS_MIRRORLINK)
                application.multiApplications.changeApplication('ecolink')
            }else if(whereWeGo === d_MOBILE_PROCESS_MIRRORLINK){
                console.debug("**********************goto Mirrorlink***********************************");
                //devctl.killMobileProcess(d_MOBILE_PROCESS_CARLIFE)
                devctl.killMobileProcess(d_MOBILE_PROCESS_ECOLINK)
                application.multiApplications.changeApplication('mirrorlink')
            }
            system.setMobileState(tmpid)
        });

        dialog.canceled.connect(function canceled(){
            console.debug("DUMP dialogCancelTip:CANCEL re.itemAt(0)=",re.itemAt(mobileState).text);
            re.itemAt(mobileState).checked = true
        });
    }


    Image {
        id: bg
        source: (interfacemodel === 0)?"qrc:/resources-wndlink/BgSetting.png":((interfacemodel === 1)? "qrc:/resources-wndlink/BgSetting1.png":"qrc:/resources-wndlink/BgSetting2.png")
        //source: interfacemodel == 0?"qrc:/resources-settings/set_BJ_03.png":"qrc:/resources-settings/set_BJ_03_o.png"
        Grid{
            id:gd
            anchors.left: bg.left
            anchors.top: bg.top
            rows: 2
            columns: 2
            rowSpacing: 0.1
            ExclusiveGroup{
                id: settings
            }

            Repeater{
                id:re
                model: [qsTr("None"),qsTr("Carlife"),qsTr("Ecolink"),qsTr("Mirrorlink")]

                IControls.RadioButtonCell{
                    id:rbc
                    text: qsTr(modelData)
                    checked: index == mobileState ? true:false
                    exclusiveGroup: settings
                    themeColor: interfacemodel
                    onCheckedChanged: {
                        if(checked && hasinit){
                            console.debug("<DUMP> 1. system.updataMobileState()     = ",system.updataMobileState()," mobileState=",mobileState);
                            tmpid = index
                            if(index === d_MENU_ID_CARLIFE){
                                whereWeGo = d_MOBILE_PROCESS_CARLIFE;
                                console.debug("Ecolink Is Running <'> = Running'> :",devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_ECOLINK));
                                if( devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_ECOLINK) === 1){
                                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,/*texttitle:qsTr('Switch To Carlife'),*/textinfo:qsTr('当前车机EcoLink已经建立连接，是否切换为CarLife?'),autoClose:false,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
                                }else if(devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_MIRRORLINK) === 1){
                                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,/*texttitle:qsTr('Switch To Carlife'),*/textinfo:qsTr('当前车机MirrorLink已经建立连接，是否切换为CarLife?'),autoClose:false,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
                                }else{
                                    system.setMobileState(index)
                                }
                            }else if(index === d_MENU_ID_ECOLINK){
                                whereWeGo = d_MOBILE_PROCESS_ECOLINK;
                                console.debug("Carlife Is Running <'> = Running'> :",devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_CARLIFE));
                                if( devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_CARLIFE) === 1){
                                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,/*texttitle:qsTr('Switch To Ecolink'),*/textinfo:qsTr('当前车机CarLife已经建立连接，是否切换为EcoLink?'),autoClose:false,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
                                }else if(devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_MIRRORLINK) === 1){
                                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,/*texttitle:qsTr('Switch To Carlife'),*/textinfo:qsTr('当前车机MirrorLink已经建立连接，是否切换为EcoLink?'),autoClose:false,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
                                }else{
                                    system.setMobileState(index)
                                }
                            }else if(index === d_MENU_ID_MIRRORLINK){
                                whereWeGo = d_MOBILE_PROCESS_ECOLINK;
                                console.debug("Carlife Is Running <'> = Running'> :",devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_CARLIFE));
                                if( devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_CARLIFE) === 1){
                                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,/*texttitle:qsTr('Switch To Ecolink'),*/textinfo:qsTr('当前车机CarLife已经建立连接，是否切换为MirrorLink?'),autoClose:false,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
                                }else if( devctl.checkMobileProcessAlive(d_MOBILE_PROCESS_ECOLINK) === 1){
                                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmMobile.qml',{themeColor: interfacemodel,/*texttitle:qsTr('Switch To Carlife'),*/textinfo:qsTr('当前车机EcoLink已经建立连接，是否切换为MirrorLink?'),autoClose:false,pixelSizeinfo:system.language === 0 ? 36 : 30},dialogConfirmTip)
                                }else{
                                    system.setMobileState(index)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
