import QtQuick 2.3
import Apps 1.0
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Core' as Core

Item {
    id: root

    property var appWindow
    property var application
    property var multiApplications

    property string tabsPosition: 'top'
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

    Row {
        id: tabsContainer
        anchors.top: tabsPosition === 'top' ? root.top : undefined
        anchors.bottom: tabsPosition === 'bottom' ? root.bottom : undefined
        Repeater {
            id: tabsRepeater
        }
    }

    HSElementContainer {
        id: tabStack
        width: parent.width
        anchors.top: tabsPosition === 'top' ? tabsContainer.bottom : root.top
        anchors.bottom: tabsPosition === 'bottom' ? tabsContainer.top : root.bottom
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
