import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import TheXAudio 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id: root
    property bool isCopy: true
    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system.interfacemodel
    property bool keySwitch: SoundCommon.keySwitch
    property bool loudnessSwitch: SoundCommon.loudnessSwitch
    property real audioParamEQ: SoundCommon.audioParamEQ
    property real audioParamArkamys: SoundCommon.audioParamArkamys
    property real audioParamALCLevel: SoundCommon.audioParamALCLevel
    property var paramEQ: [qsTr("流行"),qsTr("古典"),qsTr("爵士"),qsTr("摇滚"),qsTr("自定义")]
    property var paramArkamys: [qsTr("关闭"),qsTr("驾驶员"),qsTr("所有乘客")]
    property var paramALCLevel: [qsTr("关闭"),qsTr("中"),qsTr("低"),qsTr("中高"),qsTr("中低"),qsTr("高")]

    onItemShown: {
        SoundCommon.getAllAudioParam()
    }

    Item {
        id: bg
        width: 1040
        height: 628

        ListView{
            id: setting
            width: 994
            height: 628
            model: ListModel{
                ListElement{caption:"按键音" }
                ListElement{caption:"通话音量" }
                ListElement{caption:"媒体音量" }
                ListElement{caption:"语音提示音量" }
                ListElement{caption:"Arkamys 3D声效"; name:"arkamysSetting"; widLine: "2"}
                ListElement{caption:"等响度"; widLine: "2"}
                ListElement{caption:"音场设置"; name:"soundFieldSetting"; widLine: "2"}
                ListElement{caption:"音效设置"; name:"voiceSetting"; widLine: "2"}
                ListElement{caption:"音量随速曲线"; name:"volumeCurveSetting"; widLine: "3"}
            }
            section.property: "widLine"
    //        section.criteria: ViewSection.FullString
            section.delegate: wideLine
            delegate: item
            clip: true
    //        snapMode: ListView.SnapToItem
            boundsBehavior: Flickable.StopAtBounds
            cacheBuffer: 124*10
        }
        Component{
            id: item
            Item {
                id: names
                width: 1040
                height: 124

                Loader{
                    id: slider
                    active: (index >= 1 && index <= 3)
                    sourceComponent: Component {
                        IControls.ListItemDelegateG {
                            text: qsTr(caption) + ctranslator.monitor
                            soundFlag: true
                            themeColor: interfacemodel

                            value: {
                                switch (index) {
                                case 1:
                                    SoundCommon.bluetoothVolume
                                    break
                                case 2:
                                    SoundCommon.mediaVolume
                                    break
                                case 3:
                                    SoundCommon.warnVolume
                                    break
                                default:
                                    0
                                    break
                                }
                            }

                            onPressedChanged: {
                                if (!pressed) {
                                    switch(index) {
                                    case 1:
                                        SoundCommon.setBluetoothVolume(value)
                                        break
                                    case 2:
                                        SoundCommon.setMediaVolume(value)
                                        break
                                    case 3:
                                        SoundCommon.setWarnVolume(value)
                                        break
                                    default:
                                        break
                                    }
                                }
                            }
                        }
                    }
                }
                Loader{
                    id: switches
                    active: index == 0 || index == 5
                    sourceComponent: Component{
                        IControls.ListItemDelegateH{
                            id:switchesItem
                            text: qsTr(caption) + ctranslator.monitor
                            themeColor: interfacemodel
                            checked: index == 0 ? keySwitch:loudnessSwitch
                            onCheckedChanged: {
                                if(index == 0){
                                    SoundCommon.setKeySwitch(checked)
                                }
                                else{
                                    SoundCommon.setLoudnessSwitch(checked)
                                }

                            }
                            /* BEGIN by Xiong wei, 2016.12.10
                             * Adjust the sound settings according to Arkamy's changes.
                            */
                            Connections {
                                target: root
                                onLoudnessSwitchChanged:{
                                    switchesItem.checked = ((index == 0) ? keyBeepSwitch:loudnessSwitch)
                                }
                            }

                            enabled: {
                                if(audioParamArkamys != 0 && index == 5){
                                    return false
                                }
                                return true
                            }

                            // End by xiongwei 2016.12.10
                        }
                    }
                }
                Loader{
                    id: txt
                    active: index > 5 || index == 4
                    sourceComponent: Component{
                        IControls.ListItemDelegateF{
                            themeColor: interfacemodel
                            textL: qsTr(caption) + ctranslator.monitor
                            textR: {
                                if(index == 7){
                                    switch(audioParamEQ){
                                        case 2:                        // pop audiomode
                                            return qsTr(paramEQ[0]) + ctranslator.monitor
                                        case 3:                        //classical audiomode
                                            return qsTr(paramEQ[1]) + ctranslator.monitor
                                        case 4:                        //jazz audiomode
                                            return qsTr(paramEQ[2]) + ctranslator.monitor
                                        case 5:                        //rock audiomode
                                            return qsTr(paramEQ[3]) + ctranslator.monitor
                                        case 0:                        //user-define audiomode
                                            return qsTr(paramEQ[4]) + ctranslator.monitor
                                    }
                                   //return qsTr(paramEQ[audioParamEQ])
                                }
                                if(index == 4){
                                   return qsTr(paramArkamys[audioParamArkamys]) + ctranslator.monitor
                                }
                                if(index == 8){
                                   return qsTr(paramALCLevel[audioParamALCLevel]) + ctranslator.monitor
                                }
                                return ''
                            }
                            onClicked: {
                                application.changePage(name)
                            }
                            /* BEGIN by Xiong wei, 2016.12.10
                             * Adjust the sound settings according to Arkamy's changes.
                            */
                            enabled: {
                                if(audioParamArkamys != 0 && (index == 6 || index == 7)){
                                    return false
                                }
                                    return true
                            }
                            /* END by Xiong wei, 2016.12.10
                             * Adjust the sound settings according to Arkamy's changes.
                            */

                        }
                    }
                }
            }
        }
        Component{
            id: wideLine
            Item{
                width: 1040
                height: 40
                Rectangle{
                    id: rect
                    width: 1040
                    height: 40
                    color: "#ffffff"
                    opacity: 0.06

                }
                Image {
                    id: bottomLine
                    anchors.bottom: rect.bottom
                    source: "qrc:/resources/list_lineA2.png"
                }
            }
        }
        IControls.Fixed_ScrollBar{
    //        y: 92
            anchors.right: parent.right
            anchors.rightMargin: 10
            view: setting
        }
    }
}

