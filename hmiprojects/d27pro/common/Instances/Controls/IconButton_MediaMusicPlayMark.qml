import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls

UControls.Icon_Button {
    property int themeColor

    width: 425
    height: 147
    bgOpacity:0.75
    
    bgGradient:Gradient {
        GradientStop { position: 0.0; color: "#343638" }
        GradientStop { position: 1.0; color: "#1a1b1d" }
    }
    bgPressingGradient:Gradient{
        GradientStop { position: 0.0; color: themeColor == 0 ? "#267284" : (themeColor == 1 ? "#9B1702" : "#ab7c48" ) }
        GradientStop { position: 1.0; color: themeColor == 0 ? "#0E5263" : (themeColor == 1 ? "#2D0D07" : "#855033" ) }
    }
    
}
