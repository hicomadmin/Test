import QtQuick 2.3
import Apps 1.0

Item {
    id: root

    property alias stack            : stack
    property alias signalPrefix     : stack.signalPrefix
    property alias elements         : stack.elSettings
    property alias current          : stack.currentId

    property string initial
    property bool   initialOnStart  : true
    property var    initialOpts     : ({})
    property var    decorator       : (function(){})
    property var    optsPreparer    : (function(){})

    readonly property var findInfo  : stack.findById
    readonly property var size      : stack.depth
    readonly property var clear     : stack.clear
    readonly property var remove    : stack.remove
    readonly property var back      : stack.back

    signal stackWillEmpty

    Component.onCompleted: {
        if (elements) {
            // add name property into element object
            for (var key in elements) {
                elements[key].name = key
                elements[key].cache = !!elements[key].cache
            }
        }

        // show first element
        if (initial && initialOnStart) {
            changeTo(initial, initialOpts)
        }
    }

    function changeTo(to, opts) {
        var info = elements[to]
        if (!info) return console.error('ElementContainer changes element failed: not set element.')

        /* BEGIN by Zhang Yi, 2016.12.01
         * Add this logic for keeping elements which need to be upper than the inEl.
        */
        var curr = current
        var item = currentInfo() ? currentInfo().item : undefined
        if (opts) opts['keep'] = 0
        else      opts = { keep: 0 }
        decorator(curr, item, to, opts)
        /* END - by Zhang Yi, 2016.12.01 */

        opts = opts || {}
        optsPreparer(info, to, opts)

        stack.changeTo(to, opts)
    }

    function currentInfo() {
        return stack.findById(current)
    }

    HSStackContainer {
        id: stack
        anchors.fill: parent
        onStackWillEmpty: root.stackWillEmpty()
    }
}
