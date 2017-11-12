import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

UControls.GridItemDelegateBase{
    id:root;

    property bool useFirstLine: false
    property bool isFlickable: false
    property alias firstLineLoader: firstLineLoader

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
}



