import QtQuick 2.3
import QtGraphicalEffects 1.0
import 'qrc:/UI/Controls' as UControls

UControls.ColorButton{
    id:root

    property alias normalSource: buttonIcon.normalSource
    property alias pressingSource:buttonIcon.pressingSource

    normalColor: '#343638'
    pressingColor: '#1a1b1d'
    opacity:0.6
    radius: 4

//    DropShadow {//绘制阴影
//                id: rectShadow;
//                anchors.fill: parent
//                horizontalOffset: 1;
//                verticalOffset: 1;
//                radius: 8.0;
//                samples: 16;
//                color: "#80000000";
//                source: parent;
//                }


    UControls.ButtonStateImage{
        id:buttonIcon
        anchors.centerIn: parent
    }
}

