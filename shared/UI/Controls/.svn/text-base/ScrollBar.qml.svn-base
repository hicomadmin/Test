import QtQuick 2.3
import 'qrc:/UI/Private' as Private

Private.Control {
    id: root

    property int orientation : Qt.Vertical
    property Flickable flickable: Flickable {}
    property alias bgComponent: bgLoader.sourceComponent
    property alias dragArea: dragArea
    property alias dragComponent: dragLoader.sourceComponent

    Loader {
        id: bgLoader
        anchors.fill: parent
    }
    MouseArea {
        id: dragArea
        x: {
            var xPosition = flickable.visibleArea.xPosition;
            if (xPosition < 0) xPosition = 0;
            if (xPosition > 1 - flickable.visibleArea.widthRatio) xPosition = 1 - flickable.visibleArea.widthRatio;
            return orientation == Qt.Vertical ? 0 : xPosition * root.width;
        }
        y: {
            var yPosition = flickable.visibleArea.yPosition;
            if (yPosition < 0) yPosition = 0;
            if (yPosition > 1 - flickable.visibleArea.heightRatio) yPosition = 1 - flickable.visibleArea.heightRatio;
            return orientation == Qt.Vertical ? yPosition * root.height : 0;
        }
        width: (orientation == Qt.Vertical ? 1 : flickable.visibleArea.widthRatio) * root.width
        height: (orientation == Qt.Vertical ? flickable.visibleArea.heightRatio : 1) * root.height

        drag.target: dragArea
        drag.axis: orientation == Qt.Vertical ? Drag.YAxis : Drag.XAxis
        drag.minimumY: 0
        drag.maximumY: root.height - dragArea.height
        drag.minimumX: 0
        drag.maximumX: root.width - dragArea.width

        onMouseXChanged: { flickable.contentX = dragArea.x / root.width * flickable.contentWidth; }
        onMouseYChanged: { flickable.contentY = dragArea.y / root.height * flickable.contentHeight; }

        Loader {
            id: dragLoader
            anchors.fill: parent
        }
    }
}
