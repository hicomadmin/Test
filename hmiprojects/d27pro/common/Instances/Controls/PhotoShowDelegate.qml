import 'qrc:/UI/Controls' as UControls
import QtQuick 2.3
import 'qrc:/Instances/Controls' as IControls

UControls.BgImageButton{
    id:bgImgBtn
    height: 309;
    width: 251;
    property int themeColor: 0
    property url bgSource;
    bgSourceComponent: bgImageComp
    normalOpacity: 0
    pressingColor: themeColor == 0 ?"#66f8d4":(themeColor == 1? "#ff2200":"#986142")

    pressingOpacity: 0.5

    Component{
        id:bgImageComp
        Image{
            id:img
            source:bgSource
        }

    }

}

