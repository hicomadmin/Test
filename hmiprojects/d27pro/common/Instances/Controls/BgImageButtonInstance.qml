import 'qrc:/UI/Controls' as UControls
import QtQuick 2.3
import 'qrc:/Instances/Controls' as IControls

UControls.BgImageButton{
    id:bgImgBtn
    height: 309;
    width: 251;
    property url bgSource;
    property string labelText

    property int themeColor

    bgSourceComponent: bgImageComp
    normalOpacity: 0
    pressingColor: (themeColor === 0)?"#66f8d4":((themeColor === 1)?"#ff4906":"#986142")
    pressingOpacity: 0.5
    layerDisp:false

    Component{
        id:bgImageComp

        Image{
            id:img
            source:bgSource

            IControls.NonAnimationText_FontRegular{
                        anchors.top: parent.top
                        anchors.topMargin: 245
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 30
                        color: "#FFFFFF"
                        text:labelText
            }
        }
    }
}


