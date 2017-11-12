import QtQuick 2.0

Rectangle{
    property alias text: contentTextId.text
    property alias font: contentTextId.font
    property alias textColor: contentTextId.color
    property bool textCenter: false
    property int speed: 10
    property double offset: 0.5
    id:rectText
    color: "#00000000"
    clip:true

    Text {
        id: contentTextId
        anchors.horizontalCenter: textCenter && (contentTextId.contentWidth < rectText.width) ? parent.horizontalCenter: undefined
        NumberAnimation {
            id: animText
            target: contentTextId
            property: "x"
            duration: (offset * rectText.width * 2 + Math.abs(contentTextId.contentWidth - rectText.width)) * speed //you can change for velocity
            from: rectText.width - contentTextId.contentWidth - offset * rectText.width
            to: offset * rectText.width
            easing.type: Easing.Linear

            onStopped: {
                if(contentTextId.contentWidth > rectText.width)
                {
                    var tmp = animText.from
                    animText.from = animText.to
                    animText.to = tmp
                    animText.start();
                }
            }
            Component.onCompleted: {
                animText.running = contentTextId.contentWidth > rectText.width
            }
        }
        onTextChanged: {
            animText.running = contentTextId.contentWidth > rectText.width
            contentTextId.x = 0
            if(animText.running) {
                animText.from = rectText.width - contentTextId.contentWidth - offset * rectText.width
                animText.to = offset * rectText.width
                animText.restart()
            }
        }
    }
}
