import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls

UControls.Icon_Button {
    property int themeColor: 0
    bgRadius: 4
    width: 122
    height: 80
    font.pixelSize: 36
    textColor:"#ffffff"


    bgGradient:Gradient {
          GradientStop { position: 0.0; color: themeColor == 0 ? "#2b353b":(themeColor == 1? "#bf5646" :"#ab7c48") }
          GradientStop { position: 1.0; color: themeColor == 0 ? "#1e282d":(themeColor == 1? "#59241c" :"#855033") }
          }
    bgPressingGradient:Gradient{
        GradientStop { position: 0.0; color: themeColor == 0 ?"#267284":(themeColor == 1? "#9b1702":"#d3ae73") }
        GradientStop { position: 1.0; color: themeColor == 0 ?"#0e5263":(themeColor == 1? "#2d0d07":"#ac7d49") }
    }
}

