import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    property bool wndlinkFlag
    pages: ({
        main: { url: Qt.resolvedUrl('MainPage.qml'),hideStatusBar:true},
        help: { url: Qt.resolvedUrl('HelpPage.qml'),hideStatusBar:true}
    })
    initialPage: 'main'
}
