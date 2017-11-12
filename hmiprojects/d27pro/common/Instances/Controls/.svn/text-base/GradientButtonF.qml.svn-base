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
        GradientStop { position: 0.0; color: "#363636" }
        GradientStop { position: 0.5; color: "#2e2f2f"}
        GradientStop { position: 1.0; color: "#090a0a" }
    }
    normalGradientDirection: ({start:Qt.point(0,0),end:Qt.point(width,0)});

    pressingGradient: Gradient {
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#ab7c48" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#855033" ) }
    }
    pressingGradientDirection: normalGradientDirection
    checkedNormalGradient: pressingGradient
    checkedNormalGradientDirection: pressingGradientDirection
    contentcompent: Component{
        Rectangle{
            width:241
            height:86
            color:"transparent"

            Image {
                id: navigationF_Icon
                anchors.centerIn: parent
                source: iconSource
            }
        }
    }
    //    Connections {
    //        onClicked:
    //        {
    //            checked = true;
    //            clicked();
    //        }
    //        onDoubleClicked: doubleClicked()
    //        onPressAndHold:
    //        {
    //            pressing = ture;
    //            longPressed();
    //        }
    //        onPressed: {
    //            pressing = true;
    //            pressed();
    //        }
    //        onReleased: {
    //            checked = true;
    //            pressing = false;
    //            released();
    //        }
    //        onCanceled: {

    //            pressing = false;
    //            canceled();
    //        }
    //    }
}
