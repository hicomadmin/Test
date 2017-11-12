import QtQuick 2.0
import QtQuick.Controls 1.2
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import TheXMcan 1.0
import TheXSettings 1.0

ICore.Page {
    id: root
    property bool isCopy: true
    property McanCtl mcan: HSPluginsManager.get('mcan')
    property real lightColor
    property int lightIndex
    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel

    onMcanChanged: {
        mcan.getControl(0)
        lightColor = Qt.binding(function (){return mcan.lightColor});
    }
    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
//        interfacemodel = system.interfacemodel
    }
    onLightColorChanged: {
        console.debug("onLightColorChanged",lightColor)
        if(lightColor != 15){
            lightIndex = lightColor - 1
        }
        else
            lightIndex = 7
    }

    Item {
        id: bg
        width: 1280
        height: 628
        ListView{
            id: lights
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 46
            width: 1188
            height: 628
            model:[qsTr("红色"),qsTr("粉紫色"),qsTr("浪漫金"),qsTr("魅力橙"),qsTr("科技蓝"),qsTr("白色"),qsTr("冰绿色"),qsTr("跟随主题")]
            delegate: items
            clip: true

        }
        ExclusiveGroup{
            id: selected
        }
        Component{
            id: items
            IControls.ListDelegateRadioButton{
                text: qsTr(modelData)
                checked: index == lightIndex ? true:false
                exclusiveGroup: selected
                themeColor: interfacemodel
                onLightchecked: {
                    if(index != 7){
                        mcan.setLightColorSwitch(index + 1)
                    }
                    else{
                        mcan.setLightColorSwitch(15)
                    }
                    console.debug("setLightColorSwitch",index)

                }
            }
        }
        IControls.Fixed_ScrollBar{
            view: lights
            anchors.right: parent.right
            anchors.rightMargin: 10
        }
    }
}

