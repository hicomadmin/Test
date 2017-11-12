import QtQuick 2.3
import QtMultimedia 5.0

import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    id: root
    property Radio radio
    onRadioChanged: {
        console.log(radio.frequency);
    }

    IControls.RectButtonA {
        anchors.centerIn: parent
        onClicked: {
            application.changePage('multi');
        }

        UControls.ButtonStateLabel {
            anchors.centerIn: parent
            normalColor: '#FFFFFF'
            pressingColor: '#AAFFFFFF'
            font.pixelSize: 20
            text: '查看多个插件'
        }
    }
}
