import QtQuick 2.0

QtObject {
    property var rcCounter
    property var pluginMap: ({})

    onPluginMapChanged: {
        for (var key in pluginMap) {
            var info = pluginMap[key]
            console.debug("PluginDecorator: ", key, info.connect)
            if (info.connect) {
                info.connect(function() {
                    if (info.cond) HSStore.setData(info.rcId, true)
                })
            }
        }
    }

    function loadState(name) {
        var load = function(k) {
            var info = pluginMap[k]
            if (info) {
                var s = HSStore.datas[info.rcId]
                if (s === undefined || s) {
                    info.resume()
                }
                else {
                    info.pause()
                }
            }
        }
        if (name === undefined) {
            for (var key in pluginMap) {
                load(key)
            }
        }
        else load(name)
    }

    function resume(key) {
        var info = pluginMap[key]
        if (info) {
            rcCounter.clearRc(info.rcId)
            info.resume()
            HSStore.setData(info.rcId, true)
        }
    }

    function pause(key) {
        var info = pluginMap[key]
        if (info) {
            rcCounter.clearRc(info.rcId)
            info.pause()
            HSStore.setData(info.rcId, false)
        }
    }

    function tryPause(key, state) {
        console.debug("@@ PluginDecorator - tryPause:", key, state)
        var info = pluginMap[key]
        if (info) {
            if (rcCounter.incRc(info.rcId, state)) {
                var rc = rcCounter.rcInfo(info.rcId)
                console.debug("@@ PluginDecorator - pause:", key, "rc:", rc ? rc.rc : 0)
                info.pause()
            }
        }
    }

    function tryResume(key, op) {
        var info = pluginMap[key]
        var rc = rcCounter.rcInfo(info.rcId)
        console.debug("@@ PluginDecorator - tryResume:", key, op, "rc:", rc ? rc.rc : 0)
        if (info) {
            if (op === 1) {
                rcCounter.clearRc(info.rcId)
                console.debug("@@ PluginDecorator - resume:", key)
                info.resume()
                HSStore.setData(info.rcId, true)
            }
            else if (rcCounter.decRc(info.rcId)) {
                console.debug("@@ PluginDecorator - resume:", key)
                info.resume()
            }
        }
    }
}
