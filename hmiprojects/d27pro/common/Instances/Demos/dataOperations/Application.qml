import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
        main: { url: Qt.resolvedUrl('MainPage.qml'), title: '数据操作类'},
        RangeBar: { url: Qt.resolvedUrl('RangeBar.qml'), title: '区间条'}
    })
    initialPage: 'main'
}
