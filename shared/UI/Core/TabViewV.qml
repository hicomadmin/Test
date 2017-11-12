import QtQuick 2.3
import Apps 1.0
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Core' as Core

Item {
    id: root

    property var appWindow
    property var application
    property var multiApplications

    property string tabsPosition: 'left'
    property string tabsItemType: 'button'
    property int count: tabsModel.length

    property alias tabStack   : tabStack.stack
    property alias tabs       : tabStack.elements
    property alias currentTab : tabStack.current
    property alias initialTab : tabStack.initial
    property alias initialOpts: tabStack.initialOpts

    property alias tabsContainer        : tabsContainer
    property alias tabsSpacing          : tabsContainer.spacing
    property alias tabsContainerImage   : tabsContainerImage
    property alias tabsContainerBgSource: tabsContainerImage.source

    property alias tabsRepeater: tabsRepeater
    property alias tabsModel   : tabsRepeater.model
    property alias tabsDelegate: tabsRepeater.delegate

    readonly property var switchTab: tabStack.changeTo

    Image {
        id:tabsContainerImage
        anchors.fill: tabsContainer
    }

    Column {
        id: tabsContainer
        anchors.left: tabsPosition === 'left' ? root.left : undefined
        anchors.right: tabsPosition === 'right' ? root.right : undefined
        Repeater {
            id: tabsRepeater
        }
    }

    HSElementContainer {
        id: tabStack
        height: parent.height
        anchors.left: tabsPosition === 'left' ? tabsContainer.right : root.left
        anchors.right: tabsPosition === 'right'  ? tabsContainer.left : root.right
        signalPrefix: 'tab'
        decorator: (function(curr, item, to, info, opts) {
            opts = opts || {}
            opts.properties = opts.properties || {}
            opts.properties.tabview = root
            opts.properties.application = application
            return opts
        })
    }
}
