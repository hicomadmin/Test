import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

Item {
    id: root
    width: 1040
    height: 420

    property alias useNavBar: navBarLoader.active
    property alias listView: pagedListView
    property alias model: pagedListView.model
    property alias delegate: pagedListView.delegate
    property alias section: pagedListView.section
    property alias highlight: pagedListView.highlight
    property alias p_header: pagedListView.l_header

    property real bgLeftMargin: 0
    property real bgRightMargin: 0
    property real navbarRightMargin: 0

    property int showType;

    Rectangle {
        id: listViewBg
        anchors {
            fill: root
            leftMargin: root.bgLeftMargin
            rightMargin: root.bgRightMargin
        }
        color: '#00000000';

        UControls.PagedListView {
            id: pagedListView
            anchors.fill: parent
            l_header:p_header
            listView.spacing: -1

            UControls.Label {
                text: qsTr('数据加载中...')
                color: '#aaafbe'
                font.pixelSize: 18
                anchors.top: pagedListView.listView.bottom
                anchors.topMargin: 8
                anchors.horizontalCenter: pagedListView.listView.horizontalCenter
                visible: pagedListView.paginationLoaderDelegate.processing
                         && pagedListView.paginationLoaderDelegate.processingType === 2
            }
            IControls.MouseArea {
                id: processingMouseArea
                anchors.fill: parent
                visible: pagedListView.paginationLoaderDelegate.processing
                         && (pagedListView.paginationLoaderDelegate.processingType === 0
                            || pagedListView.paginationLoaderDelegate.processingType === 1)

                Rectangle {
                    anchors.fill: parent
                    color: "#80000000"
                }
                UControls.Label {
                    color: '#ffffff'
                    font.pixelSize: 24
                    anchors.centerIn: parent
                    text: pagedListView.paginationLoaderDelegate.processingType === 0 ?
                              qsTr('加载中...') : showType == 1?qsTr("正在加载数据...") : qsTr("正在扫描文件...")
                }
            }
        }
    }
    Loader {
        id: navBarLoader
        anchors {
            right: root.right
            top: root.top
        }
        sourceComponent: Component {
            IControls.ListNavBar {
                id: navBar
                width: 50;
                height: root.height;
                flickable: pagedListView.listView;
                navbarRightMargin: root.navbarRightMargin;
            }
        }
    }
}
