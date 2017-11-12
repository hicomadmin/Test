import QtQuick 2.3
import 'qrc:/UI/Core' as UCore
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    id:page

    Grid {
        anchors.left:parent.left
        anchors.leftMargin: 100 - 12
        anchors.top:parent.top
        anchors.topMargin: 37
        rows: 2
        columns: 4
        rowSpacing: 20
        columnSpacing: 30
        clip:false
        Repeater {
            id: repeater
            model: [
                {
                    iconImage:"qrc:/resources-home/Radio.png",
                    buttonName:QT_TR_NOOP("收音机"),
                    modulation:"AM",
                    appid:"radio",
                    state: true
                },
                {
                    iconImage:"qrc:/resources-home/Meida.png",
                    buttonName:QT_TR_NOOP("多媒体"),
                    appid:"home",
                    state: true
                },
                {
                    iconImage:"qrc:/resources-home/Phone.png",
                    buttonName:QT_TR_NOOP("电话"),
                    appid: hf,
                    state: true
                },
                {
                    iconImage:"qrc:/resources-home/Calendar.png",
                    buttonName:QT_TR_NOOP("日历"),
                    appid:"calendar",
                    state:  true
                },
                {
                    iconImage:"qrc:/resources-home/Setting.png",
                    buttonName:QT_TR_NOOP("设置"),
                    appid:"settings",
                    state: page.auxState
                },
                {
                    iconImage:"qrc:/resources-home/CarLife.png",
                    buttonName:QT_TR_NOOP("百度CarLife"),
                    appid:"carlife",
                    state: true
                },
                {
                    iconImage:"qrc:/resources-home/Ecolink.png",
                    buttonName:QT_TR_NOOP("乐视ecolink"),
                    appid:"leecolink",
                    state: true
                },
                {
                    iconImage:"qrc:/resources-home/Manual.png",
                    buttonName:QT_TR_NOOP("东风手册"),
                    appid:"manual",
                    state: true
                },
            ]
            IControls.BgImageButtonInstance {
                clip:false
                //SOHO  ANDY    2016.03.16
//                visible: !hmiCtl.powerOffStatus
                labelText: modelData.buttonName
                bgSource: modelData.iconImage
                disabled: !modelData.state
                onClicked: {
                    application.multiApplications.changeApplication(modelData.appid);
//                    switch(modelData.appid)
//                    {
//                    case 'usb':
//                        screenIDForController = HmiCommonCtl.ScreenUSBMP3
//                        break
//                    case 'ipod':
//                        screenIDForController = HmiCommonCtl.ScreenIPOD
//                        break
//                    case  'bt':
//                        screenIDForController = HmiCommonCtl.ScreenBTA
//                        break
//                    case 'aux':
//                        screenIDForController = HmiCommonCtl.ScreenAUX
//                        break
//                    case 'radio' :
//                        if( modelData.modulation === 'AM') {
//                            radio.start(0)
//                            screenIDForController = HmiCommonCtl.ScreenRadioAM
//                        } else {
//                            radio.start(1)
//                            screenIDForController = HmiCommonCtl.ScreenRadioFM
//                        }
//                        break
//                    default:
//                        application.multiApplications.changeApplication(modelData.appid);
//                        return
//                        }
//                    if(hmiCtl.getCurrentSourceStatus() === screenIDForController) {
//                        if (modelData.appid === 'ipod') {
//                            if(ipodState === 0 && existSongs == true) {
//                                application.multiApplications.changeApplication(modelData.appid,{properties: {initialPage: 'main'},needUpdate: true});
//                            } else {
//                                application.multiApplications.changeApplication(modelData.appid,{properties: {initialPage: 'ipodstate'},needUpdate: true});
//                            }
//                        } else {
//                            application.multiApplications.changeApplication(modelData.appid,{properties: {amFm: modelData.modulation}});
//                        }
//                    } else {
//                        hmiCtl.requireAudioSourceON(screenIDForController);
//                    }
                }
            }
        }
    }
}
