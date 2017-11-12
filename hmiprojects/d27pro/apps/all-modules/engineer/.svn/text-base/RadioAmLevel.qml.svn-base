import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls

import TheXRadio 1.0

ICore.Page {
    id: root

    property RadioCtl radio : HSPluginsManager.get('radio')

    readonly property int textPixelSize: 38

    onRadioChanged: {
        radio.getEngineParam(1)
    }

    IControls.ListItemDelegateG {
        id:updateAmLevel
        anchors.centerIn: parent
        width: parent.width
        numVisibleFlag: false
        rbtnanchors.rightMargin: 100
        bottomLinevisible: false
        sliderWidth: parent.width / 2
        textFontSize:textPixelSize
        text: qsTr("收音机AM灵敏度  " + value)
        maximunValue: 255
        minimunValue: 0
        value: radio.amLevel
        soundFlag: true
        onPressedChanged: {
            if (!pressed) {
                radio.setEngineParam(1 ,1 ,value)
            }
        }
    }

}

