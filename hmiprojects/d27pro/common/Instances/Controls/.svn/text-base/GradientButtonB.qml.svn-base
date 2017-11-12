import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls

UControls.GradientButton {
    id: root;
    width: 300;
    height: 400;

    property url iconSource
    property string btnName
    //Bug #180
    property string btnColor
    property int themeColor: 0

    normalGradient: Gradient {
        GradientStop { position: 0.0; color: "#0F1115" }
        GradientStop { position: 1.0; color: "#121418" }
    }
    normalGradientDirection: ({start:Qt.point(0,0),end:Qt.point(width,0)});

    pressingGradient: Gradient {
        GradientStop { position: 0.0; color: themeColor == 0 ? "#105769" : (themeColor == 1 ? "#9B1702" : "#986142" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#105769" : (themeColor == 1 ? "#9B1702" : "#986142" )}
    }
    pressingGradientDirection:({start:Qt.point(0,0),end:Qt.point(0,height)});
    checkedNormalGradient:Gradient {
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#ab7c48" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#855033" )}
    }

    disabledGradient:Gradient {
        GradientStop { position: 0.0; color: "#0F1115" }
        GradientStop { position: 1.0; color: "#0F1115"}
    }

    checkedNormalGradientDirection:pressingGradientDirection
    contentcompent: Component{
        Rectangle{
            width:242
            height:152
            color:"transparent"

            NonAnimationText_FontRegular {
                id: navigationB_Text
                anchors.centerIn: parent
                text:btnName
                color: btnColor;//"#FFFFFF"
                font.pixelSize: 36
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
