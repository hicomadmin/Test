import QtQuick 2.3
import Apps 1.0
import 'qrc:/UI/Private' as Private

Private.Control {
    id: root

    property Window appWindow

    property alias applicationStack         : container.stack
    property alias applications             : container.elements // id, cache, url, com, parent, title
    property alias currentApplication       : container.current
    property alias initialApplication       : container.initial
    property alias initialApplicationOnStart: container.initialOnStart

    readonly property var getInfo          : container.findInfo
    readonly property var remove           : container.remove
    readonly property var changeApplication: container.changeTo
    readonly property var back             : container.back
    readonly property var size             : container.size
    readonly property var currentInfo      : container.currentInfo

    signal stackWillEmpty

    function currentApplicationPageInfo() {
        var applicationInfo = currentApplicationInfo()
        var pageInfo
        if (applicationInfo && applicationInfo.item) {
            pageInfo = applicationInfo.item.currentInfo()
        }
        return pageInfo
    }

    HSElementContainer {
        id: container
        anchors.fill: parent
        signalPrefix: 'application'
        decorator: (function(curr, item, to, info, opts) {
            opts = opts || {}
            opts.properties = opts.properties || {}
            opts.properties.name      = to
            opts.properties.title     = opts.title || info.title
            opts.properties.appWindow = root.appWindow
            opts.properties.multiApplications = root
            return opts
        })
        onStackWillEmpty: stackWillEmpty()
        Component.onCompleted: {
            stack.itemAfterCreated.connect(function(id) {
                var applicationInfo = stack.findById(id)
                if (applicationInfo && applicationInfo.item) {
                    applicationInfo.item.stackWillEmpty.connect(function() {
                        remove(applicationInfo.id)
                    })
                }
            })
        }
    }
}
