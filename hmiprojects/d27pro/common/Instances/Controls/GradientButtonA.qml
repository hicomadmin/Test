import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls

UControls.GradientButton{
    id: root;
    width: 300;
    height: 400;

    property url iconSource
    property string btnName
    property int themeColor
    /* BEGIN by Xiong wei, 2016.12.27
     *  Add longpress states
    */
    property real textCenterOffset
    //End by xiongwei 2016.12.27
    property int textPixelSize : 36

    normalGradient: Gradient {
        GradientStop { position: 0.0; color: "#0F1115" }
        GradientStop { position: 1.0; color: "#121418" }
    }
    normalGradientDirection: ({start:Qt.point(0,0),end:Qt.point(width,0)});

    pressingGradient: Gradient {
        GradientStop { position: 0.0; color: themeColor == 0 ? "#105769" : (themeColor == 1 ? "#9B1702" : "#986142" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#105769" : (themeColor == 1 ? "#9B1702" : "#986142" ) }
    }
    pressingGradientDirection: ({start:Qt.point(0,0),end:Qt.point(0,height)});

    /* BEGIN by Xiong wei, 2016.12.27
     *  Add longpress states
    */
    longPressingGradientGradient: Gradient {
        GradientStop { position: 0.0; color: themeColor == 0 ? "#105769" : (themeColor == 1 ? "#9B1702" : "#986142" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#105769" : (themeColor == 1 ? "#9B1702" : "#986142" ) }
    }
    longPressingGradientGradientDirection: ({start:Qt.point(0,0),end:Qt.point(0,height)});
    //End by xiongwei 2016.12.27

    checkedNormalGradient:Gradient {
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#ab7c48" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#855033" )}
    }
    checkedNormalGradientDirection: ({start:Qt.point(0,0),end:Qt.point(0,height)});
    contentcompent: Component{
        Rectangle{
            width:242
            height:152
            color:"transparent"

            Image {
                id: navigationB_Icon
                anchors{
                    left:parent.left
                    leftMargin:41
                    verticalCenter: parent.verticalCenter
                }
                source: iconSource
            }

            NonAnimationText_FontRegular{
                id: navigationB_Text
                anchors{
                    left:parent.left
                    leftMargin: 100
                    verticalCenter: parent.verticalCenter
                    /* BEGIN by Xiong wei, 2016.12.27
                     *  Add longpress states
                    */
                    verticalCenterOffset: textCenterOffset
                    //End by xiongwei 2016.12.27
                }
                text: btnName
                font.pixelSize: textPixelSize
                color: (enabled === true || longHoldPressed === true) ? "#FFFFFF" : "#373737"
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

