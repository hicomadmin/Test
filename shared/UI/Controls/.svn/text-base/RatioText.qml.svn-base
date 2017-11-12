import QtQuick 2.3
import 'qrc:/UI/Private' as Private

Private.Control {

    property alias  numerator: numerator
    property int numText
    property int denText
    property color numColor
    property color denColor : numColor
    property int numFontSize
    property int denFontSize
    //分子值
    Text {
        id: numerator
        text: numText
        font.pixelSize:numFontSize
        color: numColor
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }
   //分母值
    Text {
        id: denominator
        text: '/'+denText
        font.pixelSize: denFontSize
        color: denColor
        anchors.left: numerator.right
        anchors.bottom: parent.bottom
    }
}
