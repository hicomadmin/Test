import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    property string amFm
    pages: ({
        main: { url: Qt.resolvedUrl('MainPage.qml'), title: qsTr('收音机') },
    })
    initialPage: 'main'
}
