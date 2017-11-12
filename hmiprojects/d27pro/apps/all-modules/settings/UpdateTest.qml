import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls

import TheXSettings 1.0


ICore.Page {
    id: updatePage
    property SystemCtl system: HSPluginsManager.get('system')
    property bool restartflag: false
    property bool powerflag: false
    property bool updateflag: false

    property real maximumValue: 20
    property real minimumValue: 0
    property real value: 0

    property alias background: background
    property alias progress: progress

    property int coreUpdataState
    property var updataInfo
    property bool textflag: true
    property bool mcuupdataflag
    property int mcuUpdataState

    //coreUpdataState: 1,开始；2，升级中；3，完成

    onSystemChanged: {
        coreUpdataState  = Qt.binding(function (){return system.coreUpdataState });
        updataInfo  = Qt.binding(function (){return system.updataInfo });
        mcuupdataflag  = Qt.binding(function (){return system.mcuupdataflag });
        mcuUpdataState  = Qt.binding(function (){return system.mcuUpdataState });

        if(system.mcuupdataflag === true){
            statusText.text = qsTr("再次点击【电源管理】，完成电源管理程序升级！");
            restartButton.disabled = true;
            updateButton.disabled = true;
        }
    }

    onCoreUpdataStateChanged: {
        if(coreUpdataState === 3){
            statusText.text = qsTr("应用程序升级完成！");
            powerflag = false;
            value = maximumValue;
            updateTime.stop();
            restartButton.disabled = false;
            powerButton.disabled = false;
            system.restartCore();
        }

    }

    onMcuUpdataStateChanged: {
        if(mcuUpdataState === 1){
            updateflag = false;
            statusText.text = qsTr("电源管理程序正在升级...");
//            updateTime.start();

        }else if(mcuUpdataState === 3){
            updateflag = false;
//            statusText.text =  qsTr("电源管理程序升级完成！");
            value = maximumValue;
            updateTime.stop();
            restartButton.disabled = false;
            updateButton.disabled = false;
        }
    }


    Image {
        id: bg
        source: "qrc:/resources-settings/BG.png"
        anchors.fill: parent
    }

    UControls.NonAnimation_Text {
        id: statusText
        anchors.horizontalCenter: updatePage.horizontalCenter;
        anchors.bottom: updatePage.bottom;
        anchors.bottomMargin: 117+96+140+30+59+20;

        text: (textflag == false) ? (powerflag ?  qsTr("电源管理程序升级状态: MCU重启！") : qsTr( "应用程序升级状态！")) :  qsTr("工程模式重启、电源管理与应用程序升级！");
        font.pixelSize: 32
        color: '#ffffff'
    }

    Item {
        id: updateProgress
        anchors.horizontalCenter: updatePage.horizontalCenter;
        anchors.bottom: updatePage.bottom;
        anchors.bottomMargin: 140+96+117;

        Rectangle {
            id: background
            anchors.centerIn: parent
            implicitHeight: 30
            implicitWidth: 798
            radius: 2
            color: '#747883'
            Rectangle {
                id: progress
                implicitHeight: 30
                radius: 3
                color: "#66f8d4";
                anchors.verticalCenter: parent.verticalCenter;
                width: value > 0 ? (value > maximumValue ? background.width :
                                                           (value / (maximumValue - minimumValue)) * background.width) : 0
            }
        }

    }







    Timer {
        id: updateTime
        interval: 500
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            value ++;
            if(value >= maximumValue){
                value = 0;
            }
        }

    }


    IControls.IconButton_Normal {
        id: restartButton
        width: 240
        height: 96
        anchors.left: updatePage.left;
        anchors.leftMargin:187;
        anchors.bottom: updatePage.bottom;
        anchors.bottomMargin: 117;
        text: qsTr("重启")
        font.pixelSize: 36
        textColor: '#ffffff'

        checked: restartflag?true:false;
        bgCheckedNormalGradient: restartflag ? bgPressingGradient:bgGradient;
        bgDisabledGradient: restartflag ? bgPressingGradient:bgGradient;

        onClicked: {
            if (restartflag) {
                restartflag = false;
                console.log('[updateTest] restart!!')
            } else {
                restartflag = true;
                system.restartCore();
                console.log('[updateTest] restart finished!!')
            }
        }

    }

    IControls.IconButton_Normal {
        id: powerButton
        width: 240
        height: 96
        anchors.left: restartButton.right;
        anchors.leftMargin:93;
        anchors.top: restartButton.top;
        text: qsTr("电源管理")
        font.pixelSize: 36
        textColor: '#ffffff'

        checked: powerflag?true:false;
        bgCheckedNormalGradient: powerflag ? bgPressingGradient:bgGradient;
        bgDisabledGradient: powerflag ? bgPressingGradient:bgGradient;

        onClicked: {
            if (powerflag) {
                value = 0;
                updateTime.stop();
                powerflag = false;
                console.log('[updateTest] power manager update cancel !!')
                textflag = true;
                updateButton.disabled = false;
                restartButton.disabled = false;
            } else {
                powerflag = true;
                updateTime.start();
                system.startUpdataMcu();
                console.log('[updateTest] power manager update !!')
                textflag = false;
                updateButton.disabled = true;
                restartButton.disabled = true;
            }
        }

    }

    IControls.IconButton_Normal {
        id: updateButton
        width: 240
        height: 96
        anchors.left: powerButton.right;
        anchors.leftMargin:93;
        anchors.top: restartButton.top;
        text: qsTr("应用程序升级")
        font.pixelSize: 36
        textColor: '#ffffff'

        checked: updateflag?true:false;
        bgCheckedNormalGradient: updateflag ? bgPressingGradient:bgGradient;
        bgDisabledGradient: updateflag ? bgPressingGradient:bgGradient;

        onClicked: {
            if (updateflag) {
                value = 0;
                updateflag = false;
                updateTime.stop();
                console.log('[updateTest] APP update cancel !!')
                textflag = true;
                restartButton.disabled = false;
                powerButton.disabled = false;
            } else {
                updateflag = true;
                updateTime.start();
                system.startUpdataCore();
                console.log('[updateTest] APP update !!')
                textflag = false;
                restartButton.disabled = true;
                powerButton.disabled = true;
            }
        }

    }

}


