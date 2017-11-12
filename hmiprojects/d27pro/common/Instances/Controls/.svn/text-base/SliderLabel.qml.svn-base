import QtQuick 2.0

Item {
    property alias numTextAnchors: num.anchors
    property alias numImageAnchors: rule.anchors
    property int numPixelSize: 25
    property string numText : "0"

    NonAnimationText_FontRegular {
        id: num
        anchors.bottom: rule.top
        anchors.bottomMargin: 5
        font.pixelSize: numPixelSize
        color:"#606868"
        text: numText
    }
    Image {
        id: rule
        anchors.bottom: parent.top
        anchors.bottomMargin: 2
        source: "qrc:/resources/slider_ruler.png"
    }
}
