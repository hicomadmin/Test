import QtQuick 2.5
import QtGraphicalEffects 1.0

/* 按钮下方的渐变条 */
//采用普通渐变gradient需要旋转且容易导致布局问题，线性渐变可以很好解决该问题，
//需要外部设置渐变条宽度(渐变条与按钮等宽),以及实现underBtnGradient
//(根据具体按钮的渐变条的渐变色,相当于实现下方注释的Gradient代码)


Rectangle {

    id: root
    height: 10

    property alias gradient_width:   root.width
    //property alias gradient_height:  root.height
    property alias underBtnGradient: root.normalGradient

    LinearGradient{
        anchors.fill: parent
        start: Qt.point(0,0)
        end: Qt.point(parent.width,0)
        gradient: normalGradient
        /*gradient:Gradient{
            GradientStop{
                position: 0.0
                color:"red"
            }
            GradientStop{
                position: 0.5
                color:"yellow"
            }
            GradientStop{
                position: 1.0
                color: "blue"
            }
        }*/

    }

    property Gradient normalGradient: normalGradient
}
