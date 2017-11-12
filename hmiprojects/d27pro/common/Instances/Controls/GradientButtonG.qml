import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls

UControls.GradientButton_focus{
    id: root;
    width: 300;
    height: 400;

    property url iconSource
    property string btnName
    property int themeColor
    /*<Add Radio Requirement 2.3.2.4    chengzhi    2016/11/18      viviewer:       begin*/
    property alias radioButtonDianImg: navigationF_Icon.source
    property alias radioButtonTxtColor: navigationF_Text.color
    /*Add Radio Requirement 2.3.2.4    chengzhi    2016/11/18      viviewer:       end>*/
    normalGradient: Gradient {
        GradientStop { position: 0.0; color: "#0F1115" }
        GradientStop { position: 1.0; color: "#121418" }
    }
    normalGradientDirection: ({start:Qt.point(0,0),end:Qt.point(width,0)});

    pressingGradient: Gradient {
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#ab7c48" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#855033" )}
    }
    pressingGradientDirection: ({start:Qt.point(0,0),end:Qt.point(0,height)});
    checkedNormalGradient: Gradient {
        GradientStop { position: 0.0; color: "#18181a"}
        GradientStop { position: 1.0; color: "#0d0e10"}
    }

    checkedNormalGradientDirection: normalGradientDirection

    /*<Add Radio Requirement 2.3.2.4    chengzhi    2016/11/18      viviewer:       begin*/
    Rectangle{
        id: radioComboxGradientButton
        width:241
        height:86
        color:"transparent"

        Image {
            id: navigationF_Icon
            anchors{
                left:parent.left
                leftMargin: 39
                verticalCenter: parent.verticalCenter
            }
            source: "qrc:/resources/radio_ListIcon.png"       //radio combox dian dian dian
        }
        NonAnimationText_FontRegular{
            id: navigationF_Text
            anchors{
                left:parent.left
                leftMargin: 84
                verticalCenter: parent.verticalCenter
            }
            text: btnName
            font.pixelSize: 36
            color:"#FFFFFF"                                   //radio combox text
        }
    }
    /*Add Radio Requirement 2.3.2.4    chengzhi    2016/11/18      viviewer:       end>*/

//    Connections {
//        onClicked:
//        {
//            checked = true;
//            clicked();
//            console.debug()
//        }
//        onDoubleClicked: doubleClicked()
//        onPressAndHold:
//        {
//            pressing = true;
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
