import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
UControls.Icon_Button {
    property int themeColor

    bgRadius: 4


    bgGradient:Gradient {
          GradientStop { position: 0.0; color: themeColor == 0 ?"#2b353b" :(themeColor == 1? "#bf5646" : "#ab7c48")}
          GradientStop { position: 1.0; color: themeColor == 0 ?"#1e282d" :(themeColor == 1? "#59241c" : "#855033")}
          }
    bgPressingGradient:Gradient{
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#d3ae73" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#ac7d49" ) }
    }
}

