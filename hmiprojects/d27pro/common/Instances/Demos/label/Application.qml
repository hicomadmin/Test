import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
        main: { url: Qt.resolvedUrl('MainPage.qml'), title: ''}
    })
    initialPage: 'main'
}
