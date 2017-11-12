﻿import QtQuick 2.3
import Apps 1.0
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

Private.Control {
    id: root

    property string appId
    property string appTitle
    property var    appWindow
    property var    multiApplications

    property alias pageStack             : container.stack
    property alias pages                 : container.elements // id, cache, url, com, parent, title
    property alias currentPage           : container.current
    property alias initialPage           : container.initial
    property alias initialPageOnStart    : container.initialOnStart
    property alias initialProperties     : container.initialOpts

    readonly property var getPageInfo    : container.findInfo
    readonly property var removePage     : container.remove
    readonly property var changePage     : container.changeTo
    readonly property var back           : container.back
    readonly property var size           : container.size
    readonly property var currentPageInfo: container.currentInfo

    signal pageStackWillEmpty

    signal applicationRefreshed
    signal applicationAfterCreated
    signal applicationReadyShow
    signal applicationShowing
    signal applicationShown
    signal applicationFirstShown
    signal applicationReadyHide
    signal applicationHiding
    signal applicationHiden
    signal applicationFirstHiden
    signal applicationBeforeDestroyed
    signal applicationAfterDestroyed

    function __dispatchSignal(name) {
        var signal = pageStack['item' + name];
        if (signal) signal(currentPage)
    }

    onApplicationRefreshed: __dispatchSignal('Refreshed')
    onApplicationReadyShow: {
        visible = true
        __dispatchSignal('ReadyShow')
    }
    onApplicationShowing:    __dispatchSignal('Showing')
    onApplicationShown:      __dispatchSignal('Shown')
    onApplicationFirstShown: __dispatchSignal('FirstShown')
    onApplicationReadyHide:  __dispatchSignal('ReadyHide')
    onApplicationHiding:     __dispatchSignal('Hiding')
    onApplicationHiden: {
        visible = false
        __dispatchSignal('Hiden')
    }
    onApplicationFirstHiden: __dispatchSignal('FirstHiden')

    HSElementContainer {
        id: container
        anchors.fill: parent
        decorator: (function(curr, item, to, info, opts) {
            opts = opts || {}
            opts.properties = opts.properties || {}
            opts.properties.name        = to
            opts.properties.title       = opts.title || info.title
            opts.properties.application = root
            return opts
        })
        onStackWillEmpty: pageStackWillEmpty()
    }
}