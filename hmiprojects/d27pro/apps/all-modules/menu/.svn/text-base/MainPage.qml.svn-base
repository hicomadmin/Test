import QtQuick 2.3
import TheXPresenter 1.0
import 'qrc:/UI/Core' as UCore
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls

import TheXSettings 1.0


ICore.Page {
    id:page

    property int screenIDForController

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel

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
                    //iconImage:"qrc:/resources-menu/Radio.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/Radio.png":((interfacemodel === 1)? "qrc:/resources-menu/Radio1.png":"qrc:/resources-menu/Radio2.png"),
                    buttonName:"收音机",
                    modulation:"AM",
                    appid:"radio",
                    state: true
                },
                {
                    //iconImage:"qrc:/resources-menu/Media.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/Media.png":((interfacemodel === 1)? "qrc:/resources-menu/Media1.png":"qrc:/resources-menu/Media2.png"),
                    buttonName:"多媒体",
                    appid:"media",
                    state: true
                },
                {
                    //iconImage:"qrc:/resources-menu/Phone.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/Phone.png":((interfacemodel === 1)? "qrc:/resources-menu/Phone1.png":"qrc:/resources-menu/Phone2.png"),
                    buttonName:"电话",
                    appid: 'hf',
                    state: true
                },
                {
                    //iconImage:"qrc:/resources-menu/Calendar.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/Calendar.png":((interfacemodel === 1)? "qrc:/resources-menu/Calendar1.png":"qrc:/resources-menu/Calendar2.png"),
                    buttonName:"日历",
                    appid:"calendar",
                    state:  true
                },
                {
                    //iconImage:"qrc:/resources-menu/Setting.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/Setting.png":((interfacemodel === 1)? "qrc:/resources-menu/Setting1.png":"qrc:/resources-menu/Setting2.png"),
                    buttonName:"设置",
                    appid:"settings",
                    state: true
                },/*
                {
                    //iconImage:"qrc:/resources-menu/CarLife.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/CarLife.png":((interfacemodel === 1)? "qrc:/resources-menu/CarLife1.png":"qrc:/resources-menu/CarLife2.png"),
                    buttonName:"百度CarLife",
                    appid:"carlife",
                    state: true
                },
                {
                    //iconImage:"qrc:/resources-menu/Ecolink.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/Ecolink.png":((interfacemodel === 1)? "qrc:/resources-menu/Ecolink1.png":"qrc:/resources-menu/Ecolink2.png"),
                    buttonName:"乐视ecolink",
                    appid:"ecolink",
                    state: true
                },*/
                {
                    //iconImage:"qrc:/resources-menu/Manual.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/WindLink.png":((interfacemodel === 1)? "qrc:/resources-menu/WindLink1.png":"qrc:/resources-menu/WindLink2.png"),
                    buttonName:"WindLink",
                    appid:"wndlink",
                    state: true
                },
                {
                    //iconImage:"qrc:/resources-menu/Manual.png",
                    iconImage: ( interfacemodel === 0)?"qrc:/resources-menu/Manual.png":((interfacemodel === 1)? "qrc:/resources-menu/Manual1.png":"qrc:/resources-menu/Manual2.png"),
                    buttonName:"东风手册",
                    appid:"manual",
                    state: true
                },
            ]
            IControls.BgImageButtonInstance {
                clip:false
                labelText: qsTr(modelData.buttonName) + ctranslator.monitor
                bgSource: modelData.iconImage
                disabled: !modelData.state
                themeColor: interfacemodel
                onClicked: {
                    if(index === 1) {
                        application.changePage(modelData.appid);
                    } else {
                        application.multiApplications.changeApplication(modelData.appid);
                    }
                }
            }
        }
    }
}

