import QtQuick 2.3
import QtQuick.Controls 1.2
import TheXUsbIfCer 1.0
import TheXDevice 1.0

import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls

ICore.Page {
    id: usbcer
    anchors.fill: parent

    property UsbIfCerCtl usbifcer: HSPluginsManager.get('usbifcer')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property bool usbMode: true

    property int devState: 0
    property int devType: 0

    property string tipValue: qsTr("Please plugin test device!")

    property var currentDialog: null
    property var dialogShow: false

    onDevctlChanged: {
        console.debug("UsbCer onDevctlChanged");
        devType =  Qt.binding(function (){return devctl.deviceInfo.devType});
        devState = Qt.binding(function (){return devctl.deviceInfo.devState});
    }

    onDevStateChanged: {
        console.debug("UsbCer onDevStateChanged devState: " + devState + "-->devType: " + devType);
        var devInfor = getDevInfor(devType);
        var devStateStr = qsTr("unknown");
        switch (devState) {
        case 0: //unknown
            break;
        case 1: //plugin
//            devStateStr = "plugin";
            break;
        case 2: //remove
//            devStateStr = "removed";
            break;
        case 3: //unsupport
            devStateStr = "unsupport";
            break;
        case 4: //No response
            devStateStr = "no response";
            break;
        default:
            break;
        }

        if (devState == 2) {
            tipValue = qsTr("Please plugin test device!");
        } else {
            if (devType == 6){
                tipValue = qsTr("The HUB is unsupport.");
            } else {
                if (devState == 3 || devState == 4) {
                    tipValue = qsTr("The ") + devInfor + qsTr(" device is ") + devStateStr + ".";
                }
            }
        }

        if (dialogShow) {
            showTipDialog();
        }
    }

    onDevTypeChanged: {
        console.debug("UsbCer onDevTypeChanged devType:" + devType);
        if (devType == 6) {
            tipValue = qsTr("The HUB is unsupport.");
        }
    }

    function getDevInfor(type) {
        var dev = qsTr("unknown");
        switch (type) {
        case 0:
            break;
        case 1:
            dev = qsTr("USB");
            break;
        case 2:
            dev = qsTr("IPOD");
            break;
        case 3:
            dev = qsTr("CarPlay");
            break;
        case 4:
            dev = qsTr("Android");
            break;
        case 5:
            dev = qsTr("iPhone");
            break;
        case 6:
            dev = qsTr("HUB");
            break;
        }
        return dev;
    }

    UControls.ColorButton {
        id: mode
        height: 90
        width: 300
        anchors.left: parent.left
        anchors.leftMargin: 400
        anchors.bottom: testJ.top
        anchors.bottomMargin: 50
        radius: 4
        normalColor: '#ffffff'
        pressingColor: '#105769'
        onClicked:  {
            usbMode = !usbMode
            modeTxt.text = usbMode ? (qsTr("USB HOST MODE")) : (qsTr("USB DEVICE MODE"))
            usbifcer.setUsbMode(usbMode)
        }
        IControls.NonAnimationText_FontRegular{
            anchors.centerIn: parent
            font.pixelSize: 25
            color: '#1a1c1d'
            text: qsTr("Usb Mode")
        }
    }

    Text {
        id: modeTxt
        anchors.left: mode.right
        anchors.leftMargin: 50
        anchors.verticalCenter: mode.verticalCenter
        text: qsTr("USB HOST MODE")
        color: '#ffffff'
        font.pixelSize: 28
    }

    UControls.ColorButton {
        id: testJ
        height: 80
        width: 180
        anchors.left: parent.left
        anchors.leftMargin: 220
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 310
        radius: 4
        normalColor: '#ffffff'
        pressingColor: '#105769'
        onClicked:  {
            usbifcer.setUsbTestJ()
        }
        IControls.NonAnimationText_FontRegular{
            anchors.centerIn: parent
            font.pixelSize: 25
            color: '#1a1c1d'
            text: qsTr("Test_J")
        }
    }

    UControls.ColorButton {
        id: testK
        height: 80
        width: 180
        anchors.left: testJ.right
        anchors.leftMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 310
        radius: 4
        normalColor: '#ffffff'
        pressingColor: '#105769'
        onClicked:  {
            usbifcer.setUsbTestK()
        }
        IControls.NonAnimationText_FontRegular{
            anchors.centerIn: parent
            font.pixelSize: 25
            color: '#1a1c1d'
            text: qsTr("Test_K")
        }
    }

    UControls.ColorButton {
        id: testSeoNak
        height: 80
        width: 180
        anchors.left: testK.right
        anchors.leftMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 310
        radius: 4
        normalColor: '#ffffff'
        pressingColor: '#105769'
        onClicked:  {
            usbifcer.setUsbTestSeoNak()
        }
        IControls.NonAnimationText_FontRegular{
            anchors.centerIn: parent
            font.pixelSize: 25
            color: '#1a1c1d'
            text: qsTr("Test_SEO_NAK")
        }
    }

    UControls.ColorButton {
        id: testPacket
        height: 80
        width: 180
        anchors.left: testSeoNak.right
        anchors.leftMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 310
        radius: 4
        normalColor: '#ffffff'
        pressingColor: '#105769'
        onClicked:  {
            usbifcer.setUsbTestPacket()
        }
        IControls.NonAnimationText_FontRegular{
            anchors.centerIn: parent
            font.pixelSize: 25
            color: '#1a1c1d'
            text: qsTr("Test_PACKET")
        }
    }

    UControls.ColorButton {
        id: testDut
        height: 80
        width: 180
        anchors.left: testJ.left
        anchors.top: testJ.bottom
        anchors.topMargin: 50
        radius: 4
        normalColor: '#ffffff'
        pressingColor: '#105769'
        onClicked:  {
            console.debug("test dut")
            showTipDialog();
        }
        IControls.NonAnimationText_FontRegular{
            anchors.centerIn: parent
            font.pixelSize: 25
            color: '#1a1c1d'
            text: qsTr("Test_DUT")
        }
    }

    function showTipDialog() {
        console.debug("UsbCer show tips: " + tipValue);
        /* modify usb mifi to home/application
        if (currentDialog !== null) {
            currentDialog.close();
        }
        dialogShow = true;
        application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml', {themeColor:0, clickClose:true, autoClose:false, text:tipValue}, commonDialog);
        */
    }

    function commonDialog(dialog) {
        currentDialog = dialog;
        dialog.onClosed.connect(function(){
            currentDialog = null;
            dialogShow = false;
        });
    }

    onVisibleChanged: {
        console.log("UsbCer onVisibleChanged visible = " + visible)
        if (!visible && currentDialog !== null) {
            currentDialog.close();
            currentDialog = null;
        }
        dialogShow = false;
    }
}
