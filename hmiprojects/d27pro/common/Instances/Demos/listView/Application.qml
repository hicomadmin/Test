import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
        main: { url: Qt.resolvedUrl('MainPage.qml'), title: '列表菜单'},
        ListViewA: { url: Qt.resolvedUrl('ListViewA.qml'), title: '列表A'},
        ListViewB: { url: Qt.resolvedUrl('ListViewB.qml'), title: '列表B'},
        ListViewC: { url: Qt.resolvedUrl('ListViewC.qml'), title: '列表C'},
        ListViewD: { url: Qt.resolvedUrl('ListViewD.qml'), title: '列表D'},
        FlickableA: { url: Qt.resolvedUrl('FlickableA.qml'), title: 'FlickableA'},
        FlickableB: { url: Qt.resolvedUrl('FlickableB.qml'), title: 'FlickableB'},
        FlickableC: { url: Qt.resolvedUrl('FlickableC.qml'), title: 'FlickableC'},
        FlickableD: { url: Qt.resolvedUrl('FlickableD.qml'), title: 'FlickableD'},
        ListUseLoader: { url: Qt.resolvedUrl('ListUseLoader.qml'), title: '有加载更多功能的列表'},
        ListUseRefresher: { url: Qt.resolvedUrl('ListUseRefresher.qml'), title: '有刷新功能的列表'}
    })
    initialPage: 'main'
}
