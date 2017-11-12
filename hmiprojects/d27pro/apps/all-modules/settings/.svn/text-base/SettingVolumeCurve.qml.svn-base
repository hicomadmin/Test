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
    property SystemCtl system: HSPluginsManager.get('system')
    property real audioParamALCLevel
    property int interfacemodel
    property int audioLow :2
    property int audiomiddle :1
    property int audiohigh :5
    Connections {
        target:SoundCommon
        Component.onCompleted:{
            audioParamALCLevel = Qt.binding(function (){return SoundCommon.audioParamALCLevel});
        }
    }
    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }
    Image {
        id: bg
        source: interfacemodel == 0 ?"qrc:/resources-settings/set_BJ_05.png":(interfacemodel  == 1 ? "qrc:/resources-settings/set_BJ_05_o.png":"qrc:/resources-settings/set_BJ_05_g.png")
        Grid{
            anchors.left: bg.left
            anchors.top: bg.top
            rows: 2
            columns: 2
            rowSpacing: 0.5
            ExclusiveGroup{
                id: settings
            }
            /* BEGIN by Li Peng, 2016.11.19
             * The display logic.
             * See: <HS-M1164 D27-V1.5.xlsx>, 10.3.3
            */
            Repeater{
                model: [qsTr("关闭"),qsTr("低"),qsTr("中"),qsTr("高")]
                IControls.RadioButtonCell{
                    property bool ischecked:false
                    text: qsTr(modelData)
                    checked:
                        {
                            switch(index)
                            {
                            case 1:
                                if(audioLow == audioParamALCLevel){
                                   ischecked = true
                                }
                                else{
                                   ischecked = false
                                }
                                break;
                            case 2:
                                if(audiomiddle == audioParamALCLevel){
                                    ischecked = true
                                 }
                                 else{
                                    ischecked = false
                                 }
                                break;
                            case 3:
                                if(audiohigh == audioParamALCLevel){
                                    ischecked = true
                                 }
                                 else{
                                    ischecked = false
                                 }
                                break;
                            default:
                                console.log(index)
                                if(index == audioParamALCLevel){
                                    ischecked = true
                                 }
                                 else{
                                    ischecked = false
                                 }
                                break;
                            }
                            ischecked
                        }
                    exclusiveGroup: settings
                    themeColor:interfacemodel
                    onCheckedChanged: {
                        if(checked){
                            switch(index)
                            {
                            case 1:
                                if(2 != audioParamALCLevel)
                                {
                                    SoundCommon.setAudioParamALCLevel(audioLow)
                                }
                                break;
                            case 2:
                                if(1 != audioParamALCLevel)
                                {
                                    SoundCommon.setAudioParamALCLevel(audiomiddle)
                                }
                                break;
                            case 3:
                                if(5 != audioParamALCLevel)
                                {
                                    SoundCommon.setAudioParamALCLevel(audiohigh)
                                }
                                break;
                            default:
                                console.log(index)
                                if(index != audioParamALCLevel)
                                {
                                    SoundCommon.setAudioParamALCLevel(index)
                                }
                                break;
                            }
                        }
                    }
                }
            }
            /* END by Li Peng
            */
        }
    }
}


