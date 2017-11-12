import QtQuick 2.3

Button {
    id: root

    property alias border: rectangle.border
    property alias gradient: rectangle.gradient
    property alias radius: rectangle.radius
    property alias rectangle: rectangle

    property alias color: rectangle.normalColor
    property alias normalColor: rectangle.normalColor
    property alias pressingColor: rectangle.pressingColor
    property alias checkedNormalColor: rectangle.checkedNormalColor
    property alias checkedPressingColor: rectangle.checkedPressingColor
    property alias disabledColor: rectangle.disabledColor
    property alias focusingColor: rectangle.focusingColor
    /* BEGIN by Xiong wei, 2016.12.27
     *  Add longpress states
    */
    property alias longPressingColor: rectangle.longPressingColor
    //End by xiongwei 2016.12.27

    ButtonStateRectangle {
        id: rectangle
        anchors.fill: parent
    }
}
