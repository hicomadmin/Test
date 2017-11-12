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
    property var audioParamFiled/*:[1,1]*/
    property int levelX
    property int levelY
    property bool isFirst: true
    property int interfacemodel
    Connections {
        target:SoundCommon
        Component.onCompleted:{
            audioParamFiled = Qt.binding(function (){return SoundCommon.audioParamFiled});
        }
    }
    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }
    /* BEGIN by Li Peng, 2016.11.22
     * audioFiled restructure.
    */
    onAudioParamFiledChanged: {
        console.log("audioParamFiled[1] = ",audioParamFiled[1],"audioParamFiled[0] = ",audioParamFiled[0])
        setHandle.x = (audioParamFiled[1]*5)+500 - setHandle.width/2
        setHandle.y = ((area.height/2) - audioParamFiled[0]*2.75) - setHandle.height/2
        console.log("setHandle.x = ",setHandle.x,"setHandle.y = ",setHandle.y)
        /* BEGIN by Xiong wei, 2016.12.10
         * adjust audioFiled drag display.
        */
        if (setHandle.x < 240) {
            setHandle.x = 240
        } else if (setHandle.x > 620) {
            setHandle.x = 620
        }
        if (setHandle.y < -10) {
            setHandle.y = -10
        } else if (setHandle.y > 420) {
            setHandle.y = 420
        }
        // End by xiong wei 2016.12.10
        /* BEGIN by Xiong wei, 2016.12.15
         * Adjust the center position
        */
        if (setHandle.x > 380 && setHandle.x < 450 && setHandle.y > 170 && setHandle.y < 230) {
            setHandle.x = 425
            setHandle.y = 200
        }
        //End by xiongwei 2016.12.15
    }

    Image {
        id: bg
        source: interfacemodel == 0?"qrc:/resources-settings/set_BJ_01.png":(interfacemodel == 1 ? "qrc:/resources-settings/set_BJ_01_o.png":"qrc:/resources-settings/set_BJ_01_g.png")
        Item {
            id: area
            anchors.centerIn: parent
            width: 1000
            height: 550
            IControls.MouseArea{
                anchors.fill: parent
                onReleased: {
                    setHandle.x = mouseX - setHandle.width/2
                    setHandle.y = mouseY - setHandle.height/2
                    /* BEGIN by Xiong wei, 2016.12.10
                     * adjust audioFiled drag display.
                    */
                    if (setHandle.x < 240) {
                        setHandle.x = 240
                    } else if (setHandle.x > 620) {
                        setHandle.x = 620
                    }
                    if (setHandle.y < -10) {
                        setHandle.y = -10
                    } else if (setHandle.y > 420) {
                        setHandle.y = 420

                    }
                    //End by xiongwei 2016.12.10
                    /* BEGIN by Xiong wei, 2016.12.15
                     * Adjust the center position
                    */
                    if (setHandle.x > 380 && setHandle.x < 450 && setHandle.y > 170 && setHandle.y < 230) {
                        setHandle.x = 425
                        setHandle.y = 200
                    }
                    //End by xiongwei 2016.12.15
                    console.log(mouseX,mouseY)
                    levelX = Math.floor((mouseX - (parent.width/2))/5)
                    levelY = Math.floor(((parent.height/2) - mouseY)/2.75)
                    console.log("levelX = ",levelX,"levelY = ",levelY)
                    SoundCommon.setAudioParamFiled([levelY,levelX])
                }
            }
            Image {
                id: setHandle
                x: (parent.width - setHandle.width)/2
                y: (parent.height - setHandle.height)/2
                source: interfacemodel == 0?"qrc:/resources-settings/set_slider.png":(interfacemodel == 1 ? "qrc:/resources-settings/set_slider_o.png":"qrc:/resources-settings/set_slider_g.png")
            }
        }
        /* END by Li Peng, 2016.11.22
        */
        IControls.NonAnimationText_FontRegular{
            id: left
            anchors.left: parent.left
            anchors.leftMargin: 45
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("左侧")
            color: "#B4B4B5"
            font.pixelSize: 26
        }
        IControls.NonAnimationText_FontRegular{
            id: right
            anchors.right: parent.right
            anchors.rightMargin: 45
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("右侧")
            color: "#B4B4B5"
            font.pixelSize: 26
        }
        IControls.NonAnimationText_FontRegular{
            id: front
            anchors.top: parent.top
            anchors.topMargin: 14
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("前排")
            color: "#B4B4B5"
            font.pixelSize: 26
        }
        IControls.NonAnimationText_FontRegular{
            id: back
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 14
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("后排")
            color: "#B4B4B5"
            font.pixelSize: 26
        }


    }
}


