import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
UControls.Icon_Button {
//已经限定大小和渐变色,只需要加载icon资源
    property int themeColor;

    width: 1038
    height: 147
    bgOpacity:0.75

    bgGradient:Gradient {
          GradientStop { position: 0.0; color: "#090a0a" }
          GradientStop { position: 0.5; color: "#2e2f2f" }
          GradientStop { position: 1.0; color: "#363636" }
          }
    bgPressingGradient:Gradient{
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#ab7c48" )  }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#855033") }
    }


}
