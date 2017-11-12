import QtQuick 2.0

Rectangle{
    id:g_background
    width:242
    height:154
    Rectangle{

    property alias gradient: bg_gradient.gradient
    property alias rotiation:bg_gradient.rotation

    id:bg_gradient
    width:154
    height:242
    gradient:Gradient{
       GradientStop { position: 0.0; color: "#0f1115" }
       GradientStop { position: 1.0; color: "#121418" }
    }
    rotation:270
    anchors.centerIn:g_background
}

}
