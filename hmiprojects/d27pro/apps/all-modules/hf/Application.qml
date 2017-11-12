import QtQuick 2.3
import Bluetooth 1.0
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    id: hfRoot
    property string phoneType
    property bool pagechanged: false
    pages: ({
                main: {url: Qt.resolvedUrl('MainPage.qml'),title: qsTr('电话')},
                keyboardpage: {url: Qt.resolvedUrl('KeyBoardPage.qml'),title: qsTr('电话')},
            })
    initialPage: 'main'
}
