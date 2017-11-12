import QtQuick 2.3
import QtGraphicalEffects 1.0
import 'qrc:/UI/Controls' as UControls


UControls.ColorButton{
    property int themeColor

    id:root

    property alias pressingSource:buttonIcon.pressingSource
    property alias normalSource: buttonIcon.normalSource
    property url iconSource

    normalColor: '#0c0d0d'
    pressingColor: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#986142" )
    opacity:0.6


    UControls.ButtonStateImage{
        id:buttonIcon
        anchors.centerIn: parent
        normalSource: iconSource
    }
}




