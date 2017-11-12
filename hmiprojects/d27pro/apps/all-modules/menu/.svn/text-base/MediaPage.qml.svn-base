import QtQuick 2.0
import TheXPresenter 1.0
//import Multimedia 1.0
import TheXDevice 1.0
import TheXAux 1.0
import Bluetooth 1.0
import TheXSettings 1.0

import 'qrc:/UI/Core' as UCore
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant

ICore.Page {
    id:page

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property AUXCtl aux: HSPluginsManager.get('aux')
    property SystemCtl system: HSPluginsManager.get('system')

    property int usbState;
    property int btstate
    property bool auxReady
    property int screenIDForController
    property int interfacemodel
    property var deviceInfo : devctl ? devctl.deviceInfo : null;
    property var devState : deviceInfo ? deviceInfo.devState : 0;
    property var devType: deviceInfo ? deviceInfo.devType : 0
    property var mediaInfo : devctl ? devctl.mediaInfo : null;
    property var mediaScanState: mediaInfo ? mediaInfo.mediaScanState : 0

    onItemShown: {
        console.debug("MediaPage devState:" + devState + " devType:" + devType + " mediaScanState:" + mediaScanState)
    }

    onBtctlChanged: {
        btstate = Qt.binding(function (){return btctl.connectState});
    }

    onAuxChanged: {
        auxReady = Qt.binding(function (){return aux.auxReady})
    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }


    Row {
        anchors.top: parent.top;
        anchors.topMargin: 150;
        anchors.left: parent.left;
        anchors.leftMargin: 180;
        spacing: 250;
        clip:false
        Repeater {
            id: repeater
            model: [
                {
                    normalSource:"qrc:/resources-menu/Media_Icon_USB_nml.png",
                    disableSource:"qrc:/resources-menu/Media_Icon_USB_dis.png",
                    buttonName:"USB",
                    appid:"usb",
                    state: devState === Constant._DEVICE_STATE_INSERT && devType === Constant._DEVICE_TYPE_UDISK  /*&& mediaScanState === Constant._USB_SCAN_STOP*/ ? false : true
                },
                {
                    normalSource:"qrc:/resources-menu/Media_Icon_BTmusic_nml.png",
                    disableSource:"qrc:/resources-menu/Media_Icon_BTmusic_dis.png",
                    buttonName:"蓝牙音乐",
                    appid:"btaudio",
                    state: (btstate&0x01) === 0x01 ? false : true  //btstate
                },
                {
                    normalSource:"qrc:/resources-menu/Media_Icon_AUX_nml.png",
                    disableSource:"qrc:/resources-menu/Media_Icon_AUX_dis.png",
                    buttonName:"AUX",
                    appid: 'aux',
                    state: auxReady === false ? true : false
                },
            ]

            Item{
                height: 100;
                width: 100;
                IControls.ImageButton {
                    id: btn;
                    height: 243;
                    width: 244;
                    clip:false;
                    disabled: modelData.state;
                    iconnormalSource: modelData.normalSource;
                    icondisabledSource: modelData.disableSource;
                    themeColor: interfacemodel
                    onClicked: {
                        if (modelData.appid === 'usb') {
                            application.multiApplications.changeApplication(modelData.appid, {properties: {initialPage: 'music_main'}});
                        }
                        else {
                            application.multiApplications.changeApplication(modelData.appid);
                        }
                    }
                }

                IControls.NonAnimationText_FontLight{
                    anchors.top: btn.bottom;
                    anchors.topMargin: 62;
                    anchors.horizontalCenter: btn.horizontalCenter;
                    text: qsTr(modelData.buttonName) + ctranslator.monitor;
                    color: modelData.state ? '#3F4244' : '#FFFFFF';
                    font.pixelSize: 32;
                }
           }
        }
    }
}
