import QtQuick 2.3
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/Core' as UCore
import TheXPresenter 1.0

Private.Control {
    id: root
    width: parent.width
    height: 80

    property var multiApplications: null
    property int screenIDForController

    Component.onCompleted: {
        ctranslator.languageChanged.connect(function (){
            if (_language === "en_US") {
                repeater.model = [
                            {
                                normal:'qrc:/resources/Common_Icon_AM_nml.png',
                                disable:'qrc:/resources/Common_Icon_AM_dis.png',
                                pressing:'qrc:/resources/Common_Icon_AM_exe.png',
                                focus:'qrc:/resources/Common_Icon_AM_dec.png.png',
                                appid:"radio",
                                modulation:"am",
                                text:'AM'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_FM_nml.png',
                                disable:'qrc:/resources/Common_Icon_FM_dis.png',
                                pressing:'qrc:/resources/Common_Icon_FM_exe.png',
                                focus:'qrc:/resources/Common_Icon_FM_dec.png.png',
                                appid:"radio",
                                modulation:"fm",
                                text:'FM'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_AUX_nml.png',
                                disable:'qrc:/resources/Common_Icon_AUX_dis.png',
                                pressing:'qrc:/resources/Common_Icon_AUX_exe.png',
                                focus:'qrc:/resources/Common_Icon_AUX_dec.png',
                                appid:"aux",
                                text:'AUX'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_USB_nml.png',
                                disable:'qrc:/resources/Common_Icon_USB_dis.png',
                                pressing:'qrc:/resources/Common_Icon_USB_exe.png',
                                focus:'qrc:/resources/Common_Icon_USB_dec.png',
                                appid:"usb",
                                text:'USB/iPod'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_BT Audio_nml.png',
                                disable:'qrc:/resources/Common_Icon_BT Audio_dis.png',
                                pressing:'qrc:/resources/Common_Icon_BT Audio_exe.png',
                                focus:'qrc:/resources/Common_Icon_BT Audio_dec.png',
                                appid:"bt",
                                text:'BTA'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_Set_nml.png',
                                disable:'qrc:/resources/Common_Icon_Set_dis.png',
                                pressing:'qrc:/resources/Common_Icon_Set_exe.png',
                                focus:'qrc:/resources/Common_Icon_Set_dec.png',
                                appid:"settings",
                                text:'Settings'
                            },
                        ]
            } else {
                repeater.model = [
                            {
                                normal:'qrc:/resources/Common_Icon_AM_nml.png',
                                disable:'qrc:/resources/Common_Icon_AM_dis.png',
                                pressing:'qrc:/resources/Common_Icon_AM_exe.png',
                                focus:'qrc:/resources/Common_Icon_AM_dec.png.png',
                                appid:"radio",
                                modulation:"am",
                                text:'AM'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_FM_nml.png',
                                disable:'qrc:/resources/Common_Icon_FM_dis.png',
                                pressing:'qrc:/resources/Common_Icon_FM_exe.png',
                                focus:'qrc:/resources/Common_Icon_FM_dec.png.png',
                                appid:"radio",
                                modulation:"fm",
                                text:'FM'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_AUX_nml.png',
                                disable:'qrc:/resources/Common_Icon_AUX_dis.png',
                                pressing:'qrc:/resources/Common_Icon_AUX_exe.png',
                                focus:'qrc:/resources/Common_Icon_AUX_dec.png',
                                appid:"aux",
                                text:'AUX'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_USB_nml.png',
                                disable:'qrc:/resources/Common_Icon_USB_dis.png',
                                pressing:'qrc:/resources/Common_Icon_USB_exe.png',
                                focus:'qrc:/resources/Common_Icon_USB_dec.png',
                                appid:"usb",
                                text:'USB/iPod'
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_BT Audio_nml.png',
                                disable:'qrc:/resources/Common_Icon_BT Audio_dis.png',
                                pressing:'qrc:/resources/Common_Icon_BT Audio_exe.png',
                                focus:'qrc:/resources/Common_Icon_BT Audio_dec.png',
                                appid:"bt",
                                text:qsTr('蓝牙音响')
                            },
                            {
                                normal:'qrc:/resources/Common_Icon_Set_nml.png',
                                disable:'qrc:/resources/Common_Icon_Set_dis.png',
                                pressing:'qrc:/resources/Common_Icon_Set_exe.png',
                                focus:'qrc:/resources/Common_Icon_Set_dec.png',
                                appid:"settings",
                                text:qsTr('设置')
                            },
                        ]
            }
        })
    }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: '#000000'
        Row {
            anchors.left: parent.left
            anchors.leftMargin: 1
            Repeater {
                id: repeater
                model: [
                    {
                        normal:'qrc:/resources/Common_Icon_AM_nml.png',
                        disable:'qrc:/resources/Common_Icon_AM_dis.png',
                        pressing:'qrc:/resources/Common_Icon_AM_exe.png',
                        focus:'qrc:/resources/Common_Icon_AM_dec.png.png',
                        appid:"radio",
                        modulation:"am",
                        text:'AM'
                    },
                    {
                        normal:'qrc:/resources/Common_Icon_FM_nml.png',
                        disable:'qrc:/resources/Common_Icon_FM_dis.png',
                        pressing:'qrc:/resources/Common_Icon_FM_exe.png',
                        focus:'qrc:/resources/Common_Icon_FM_dec.png.png',
                        appid:"radio",
                        modulation:"fm",
                        text:'FM'
                    },
                    {
                        normal:'qrc:/resources/Common_Icon_AUX_nml.png',
                        disable:'qrc:/resources/Common_Icon_AUX_dis.png',
                        pressing:'qrc:/resources/Common_Icon_AUX_exe.png',
                        focus:'qrc:/resources/Common_Icon_AUX_dec.png',
                        appid:"aux",
                        text:'AUX'
                    },
                    {
                        normal:'qrc:/resources/Common_Icon_USB_nml.png',
                        disable:'qrc:/resources/Common_Icon_USB_dis.png',
                        pressing:'qrc:/resources/Common_Icon_USB_exe.png',
                        focus:'qrc:/resources/Common_Icon_USB_dec.png',
                        appid:"usb",
                        text:'USB/iPod'
                    },
                    {
                        normal:'qrc:/resources/Common_Icon_BT Audio_nml.png',
                        disable:'qrc:/resources/Common_Icon_BT Audio_dis.png',
                        pressing:'qrc:/resources/Common_Icon_BT Audio_exe.png',
                        focus:'qrc:/resources/Common_Icon_BT Audio_dec.png',
                        appid:"bt",
                        text:qsTr('蓝牙音响')
                    },
                    {
                        normal:'qrc:/resources/Common_Icon_Set_nml.png',
                        disable:'qrc:/resources/Common_Icon_Set_dis.png',
                        pressing:'qrc:/resources/Common_Icon_Set_exe.png',
                        focus:'qrc:/resources/Common_Icon_Set_dec.png',
                        appid:"settings",
                        text:qsTr('设置')
                    },
                ]
                UControls.IconButton {
                    id: button
                    width: 133
                    height: 80
                    UControls.ButtonStateImage {
                        state: button.state
                        normalSource: modelData.normal
                        pressingSource: modelData.pressing
                        focusingSource: modelData.focus
                    }
                    bgSourceComponent:Component {
                        UControls.ButtonStateImage {
                            state: button.state
                            pressingSource: "qrc:/resources/Common_Icon_Home_foc.png"
                            focusingSource: "qrc:/resources/Common_Icon_Home_foc.png"
                        }
                    }
                    UControls.Label {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr(modelData.text)
                        font.pixelSize: 24
                        color: button.state === 'normal' ? '#AAAFBE' : (button.state === 'pressing'
                                                                      ? '#FF8F1C' : (button.state === 'disable'
                                                                                    ? '#717418' : '#FFFFFF'))
                    }
                    onClicked: {
//                        changeApplication(modelData.appid,{properties: {amFm: modelData.modulation}});
                        //AudioControllerModify   Andy    2016.03.13

                        switch(modelData.appid)
                        {
                        case 'usb':
                            screenIDForController = HmiCommon.SourceUSBMP3
                            break
                        case 'ipod':
                            screenIDForController = HmiCommon.SourceIPOD
                            break
                        case  'bt':
                            screenIDForController = HmiCommon.SourceBTA
                            break
    //                    case 'hf':
    //                        screenIDForController = HmiCommon.SourceHF
    //                        break
                        case 'aux':
                            screenIDForController = HmiCommon.SourceAUX
                            break
                        case 'radio' :
                            if( modelData.modulation === 'am')
                            {
                                screenIDForController = HmiCommon.SourceRadioAM
                            }
                            else
                            {
                                screenIDForController = HmiCommon.SourceRadioFM
                            }
                            break
                        default:
                            multiApplications.changeApplication(modelData.appid);
                            return
                            }


                        if(HmiCommon.getCurrentSourceStatus() === screenIDForController)
                        {
                            multiApplications.changeApplication(modelData.appid,{properties: {amFm: modelData.modulation}});

                        }
                        else
                        {
                            HmiCommon.requireAudioSourceON(screenIDForController)
                        }
                        //AudioControllerModify   Andy    2016.03.13
                    }
                }
            }
        }
    }
    // TODO
}
