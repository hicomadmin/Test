import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
                main: { url: Qt.resolvedUrl('MainPage.qml'), title: '全部', hideBackBtn: false },
                media: { url: Qt.resolvedUrl('MediaPage.qml'), title: '多媒体', hideBackBtn: false }
    })
    initialPage: 'main'
}
