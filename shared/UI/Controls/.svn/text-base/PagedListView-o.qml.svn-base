import QtQuick 2.3
import 'qrc:/UI/Private' as Private

Private.Control {
    id: root

    property alias usePaginationInfo: paginationInfoLoader.active
    property PaginationInfo paginationInfo: paginationInfoLoader.item

    property alias usePaginationLoader: paginationLoaderLoader.active
    property var paginationLoader: paginationLoaderLoader.item
    property PaginationLoaderDelegate paginationLoaderDelegate: PaginationLoaderDelegate{}

    property alias listView: listView
    property alias header: listView.header
    property alias model: listView.model
    property alias delegate: listView.delegate
    property alias section: listView.section
    property alias highlight: listView.highlight
    property alias footer: listView.footer
    property alias orientation: listView.orientation

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        snapMode: ListView.SnapToItem
    }
    Loader {
        id: paginationInfoLoader
        active: true
        sourceComponent: Component {
            PaginationInfo {
                flickable: listView
            }
        }
    }
    Loader {
        id: paginationLoaderLoader
        active: false
        sourceComponent: orientation === Qt.Horizontal
            ? paginationXComponent : paginationYComponent
    }
    Component {
        id: paginationYComponent
        PaginationYLoader {
            flickable: listView
            delegate: root.paginationLoaderDelegate
        }
    }

    Component {
        id: paginationXComponent
        PaginationXLoader {
            flickable: listView
            delegate: root.paginationLoaderDelegate
        }
    }

}
