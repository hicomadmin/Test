import QtQuick 2.3
import Apps 1.0
import TheXPresenter 1.0

import 'qrc:/UI/Core' as UCore
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

UCore.Window {
    id: root

    width: 1280
    height: 720

    Connections {
        target: ctranslator
        onThemeChanged: {
            switch (theme) {
            case HSTranslator.ThemeBlue  : root.bgSource = "qrc:/resources/BG.png"  ; break
            case HSTranslator.ThemeOrange: root.bgSource = "qrc:/resources/BG_o.png"; break
            case HSTranslator.ThemeGold  : root.bgSource = "qrc:/resources/BG_g.png"; break
            default: break
            }
        }
    }

    property var modeConfigs: ({})

    property var __currentPage
    property var __sourceInfo
    property var __rcs: ({})

    signal __pageChanging(string id)
    signal __pageChanged(string id)

    Component.onCompleted: {
        console.debug('root width: ',root.width);
        console.debug('stautesBar width: ',statusBar.width);
        console.debug('root id: ',root);
        console.debug('stautesBar id: ',statusBar.parent);

        HSPluginsManager.pluginsCreators = Qt.binding(function(){ return root.pluginsCreators })
        HSPluginsManager.pluginsSequence = Qt.binding(function(){ return root.pluginsSequence })

        var fmtInfo = function(info) {
            info = (typeof info === 'object') ? info : { src: info }
            if (typeof info.src === 'number') {
                info.bound = (typeof info.bound === 'number') ? info.bound : Constant._PAGE_BOUND_NONE
            }
            return info
        }
        var fmtFn = function(fn, def) {
            return fn || function() { return def }
        }

        for (var mode in modeConfigs) {
            modeConfigs[mode] = (typeof modeConfigs[mode] === 'object') ? modeConfigs[mode] : { info: modeConfigs[mode] }

            var config = modeConfigs[mode];
            config.info = fmtInfo(config.info)
            if (typeof config.info.src !== 'number') for (var page in config.info) {
                config.info[page] = fmtInfo(config.info[page])
            }

            config.guard = fmtFn(config.guard, true)
            config.opts  = fmtFn(config.opts , undefined)
        }

        var changePageFlag = function(newPage) {
            if (newPage !== '') {
                __pageChanging(newPage)
                __currentPage = newPage
                __pageChanged(__currentPage)
            }
        }
        var pageChanged = function() {
            changePageFlag(multiApplications.currentInfo().item.currentPage)
        }
        multiApplications.applicationStack.currentIdChanging.connect(function(newApplication) {
            var currentApplicationInfo = multiApplications.currentInfo()
            if (currentApplicationInfo && currentApplicationInfo.item) {
                currentApplicationInfo.item.currentPageChanged.disconnect(pageChanged)
            }
        })
        multiApplications.currentApplicationChanged.connect(function() {
            var currentApplicationInfo = multiApplications.currentInfo()
            if (currentApplicationInfo && currentApplicationInfo.item) {
                changePageFlag(multiApplications.currentInfo().item.currentPage)
                currentApplicationInfo.item.currentPageChanged.connect(pageChanged)
            }
            else __currentPage = ''
        })
    }

    function __currInfo(newPage) {
        var info
        var currentApplicationInfo = multiApplications.currentInfo()
        if (currentApplicationInfo && currentApplicationInfo.item) {
            info = modeConfigs[currentApplicationInfo.id]
            if (info) info = info.info
            if (info) {
                if (info[newPage || currentApplicationInfo.item.currentPage]) {
                    info = info[newPage || currentApplicationInfo.item.currentPage]
                }
            }
        }
        return info
    }

    function __hasPage(id) {
        if (!id) return false
        var ret = false
        multiApplications.applicationStack.foreachEl(function(el) {
            if (el && el.item && el.item.getInfo(id)) {
                ret = true
                return true
            }
            return false
        })
        return ret
    }

    on__PageChanging: {
        if (!__currentPage) {
            console.debug("@@@@ Showing statusBar...")
            statusBar.visible = true
        }
        if (__sourceInfo) {
            var newInfo = __currInfo(id)
            if (newInfo && newInfo.src === __sourceInfo.src) return
            switch (__sourceInfo.bound) {
            case Constant._PAGE_BOUND_CURRENT:
                HmiCommon.requireSourceOff(__sourceInfo.src)
                break
            case Constant._PAGE_BOUND_EXIST:
                if (__hasPage(__currentPage)) {
                    break
                }
                HmiCommon.requireSourceOff(__sourceInfo.src)
                break
            case Constant._PAGE_BOUND_NONE:
            default:
                break
            }
        }
    }

    on__PageChanged: {
        __sourceInfo = __currInfo()
        if (__sourceInfo) {
            console.debug("@@@@ on__PageChanged: ",
                          HmiCommon.source, "=> {", __sourceInfo.src, ",", __sourceInfo.bound, "}")
            if ((__sourceInfo.src !== undefined) && (__sourceInfo.src !== HmiCommon.source)) {
                HmiCommon.requireSourceOn(__sourceInfo.src)
            }
        }
    }

    property bool  hideStatusBar    : false
    property alias statusBar        : statusBar
    property bool  backBtnEnable    : true
    property alias multiApplications: multiApplications
    property var   pluginsCreators  : ({})
    property var   pluginsSequence  : []

    property bool useStatusAnimation: true
    property bool supportFullScreen : false

    ICore.StatusBar {
        id: statusBar
        z: supportFullScreen ? 1 : 0
        anchors.top: parent.top
        anchors.topMargin: hideStatusBar ? -height : 0
        visible: false

        onBack: {
            var currentApplicationInfo = multiApplications.currentInfo();
            if (currentApplicationInfo && currentApplicationInfo.item && backBtnEnable) {
                currentApplicationInfo.item.back();
            }
        }

        Behavior on anchors.topMargin {
            enabled: useStatusAnimation
            SequentialAnimation {
                PauseAnimation {
                    duration: 600
                }
                NumberAnimation {
                    easing.type: Easing.InOutCirc
                    duration: 600
                }
            }
        }
    }

    ICore.MultiApplications {
        id: multiApplications
        appWindow: root
        width: parent.width
        anchors.top: supportFullScreen ? parent.top : statusBar.bottom
        anchors.bottom: parent.bottom
    }

    function trySwitch(name) {
        var config = modeConfigs[name]
        if (!config) {
            multiApplications.changeApplication(name)
            return true
        }
        if (config.guard()) {
            multiApplications.changeApplication(name, config.opts())
            return true
        }
        return false
    }

    function hasSource(name, source) {
        var config = modeConfigs[name]
        if (!config) return false
        var info = config.info
        if (typeof info.src === 'number') {
            return info.src === source
        }
        for (var page in config.info) {
            if (typeof config.info[page].src === 'number') {
                if (config.info[page].src === source) return true
            }
        }
        return false
    }

    function incRc(name, value) {
        if (__rcs[name] && (typeof __rcs[name].rc === 'number')) {
            if (++(__rcs[name].rc) <= 0) __rcs[name].rc = 1
        }
        else __rcs[name] = { rc: 1 }
        if (__rcs[name].rc === 1) __rcs[name].flag = value
        return value
    }

    function decRc(name) {
        if (__rcs[name] && (typeof __rcs[name].rc === 'number')) {
            return (--(__rcs[name].rc) === 0) && __rcs[name].flag
        }
        else return false
    }

    function clearRc(name) {
        if (__rcs[name]) {
            __rcs[name] = { rc: 0 }
        }
    }

    function rcInfo(name) {
        return __rcs[name]
    }

    function createDialog(creator, properties) {
        var opts = {
            parent: root,
            properties: properties
        };
        var dialog;

        if (typeof creator === 'string') {
            dialog = JSLibs.createComponentObject(creator, opts);
        } else {
            dialog = JSLibs.createObject(creator, opts);
        }

        if (!dialog || typeof dialog === 'string') return console.error('VirtualApplication createDialog err: ', dialog || '');
        if (dialog.autoOpen) dialog.open();
        return dialog;
    }

    function createDialogAsync(creator, properties, cb) {
        var opts = {
            parent: root,
            properties: properties
        };

        var handler = function (err, dialog) {
            if (err) return console.error('VirtualApplication createDialogAsync err: ', err);

            if (dialog) {
                if (dialog.autoOpen) dialog.open();
                if (cb) cb(dialog);
            }
        };

        if (typeof creator === 'string') {
            JSLibs.createComponentObjectAsync(creator, opts, handler);
        } else {
            JSLibs.createObjectAsync(creator, opts, handler);
        }
    }
}
