import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/Private' as Private

Private.Control {
    id: root

    property alias flickable: scrollBar.flickable
    property real navbarRightMargin: 0
    UControls.ScrollBar {
        id: scrollBar
        width: parent.width
        anchors {
            top:parent.top
            bottom: parent.bottom

        }
        bgComponent: Component {
            Item {
                Rectangle{
                    width: 9;
                    height: parent.height;
//                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: navbarRightMargin;
                    color: "transparent";
                }
            }
        }
        dragComponent: Component {
            Item {
                Rectangle{
                    width: 9;
                    height: parent.height;
//                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.right: parent.right;
                    anchors.rightMargin: navbarRightMargin;
                    color: '#5c5f61';
                }
            }
        }
    }
}

