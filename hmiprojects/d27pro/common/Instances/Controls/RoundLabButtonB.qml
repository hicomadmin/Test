import QtQuick 2.3
import QtGraphicalEffects 1.0
import 'qrc:/UI/Controls' as UControls

UControls.ColorButton {
    id :root
    property int themeColor: 0
    normalColor: '#97999e'
    pressingColor: themeColor == 0 ?"#105769":(themeColor == 1? "#ff2200":"#986142")
    opacity:0.3
    radius: 4

//    DropShadow {//绘制阴影
//                id: rectShadow;
//                anchors.fill: parent
//                horizontalOffset: 2;
//                verticalOffset: 2;
//                radius: 8.0;
//                samples: 16;
//                color: "#80000000";
//                source: parent;
//                }

}
