import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

Item {
    id: root
    width: 1040
    height: 420

    property alias useNavBar: navBarLoader.active
    property alias gridView: pagedGridView
    property alias model: pagedGridView.model
    property alias delegate: pagedGridView.delegate
    property alias highlight: pagedGridView.highlight

    property alias cellHeight: pagedGridView.cellHeight
    property alias cellWidth: pagedGridView.cellWidth

    property real bgLeftMargin: 0
    property real bgRightMargin: 0

    Rectangle {
        id: gridViewBg
        anchors {
            fill: parent
            leftMargin: root.bgLeftMargin
            rightMargin: root.bgRightMargin
        }
        color: '#00000000';

        UControls.PagedGridView {
            id: pagedGridView
            anchors.fill: parent
            UControls.Label {
                text: qsTr('数据加载中...')
                color: '#aaafbe'
                font.pixelSize: 18
                anchors.top: pagedGridView.gridView.bottom
                anchors.topMargin: 8
                anchors.horizontalCenter: pagedGridView.gridView.horizontalCenter
                visible: pagedGridView.paginationLoaderDelegate.processing
                         && pagedGridView.paginationLoaderDelegate.processingType === 2
            }
            IControls.MouseArea {
                id: processingMouseArea
                anchors.fill: parent
                visible: pagedGridView.paginationLoaderDelegate.processing
                         && (pagedGridView.paginationLoaderDelegate.processingType === 0
                            || pagedGridView.paginationLoaderDelegate.processingType === 1)

                Rectangle {
                    anchors.fill: parent
                    color: "#80000000"
                }
                UControls.Label {
                    color: '#ffffff'
                    font.pixelSize: 24
                    anchors.centerIn: parent
                    text: pagedGridView.paginationLoaderDelegate.processingType === 0 ?
                              qsTr('加载中...') : qsTr("正在扫描文件...")
                }
            }
        }
    }
    Loader {
        id: navBarLoader
        anchors {
            right: parent.right
            rightMargin: 0
            top: parent.top
        }
        sourceComponent: Component {
            IControls.ListNavBar {
                id: navBar
                width: 50;
                height: root.height;
                flickable: pagedGridView.gridView;
            }
        }
    }
}


