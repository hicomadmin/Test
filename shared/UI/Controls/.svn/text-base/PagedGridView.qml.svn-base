import QtQuick 2.3
import 'qrc:/UI/Private' as Private

Private.Control {
    id: root

    property alias usePaginationInfo: paginationInfoLoader.active
    property PaginationInfo paginationInfo: paginationInfoLoader.item

    property alias usePaginationLoader: paginationLoaderLoader.active
    property var paginationLoader: paginationLoaderLoader.item
    property PaginationLoaderDelegate paginationLoaderDelegate: PaginationLoaderDelegate{}

    property alias gridView: gridView
    property alias header: gridView.header
    property alias model: gridView.model
    property alias delegate: gridView.delegate
    property alias highlight: gridView.highlight
    property alias footer: gridView.footer
    property alias cellWidth: gridView.cellWidth
    property alias cellHeight: gridView.cellHeight

    GridView {
        id: gridView
        anchors.fill: parent
        clip: true
        snapMode: GridView.SnapToRow
    }
    Loader {
        id: paginationInfoLoader
        active: true
        sourceComponent: Component {
            PaginationInfo {
                flickable: gridView
            }
        }
    }
    Loader {
        id: paginationLoaderLoader
        active: false
        sourceComponent: Component {
            PaginationYLoader {
                flickable: gridView
                delegate: root.paginationLoaderDelegate
            }
        }
    }
}
