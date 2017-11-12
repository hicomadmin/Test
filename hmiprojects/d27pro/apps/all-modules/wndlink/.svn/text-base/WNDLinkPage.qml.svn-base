import TheXPresenter 1.0
//import Multimedia 1.0
import TheXDevice 1.0
import TheXCarlife 1.0
import TheXEcolink 1.0
import TheXSettings 1.0
import Bluetooth 1.0

import 'qrc:/UI/Core' as UCore
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import QtQuick 2.3
import TheXPresenter 1.0
import 'qrc:/UI/Core' as UCore
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls




ICore.Page {
    id:page

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property BtCtl btctl: HSPluginsManager.get('btctl')

    property int screenIDForController
    property int interfacemodel

    onDevctlChanged: {

    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    Grid {
        anchors.left:parent.left
        anchors.top:parent.top
        rows: 2
        columns: 5
        rowSpacing: 8
        columnSpacing: 7
        clip:false
        Repeater {
            id: repeater
            model: [
                {
                    //iconImage:"qrc:/resources-wndlink/CarLife.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-wndlink/CarLife.png":((interfacemodel === 1)? "qrc:/resources-wndlink/CarLife1.png":"qrc:/resources-wndlink/CarLife2.png"),
                    buttonName:qsTr("百度CarLife"),
                    appid:"carlife",
                    state: true
                },
                {
                    //iconImage:"qrc:/resources-wndlink/Ecolink.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-wndlink/Ecolink.png":((interfacemodel === 1)? "qrc:/resources-wndlink/Ecolink1.png":"qrc:/resources-wndlink/Ecolink2.png"),
                    buttonName:qsTr("乐视EcoLink"),
                    appid:"ecolink",
                    state: true
                },
                {
                    //iconImage:"qrc:/resources-wndlink/MirrorLink.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-wndlink/MirrorLink.png":((interfacemodel === 1)? "qrc:/resources-wndlink/MirrorLink1.png":"qrc:/resources-wndlink/MirrorLink2.png"),
                    buttonName:qsTr("MirrorLink"),
                    appid:"mirrorlink",
                    state: true
                },
                {
                    //iconImage:"qrc:/resources-wndlink/Ecolink.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-wndlink/WindLinkSetting.png":((interfacemodel === 1)? "qrc:/resources-wndlink/WindLinkSetting1.png":"qrc:/resources-wndlink/WindLinkSetting2.png"),
                    buttonName:qsTr("WindLink设置"),
                    appid:"wndlinksetting",
                    state: true
                },/*
                {
                    //iconImage:"qrc:/resources-wndlink/Ecolink.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-wndlink/Manual.png":((interfacemodel === 1)? "qrc:/resources-wndlink/Manual1.png":"qrc:/resources-wndlink/Manual2.png"),
                    buttonName:qsTr("帮助"),
                    appid:"wndlinkmanual",
                    state: true
                },*/
            ]

            IControls.BgImageButtonInstance {
                clip:false
                labelText: modelData.buttonName
                bgSource: modelData.iconImage
                disabled: !modelData.state
                themeColor: interfacemodel
                onClicked: {
                    console.debug("BgImageButtonInstance: appid =", modelData.appid, ", indexid = ", index)
                    //when page change ,ext: menu, wndlink
                        if(index === 3) {
                            application.changePage('wndlinksetting')
                        } else if(index === 4){
                            application.changePage('wndlinkmanual')
                        }
                        else {
                            if(modelData.appid === "carlife" ||
                                modelData.appid === "mirrorlink" )
                            {
                                 //btctl.plugin_musicPause();
                                 btctl.setAudioStreamMode(1);
                                 console.debug("[MBC] [close bt-audio]")
                            }
                            application.multiApplications.changeApplication(modelData.appid, {properties: {wndlinkFlag: true}});
                        }
                }
            }
        }
    }

}
