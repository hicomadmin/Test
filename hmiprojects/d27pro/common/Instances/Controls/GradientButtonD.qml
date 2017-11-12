import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls

UControls.GradientButton{
    id: root;
    width: 300;
    height: 400;

    property url iconSource
    property string btnName
    property int themeColor

    normalGradient: Gradient {
        GradientStop { position: 0.0; color: "#343638" }
        GradientStop { position: 1.0; color: "#1a1b1d" }
    }
    normalGradientDirection: ({start:Qt.point(0,0),end:Qt.point(width,0)});

    pressingGradient: Gradient {
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#ab7c48" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#855033" ) }
    }
    pressingGradientDirection:normalGradientDirection
    checkedNormalGradient:pressingGradient
    checkedNormalGradientDirection:pressingGradientDirection
    contentcompent: Component{
        Rectangle{
            width:0
            height:0
            color:"transparent"

            Image {
                id: navigationD_Icon
                anchors.centerIn: parent
                source: iconSource
            }
        }
    }
}
