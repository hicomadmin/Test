import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
//import  Multimedia 1.0
import TheXDevice 1.0
import TheXSettings 1.0

ICore.Page {
    id: usbstatePage

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property var dialogProgress: null
    property int interfacemodel

    property var deviceInfo
    property var mediaInfo
    property var mediaScanState
    property var devState
    property var devType
    property var mediaMusic


    onDevctlChanged: {
        deviceInfo =  Qt.binding(function (){return devctl.deviceInfo});
        mediaInfo =  Qt.binding(function (){return devctl.mediaInfo});
    }
    onDeviceInfoChanged: {
        devState = Qt.binding(function (){return deviceInfo.devState});
        devType = Qt.binding(function (){return deviceInfo.devType});
    }
    onMediaInfoChanged: {
        mediaMusic =  Qt.binding(function (){return mediaInfo.mediaMusic});
        mediaScanState =  Qt.binding(function (){return mediaInfo.mediaScanState});
    }


    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
        console.debug("usbStateDialog interfacemodel:" + interfacemodel)
    }

    onItemShowing: {
        console.debug("onItemShowing mediaScanState:",mediaScanState)
        autocloser.start()
        application.createProgressDialogAsync('qrc:/Instances/Controls/DialogProgress.qml',{themeColor:interfacemodel,text: qsTr("正在扫描文件..."),autoClose:false},callBackDialog);

//        if(mediaScanState === Constant._USB_SCAN_START || mediaScanState === Constant._USB_SCAN_RUN) {
//            application.createProgressDialogAsync('qrc:/Instances/Controls/DialogProgress.qml',{themeColor:interfacemodel,text: qsTr("正在扫描文件..."),autoClose:false},callBackDialog);
//        } else {
//            changePage()
//        }
    }

    function callBackDialog(dialog){
        closeDialog()
        dialogProgress = dialog
        if (!(autocloser.running)) {
            closeDialog()
        }
    }

    Rectangle {
        id: usbfial
        visible: false
        anchors.fill: parent

        Rectangle {//整个窗口背景
            color: "#000000";
            opacity: 0.85
            anchors.fill: parent
        }

        Rectangle { //弹出框
            id: contentBg;
            width: 732
            height: 258
            color: interfacemodel == 0 ? "#103c4b":(interfacemodel == 1 ?"#480E05":"#986142");
            opacity: 0.9;
            anchors.centerIn: parent
            UControls.Label{
                id: info;
                anchors.topMargin: 44;
                anchors.centerIn: parent
                color: "#FFFFFF";
                font.pixelSize: 32;
                text: qsTr("无法识别此设备");
            }
        }
    }


    onItemHiden: {
        console.debug("usbStateDialog onQuit")
        stopTimer();
    }

    function closeDialog() {
        if(dialogProgress){
            dialogProgress.close()
            dialogProgress = null
        }
    }

    function stopTimer() {
        if(autocloser.running) {
            autocloser.stop()
        }
    }

    function changePage() {
        if(devState === Constant._DEVICE_STATE_INSERT && devType === Constant._DEVICE_TYPE_UDISK) {
            application.changePage(mediaMusic > 0 ? 'music_playing' : 'music_main', {replace: true})
        } else {
            usbfial.visible = true
        }
    }

    Timer{
        id:autocloser
        interval: 1000
        repeat: true

        onTriggered: {
            console.debug("Timer devState:" + devState + " mediaScanState:" + mediaScanState + " mediaMusic:" + mediaMusic + " dialogProgress:" + dialogProgress)
            if(devState !== Constant._DEVICE_STATE_INSERT || devType !== Constant._DEVICE_TYPE_UDISK || mediaScanState !== Constant._USB_SCAN_START && mediaScanState !== Constant._USB_SCAN_RUN || mediaMusic > 0) {
                stopTimer();
                changePage()
            }
        }

        onRunningChanged: {
            if (autocloser.running === false) {
                closeDialog()
            }
        }
    }
}

