import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

UControls.ListItemDelegateBase {
    width: 1040;
    height: 124;

    property bool useFirstLine: false
    property bool isFlickable: false
    property alias firstLineLoader: firstLineLoader
    property alias contentComponent: contentLoader.sourceComponent

    Loader {
        id: firstLineLoader
        active: !isFlickable ? (useFirstLine && index === 0) : false
        height: 1
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        sourceComponent: Component {
            Rectangle {
                color: '#777788'
            }
        }
    }
//    contentcompent: Component{
        Loader {
            id: contentLoader
            anchors.fill: parent;
        }
//    }

        Image {
            height: 8;
            width: parent.width;
            anchors.top:contentLoader.bottom;
            source: "qrc:/resources/list_lineA1.png";
        }
}



