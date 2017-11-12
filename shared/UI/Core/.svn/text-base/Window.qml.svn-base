import QtQuick 2.3
import QtQuick.Window 2.2
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

Window {
    id: root
    title: ''
    visible: true
    flags: Qt.FramelessWindowHint
    color: "transparent"

    property alias useBg: bgImage.visible
    property alias bgSource: bgImage.source

    Image {
        id: bgImage
        width: root.width
        height: root.height
        source: bgSource
    }

    Component.onCompleted: {
        HSApps.initRootItem(root)
        JSLibs.initRootItem(root)
    }
}
