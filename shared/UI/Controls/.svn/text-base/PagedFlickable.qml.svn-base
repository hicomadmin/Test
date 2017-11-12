import QtQuick 2.3
import 'qrc:/UI/Private' as Private

Private.Control {
    id: root

    property alias paginationInfo: paginationInfo
    property alias flickable: mainFlickable

    property bool delegateAsync: true
    property alias delegate: delegateLoader.sourceComponent
    property alias delegateSource: delegateLoader.source

    Flickable {
        id: mainFlickable
        anchors.fill: parent
        clip: true
        contentWidth: delegateLoader.width
        contentHeight: delegateLoader.height

        Loader {
            id: delegateLoader
            asynchronous: root.delegateAsync
        }
    }
    PaginationInfo {
        id: paginationInfo
        flickable: mainFlickable
    }
}
