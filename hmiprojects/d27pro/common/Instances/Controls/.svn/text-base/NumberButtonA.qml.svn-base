import QtQuick 2.3
import QtGraphicalEffects 1.0
import 'qrc:/UI/Controls' as UControls

UControls.ColorButton{
    id:root
    property alias buttonText: numberlabel.text
    property int themeColor: 0

    height: 86
    width: 255
    opacity: 0.8
    pressingColor: themeColor == 0 ?"#20868b":(themeColor == 1? "#ff2200":"#986142")

    UControls.Label{
        id:numberlabel
        anchors.centerIn: parent
        color: '#c0c1c5'
        font.pixelSize: 55
    }

}

