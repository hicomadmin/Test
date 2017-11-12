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
//    property SoundCtl sound
    property int audioParamEQ
    property int audioParamBass
    property int audioParamTreble
    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel

    Connections {
        target: SoundCommon
        Component.onCompleted:{
            audioParamEQ     = Qt.binding(function () { return SoundCommon.audioParamEQ })
            audioParamBass   = Qt.binding(function () { return SoundCommon.audioParamBass })
            audioParamTreble = Qt.binding(function () { return SoundCommon.audioParamTreble })
            setModeChange(modeToIndex(audioParamEQ))
        }
    }

    function modeToIndex(mode) {
        switch(mode) {
        case 2:
            return 0           //2:pop mode
        case 3:
            return 1           //3:classical mode
        case 4:
            return 2           //4:jazz mode
        case 5:
            return 3           //5:rock mode
        case 0:
        default:
            return 4           //0:user define mode
        }
    }

    function indexToMode(index) {
        switch(index) {
        case 0:
            return 2           //2:pop mode
        case 1:
            return 3          //3:classical mode
        case 2:
            return 4          //4:jazz mode
        case 3:
            return 5          //5:rock mode
        case 4:
        default:
            return 0          //0:user define mode
        }
    }

    onAudioParamBassChanged: {
        lowset.value = audioParamBass
    }

    onAudioParamTrebleChanged: {
        highset.value = audioParamTreble
    }

    function setRepeater(index) {
        repeater.itemAt(index).checked = true
    }

    //Adjust the UI and auidomode according to the change of mode
    function setModeChange(index){
        switch(index) {
        case 0:
            setValueChange(-7, -2)
            break                   //2:pop mode
        case 1:
            setValueChange(-1, -4)
            break;                  //3:classical mode
        case 2:
            setValueChange(4, 1)
            break;                  //4:jazz mode
        case 3:
            setValueChange(3, -6)
            break;                  //5:rock mode
        case 4:
        default:
            lowset.value  = Qt.binding(function() { return audioParamBass })
            highset.value = Qt.binding(function() { return audioParamTreble })
            break;                  //0:user define mode
        }
        SoundCommon.setAudioParamEQ(indexToMode(index))
        console.debug("the audiomode", indexToMode(index))
    }

   function setValueChange(low, high){
       lowset.value  = low
       highset.value = high
   }

   onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    Flickable {
        width: 1280
        height: 628
        contentWidth: bg.width
        //contentHeight: bg.height + highset.height + lowset.height
        contentHeight: bg.height

        Image {
            id: bg
            width: 1280
            height: 628
            source: (interfacemodel == 0) ? "qrc:/resources-settings/set_BJ_03.png" : (interfacemodel == 1 ? "qrc:/resources-settings/set_BJ_03_o.png":"qrc:/resources-settings/set_BJ_03_g.png")
            Grid {
                anchors.left: bg.left
                anchors.top: bg.top
                rows: 3
                columns: 2
                rowSpacing: 0.5
                ExclusiveGroup{
                    id: settings
                }
                Repeater {
                    id: repeater
                    model: [qsTr("流行"),qsTr("古典"),qsTr("爵士"),qsTr("摇滚"),qsTr("自定义")]
                    IControls.RadioButtonCell {
                        id: button
                        text: qsTr(modelData)
                        checked: (modeToIndex(audioParamEQ) === index)
                        height: 160
                        exclusiveGroup: settings
                        themeColor: interfacemodel
                        onPressedChanged: {
                            console.debug(checked, ", the AudioParamEQ is", audioParamEQ, "the index is", index)
                            if (!pressed && checked) {
                                setModeChange(index)
                            }
                        }
                    }
                }
            }
        }

        Item {
            anchors.top: bg.left
            anchors.bottom: bg.bottom
            width: parent.width
            height:highset.height
            IControls.ListItemDelegateG {
                id:lowset
                width: parent.width/2
                //txtanchors.leftMargin: 170
                rbtnanchors.rightMargin: 40
                bottomLinevisible: false
                textFontSize:38
                text: qsTr("低音")
                numFlag: true
                //soundFlag: true
                themeColor: interfacemodel
                onPressedChanged: {
                    if (!pressed) {
                        SoundCommon.setAudioParamBass(value)
                        SoundCommon.setAudioParamTreble(highset.value)
                        setRepeater(4)
                    }
                }
            }

            IControls.ListItemDelegateG {
                id:highset
                width: parent.width/2
                //txtanchors.leftMargin: 170
                rbtnanchors.rightMargin: 20
                txtanchors.leftMargin: 55
                bottomLinevisible: false
                textFontSize:38
                text: qsTr("高音")
                numFlag: true
                //soundFlag: true
                themeColor: interfacemodel
                anchors.top: lowset.right
                anchors.left: lowset.right
                onPressedChanged: {
                    if (!pressed) {
                        SoundCommon.setAudioParamTreble(value)
                        SoundCommon.setAudioParamBass(lowset.value)
                        setRepeater(4)
                    }
                }
            }
        }
    }
}
