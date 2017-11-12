import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
        main: { url: Qt.resolvedUrl('MainPage.qml'), title: '菜单' },
        circleButtons: { url: Qt.resolvedUrl('CircleButtons.qml'), title: 'CircleButtons'},
        roundButtons: { url: Qt.resolvedUrl('RoundButtons.qml'), title: 'RoundButtons'} ,
        rectButtons: { url: Qt.resolvedUrl('RectButtons.qml'), title: 'RectButtons'},
        iconButtons: { url: Qt.resolvedUrl('IconButtons.qml'), title: 'IconButtons'}
            })
    initialPage: 'main'
}
