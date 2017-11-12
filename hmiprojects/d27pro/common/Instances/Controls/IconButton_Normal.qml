import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
UControls.Icon_Button {
//共通iconbutton，没有特殊标准的iconbutton都用这个
//    。已经设置了渐变色，需要自己设置button大小和icon的资源
    property int themeColor;

    bgGradient:Gradient {
          GradientStop { position: 0.0; color: "#25272b" }
          GradientStop { position: 1.0; color: "#181a1c" }
          }
    bgPressingGradient:Gradient{
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#ab7c48" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#855033") }
    }
}

