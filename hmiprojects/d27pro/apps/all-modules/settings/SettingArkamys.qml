import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import TheXAudio 1.0
import TheXSettings 1.0

ICore.Page {
    id: mainPage
    property real audioParamArkamys: -1
    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel

    property var currentDialog
    property bool isFirst : true
    Connections {
        target: SoundCommon
        Component.onCompleted: {
            audioParamArkamys = Qt.binding(function (){return SoundCommon.audioParamArkamys});
        }
    }
    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
//        interfacemodel = system.interfacemodel
    }

    onAudioParamArkamysChanged: {
         if(currentDialog) {
             currentDialog.close()
         }
    }

    onVisibleChanged: {
        if (currentDialog && !visible) {
            currentDialog.close()
        }
    }

    Image {
        id: bg
        source: interfacemodel == 0?"qrc:/resources-settings/set_BJ_04.png":(interfacemodel == 1 ? "qrc:/resources-settings/set_BJ_04_o.png":"qrc:/resources-settings/set_BJ_04_g.png")
        Grid{
            anchors.left: bg.left
            anchors.top: bg.top
            rows: 3
            columns: 2
            rowSpacing: 0.5
            ExclusiveGroup{
                id: settings
            }
            Repeater{
                model: [qsTr("关闭"),qsTr("驾驶员"),qsTr("所有乘客")]
                IControls.RadioButtonCell{
                    text: qsTr(modelData)
                    checked: index == audioParamArkamys  ? true:false
                    exclusiveGroup: settings
                    themeColor: interfacemodel
                    onCheckedChanged: {
                        if(checked){
                            console.log("setAudioParamArkamys index " + index)
                            SoundCommon.setAudioParamArkamys(index)
                            /* BEGIN by Xiong wei, 2016.12.10
                             * Adjust the sound settings according to Arkamy's changes.
                            */
                            if(index != 0) SoundCommon.setLoudnessSwitch(true)
                            if (!isFirst) {
                                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogProgress.qml',{themeColor: interfacemodel,text:qsTr('Arkamys 3D音效设置中......'), autoCloseTimeout:10000},commonDialog)
                            } else {
                                isFirst = false
                            }

                            //End by xiongwei 2016.12.10
                        }
                    }
                }

            }
        }
    }

    function commonDialog(dialog) {
         currentDialog = dialog
    }
}


