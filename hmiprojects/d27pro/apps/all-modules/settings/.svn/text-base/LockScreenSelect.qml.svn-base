import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import TheXSettings 1.0

ICore.Page {
        id: root
        property bool check
        property SystemCtl system: HSPluginsManager.get('system')
        property real screenModel
        property int interfacemodel
        property color rectColor: interfacemodel == 0 ? "#184c57":(interfacemodel == 1?"#F7624B":"#986142")
        property color bordColor: interfacemodel == 0 ? "#5db5b7":(interfacemodel == 1?"#fbcaac":"#ffe0c2")
        property color nomalColor: interfacemodel == 0 ? "#0f323a":(interfacemodel == 1?"#852516":"#6c3a1d")

        onSystemChanged: {
            screenModel = Qt.binding(function (){return system.screenmodel})
            interfacemodel = Qt.binding(function(){return system.interfacemodel})
        }
        onScreenModelChanged: {
            if(screenModel == 1){
                check = true
            }
            if(screenModel == 2){
                check = false
            }
        }

        Rectangle {
            id: clockRect
            width: 302
            height: 302
            anchors.left: parent.left
            anchors.leftMargin: 309
            anchors.top: parent.top
            anchors.topMargin: 137
            border.width: check ? 2 : 0
            border.color: bordColor
            color: check ? rectColor:nomalColor
            Image {
                id: clockBg
                anchors.centerIn: parent
                source: "qrc:/resources-settings/clock_BJ_01.png"
                Image {
                    id: yuan
                    anchors.centerIn: parent
                    source: "qrc:/resources-settings/colck__icon_yuandian_02.png"
                }
                Image {
                    id: hourHand
                    anchors.centerIn: parent
                    source: "qrc:/resources-settings/colck__icon_shizhen_2.png"
                }
                Image {
                    id: minuteHand
                    anchors.centerIn: parent
                    rotation: 240
                    source: "qrc:/resources-settings/colck__icon_fenzhen_1.png"
                }
            }
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(!check){
                        system.setScreenmodel(1)
                        application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("设置成功")})
//                        check = true
                    }
                }
            }
        }
        IControls.NonAnimationText_FontRegular{
            id: clockTxt
            anchors.top: parent.top
            anchors.topMargin: 68
            anchors.left: clockRect.left
            anchors.leftMargin: system.language === 0 ? (width/2 + 10) : (width/4 + 10)
            text: qsTr("模拟时钟")
            color: "#ffffff"
            font.pixelSize: 36
        }
        Rectangle {
            id: numberRect
            width: 302
            height: 302
            anchors.right: parent.right
            anchors.rightMargin: 309
            anchors.top: parent.top
            anchors.topMargin: 137
            border.width: !check ? 2 : 0
            border.color: bordColor
            color: !check ? rectColor:nomalColor
            IControls.NonAnimationText_FontRegular{
                id: number
                anchors.centerIn: parent
                text: "02:55"
                color: "#ffffff"
                font.pixelSize: 72
            }

            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(check){
                        system.setScreenmodel(2)
                        application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("设置成功")})
//                        check = false
                    }
                }
            }
        }
        IControls.NonAnimationText_FontRegular{
            id: numberTxt
            anchors.top: parent.top
            anchors.topMargin: 68
            anchors.left: numberRect.left
            anchors.leftMargin: system.language === 0 ? (width/2 + 10) : (width/5 + 10)
            text: qsTr("数字时钟")
            color: "#ffffff"
            font.pixelSize: 36
        }
}


