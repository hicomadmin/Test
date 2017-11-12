import QtQuick 2.3

import Apps 1.0
import TheXSettings 1.0
import TheXPower 1.0
import TheXMcan 1.0
import TheXPresenter 1.0
import TheXAudio 1.0
import TheXRadio 1.0
import TheXVideo 1.0
import TheXMusic 1.0
import Bluetooth 1.0
import TheXAux 1.0
import TheXDevice 1.0
import TheXMRev 1.0
import TheXCarlife 1.0
import TheXEcolink 1.0
import TheXMirrorlink 1.0
import TheXMcan 1.0
import TheXMcanDiag 1.0

import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

ICore.VirtualApplication {
    id: homeRoot

    pages: ({
         home: { url: Qt.resolvedUrl('HomePage.qml'), title: qsTr('  '), hideBackBtn: true },
    })
    initialPage: 'home'

    property SystemCtl     system    : HSPluginsManager.get('system')
    property McanCtl       mcan      : HSPluginsManager.get('mcan')
    property MrevCtl       mrev      : HSPluginsManager.get('mrev')
    property PowerCtl      power     : HSPluginsManager.get('power')
    property DevCtl        devctl    : HSPluginsManager.get('devctl')
    property RadioCtl      radio     : HSPluginsManager.get('radio')
    property VideoCtl      videoctl  : HSPluginsManager.get('videoctl')
    property MusicCtl      musicctl  : HSPluginsManager.get('musicctl')
    property BtCtl         btctl     : HSPluginsManager.get('btctl')
    property AUXCtl        aux       : HSPluginsManager.get('aux')
    property CarlifeCtl    carlife   : HSPluginsManager.get('carlife')
    property EcolinkCtl    ecolink   : HSPluginsManager.get('ecolink')
    property MirrorlinkCtl mirrorlink: HSPluginsManager.get('mirrorlink')
    property McanDiagCtl   diag      : HSPluginsManager.get('diag')

    property var devType  : devctl.deviceInfo.devType
    property var devState : devctl.deviceInfo.devState
    property var mediaScanState: devctl.mediaInfo.mediaScanState
    property var playState: musicctl ? musicctl.playState : Constant._USB_MUSIC_STOP

    property int storeLastMconnect : 0
    property int storeLastExitCause: 0
    property int sourceActByMode: 0
    property bool isHomeReady: false

    onCurrentPageChanged: {
        var homePage = currentInfo().item
        homePage.readyToShow.connect(function() {
            HSApps.startToShow()

            var language = function() {
                console.log("[home Application] language =", system.language)
                ctranslator.load("d27", (system.language === 0) ? "zh_CN" : "en_US", []);
                mcan.setLanguage(system.language)
            }
            language()
            system.languageChanged.connect(language)

            var interfacemodel = function() {
                console.log("[home Application] interfacemodel =", system.interfacemodel)
                console.log("[home Application] theme =", ctranslator.theme)
                switch (system.interfacemodel) {
                case 0:
                    ctranslator.setQmlTheme(HSTranslator.ThemeBlue)
                    break
                case 1:
                    ctranslator.setQmlTheme(HSTranslator.ThemeOrange)
                    break
                default:
                    ctranslator.setQmlTheme(HSTranslator.ThemeGold)
                    break
                }
            }
            interfacemodel()
            system.interfacemodelChanged.connect(interfacemodel)

            requireAllDatas()

            console.debug("HmiCommon.requireSourceOn:", HSStore.datas.audioSource)
            var hasSwitched = false
            switch (HSStore.datas.audioSource) {
            case HmiCommon.SourceUSBVideo:
            case HmiCommon.SourceBTA:
            case HmiCommon.SourceECOLink:
                // Switching to Nothing...
                break
            default:
                if (HSStore.datas.audioSource !== undefined) {
                    for (var key in appWindow.modeConfigs) {
                        console.debug("[home Application] Checking:", key)
                        if (hasSource(key, HSStore.datas.audioSource)) {
                            if (appWindow.modeConfigs[key].guard()) {
                                console.debug("[home Application] Switching:", HSStore.datas.audioSource)
                                var task = getAudioTask(key)
                                if (task) {
                                    task()
                                }
                                else HmiCommon.requireSourceOn(HSStore.datas.audioSource)
                                hasSwitched = true
                            }
                            break
                        }
                    }
                }
                break
            }

            __readyTasks = []
            if (!hasSwitched) {
                console.debug("[home Application] Switching to Nothing...")
            }

            isHomeReady = true
        })
    }

    ////////////////////////////////////////////////////////////////
    // Functions

    property var __readyTasks: []

    function getAudioTask(name) {
        for (var i = 0; i < __readyTasks.length; ++i) {
            if (__readyTasks[i].name === name) {
                return __readyTasks[i].task
            }
        }
        return undefined
    }

    function tryAudioTask(name, task) {
        if (!(power.accState)) return
        if (isHomeReady) {
            task()
        }
        else {
            __readyTasks.push({ name: name, task: task })
        }
    }

    function requireAllDatas() {
        HSPluginsManager.foreachPlugin(function(plugin) {
            plugin.requireAllDatas(plugin)
        })
    }

    function tryPause(name) {
        if (name === undefined) {
            radio.tryPause()
            btctl.tryPause()
            musicctl.tryPause()
            videoctl.tryPause()
            carlife.tryPause()
        }
        else if(name === 'allNoCarlife')
        {
            radio.tryPause()
            btctl.tryPause()
            musicctl.tryPause()
            videoctl.tryPause()
        }
        else {
            plugins(name).tryPause()
        }
    }

    function tryResume(name) {
        if (name === undefined) {
            radio.tryResume()
            btctl.tryResume()
            musicctl.tryResume()
            videoctl.tryResume()
            carlife.tryResume()
        }
        else {
            plugins(name).tryResume()
        }
    }

    function hideMobileConnect(id) {
        console.log("-----[MBC] <home> [hideMobileConnect] hide(",id,"){1c,2e,3m}")

        switch (id) {
        case Constant._MOBILE_PROCESS_CARLIFE:
            carlife.displayCarlife(0)
            break;
        case Constant._MOBILE_PROCESS_ECOLINK:
            ecolink.setWndDisplay("2")
            break;
        case Constant._MOBILE_PROCESS_MIRRORLINK:
            mirrorlink.setMirrorlinkSrc("2")
            break;
        default:
            break;
        }
    }

    function showMobileConnect(id) {
        console.log("-----[MBC] <home> [showMobileConnect] show(",id,"){1c,2e,3m}")

        switch (id) {
        case Constant._MOBILE_PROCESS_CARLIFE:
            carlife.displayCarlife(1)
            break;
        case Constant._MOBILE_PROCESS_ECOLINK:
            ecolink.setWndDisplay("1")
            break;
        case Constant._MOBILE_PROCESS_MIRRORLINK:
            mirrorlink.setMirrorlinkSrc("1")
            break;
        default:
            break;
        }
    }

    function whoMobileConnectActive() {
        console.log("-----[MBC] <home> [whoMobileConnectActive] getactive mobile app(",multiApplications.currentApplication,")")

        if (multiApplications.currentApplication === 'carlife') {
            return Constant._MOBILE_PROCESS_CARLIFE
        }
        else if (multiApplications.currentApplication === 'ecolink') {
            return Constant._MOBILE_PROCESS_ECOLINK
        }
        else if (multiApplications.currentApplication === 'mirrorlink') {
            return Constant._MOBILE_PROCESS_MIRRORLINK
        }
        else {
            return 0;
        }
    }

    function cleanMobileConnect() {
        storeLastMconnect = 0
        storeLastExitCause = 0
    }

    function saveMobileConnect(cause, store) {
        if (store === true) {
            storeLastMconnect = whoMobileConnectActive()
            storeLastExitCause = cause
        }
        console.log("-----[MBC] <home> [saveMobileConnect] hide && store app , cause(",cause,"){0n,1e,2a,3r,4k} store(",store,"){0n,1y}")

        switch (cause) {
        case Constant._MC_CAUSE_NULL:
            break;
        case Constant._MC_CAUSE_EXIT_APP:
            break;
        case Constant._MC_CAUSE_AUX_COMMING:
            //display mobile connect app
            hideMobileConnect(whoMobileConnectActive())
            break;
        case Constant._MC_CAUSE_REV_COMMING:
            //display mobile connect app
            hideMobileConnect(whoMobileConnectActive())
            break;
        case Constant._MC_CAUSE_KEY_COMMING:
            hideMobileConnect(whoMobileConnectActive())
            break;
        case Constant._MC_CAUSE_MOD_COMMING:
            //response mode button
            hideMobileConnect(whoMobileConnectActive())
            break;
        default:
            break;
        }
    }

    function restoreMobileConnect() {
        console.log("-----[MBC] <home> [restoreMobileConnect] restore save app page ==> app(",storeLastMconnect,"){1c,2e,3m} exit cause(",storeLastExitCause,"){0n,1e,2a,3r,4k}")

        switch (storeLastExitCause) {
        case Constant._MC_CAUSE_NULL:
            break;
        case Constant._MC_CAUSE_EXIT_APP:
            break;
        case Constant._MC_CAUSE_AUX_COMMING:
            //display mobile connect app
            showMobileConnect(storeLastMconnect)
            break;
        case Constant._MC_CAUSE_REV_COMMING:
            //display mobile connect app
            showMobileConnect(storeLastMconnect)
            break;
        case Constant._MC_CAUSE_KEY_COMMING:
            break;
        default:
            break;
        }
    }

    function __muteMonitor() {
        if (!SoundCommon.mute) {
            statusBar.isMute = Qt.binding(function() { return SoundCommon.mute })
            SoundCommon.muteChanged.disconnect(__muteMonitor)
        }
    }

    function bingMuteMonitor(lastMute) {
        if (lastMute) {
            statusBar.isMute = Qt.binding(function() { return SoundCommon.mute })
        }
        else {
            SoundCommon.muteChanged.connect(__muteMonitor)
        }
    }

    ////////////////////////////////////////////////////////////////
    // Application slots

    onItemFirstShown: {
        if (system.mcuupdataflag) {
            multiApplications.changeApplication('settings', {properties: {initialPage: 'updatetest'}})
        }
        system.getAllInfo()
    }

    ////////////////////////////////////////////////////////////////
    // Connections

    Connections {
        target: system
        Component.onCompleted: {
            system.backlight = Qt.binding(function() {
                var bloff = (multiApplications.currentApplication === 'power') &&
                            (appWindow.__currentPage === 'main') &&
                            !((power.scc) && (power.accState))
                console.debug("[home Application] system.backlight:", system.backlight, '=>', !bloff)
                return !bloff
            })
        }
    }

    /* BEGIN by Zhang Yi, 2016.12.16
     * Move voice reminder logic to Application, not HomePage.
    */
    Connections {
        target: power

        onAccStateChanged: {
            HSStabilizer.receive('power.accState', (!power.accState), 500)
        }

        onPowerChanged: {
            if (power.accState) {
                onPowerStateChanged()
            }
        }

        onSccChanged: {
            if (power.accState) {
                onSccStateChanged()
            }
        }
    }

    Connections {
        target: mcan
        property var tm: null

        onShowRemindDialog: {
            console.debug("[home Application] onShowRemindDialog");
            voiceRemindIds = tipIds;
            parserVoiceRemindTips();
        }

        onHideRemindDialog: {
            console.debug("[home Application] onHideRemindDialog");
            if (voiceRemindDialog !== null)
            {
                voiceRemindDialog.close();
                voiceRemindDialog = null;
            }

            if ((voiceRemindIds instanceof Array) && voiceRemindIds.length > 0)
            {
                voiceRemindIds.splice(0, voiceRemindIds.length);
            }
        }

        onTrySwitchSourceOn: {
            switch (HmiCommon.source) {
            case HmiCommon.SourceHF:
                break
            case HmiCommon.SourceTTS:
                console.debug("[home Application] mcan.switchSourceOnSucc()")
                mcan.switchSourceOnSucc()
                break
            default:
                console.debug("[home Application] HmiCommon.requireSourceOn(HmiCommon.SourceTTS), power:", power.power)
                if (power.power) {
                    tryPause()
                    if (tm) {
                        JSLibs.clearTimeout(tm)
                        tm = null
                    }
                    if (!tm) tm = JSLibs.setTimeout(function() { HmiCommon.requireSourceOn(HmiCommon.SourceTTS); tm = null }, 500);
                }
                break
            }
        }

        onTrySwitchSourceOff: {
            console.debug("[home Application] onTrySwitchSourceOff")
            HmiCommon.requireSourceOff(HmiCommon.SourceTTS)
        }
    }
    /* END - by Zhang Yi, 2016.12.16 */

    Connections {
        target: HSStabilizer

        property real lastMediaVolume: -1

        onDispatch: {
            switch (id) {
            case 'power.accState':
                homeRoot.onAccStateChanged()
                break
            case 'mrev.revStatus':
                console.debug("[home Application] onRevStatusChanged lastMediaVolume =", lastMediaVolume, status)
                if (status) {
                    videoctl.tryPause()
                    JSLibs.setTimeout(function() {
                        system.revStart = true

                        JSLibs.setTimeout(function() {
                            /* BEGIN by Zhang Yi, 2016.11.08
                             * The display on/off logic.
                             * See: <HS-M1164 D27-V1.4.xlsx>, 13.2.4
                            */
                            if (statusDispPower === Constant._POWERON_DISPOFF) power.scc = true
                            /* END - by Zhang Yi, 2016.11.08 */

                            if (volDialog !== null) {
                                volDialog.close()
                            }

                            /* BEGIN by Zhang Yi, 2016.11.16
                             * Media volume shouln't be greater than 5 during rev.
                            */
                            if (SoundCommon.mediaVolume > 5) {
                                lastMediaVolume = SoundCommon.mediaVolume
                                SoundCommon.setMediaVolume(5)
                            }
                            /* END - by Zhang Yi, 2016.11.16 */
                        }, 100)

                    }, 200)
                }
                else {
                    if (lastMediaVolume >= 0) {
                        SoundCommon.setMediaVolume(lastMediaVolume)
                        lastMediaVolume = -1
                    }
                    system.revStart = false
                    JSLibs.setTimeout(function() { videoctl.tryResume() }, 200)
                }
                break
            }
        }
    }

    /* BEGIN by Zhang Yi, 2016.12.16
     * Move rev logic to Application, not HomePage.
    */
    Connections {
        target: mrev

        onRevStatusChanged: {
            console.debug("[home Application] onRevStatusChanged revStatus =", revStatus)
            HSStabilizer.receive('mrev.revStatus', revStatus, 800)
        }
    }
    /* END - by Zhang Yi, 2016.12.16 */

    /* BEGIN by Zhang Yi, 2016.12.16
     * Move device inserting/pulling logic to Application, not HomePage.
    */
    property bool radioPauseByDevIns: false
    Connections {
        target: devctl

        onDeviceInfoChanged: {
            var device = ''
            for (var item in deviceInfo) {
                var jValue = deviceInfo[item]
                device += (item + ":" + jValue + ", ")
            }
            console.debug("[home Application] onDeviceInfoChanged device : " + device)
        }

        onMediaInfoChanged: {
            var media = ''
            for (var item in mediaInfo) {
                var jValue = mediaInfo[item]
                media += (item + ":" + jValue + ", ")
            }
            console.debug("[home Application] onMediaInfoChanged media : " + media)
        }
    }

    onDevStateChanged: {
        console.debug("[home Application] onDevStateChanged devState:" + devState + " devType:" + devType + " devPreBoot:" + devctl.deviceInfo.devPreBoot)
        switch (devState) {
        case Constant._DEVICE_STATE_PULLOUT:
            switch (devType) {
                case Constant._DEVICE_TYPE_UDISK:
                    console.debug("[home Application] usb pullout!!!")
                    if (playState === Constant._USB_MUSIC_PLAYING) {
                        musicctl.stop()
                    }
                    multiApplications.remove('usb')
                    HmiCommon.requireSourceOff(HmiCommon.SourceUSBMP3)
                    power.updateErrState(PowerCtl.EN_DevAbnormalLevel_Inform, PowerCtl.EN_USB_UnConnected);
                    break
                case Constant._DEVICE_TYPE_IPOD:
                case 5:
                    if (HmiCommon.source === HmiCommon.SourceECOLink){
                        btctl.tryPause()
                        btctl.setAudioStreamMode(1);
                        console.debug("[MBC] [close bt-audio]")
                    }
                    break
                case Constant._DEVICE_TYPE_CARPLAY:
                    break
                case Constant._DEVICE_TYPE_ANDROID:
                    if (HmiCommon.source === HmiCommon.SourceECOLink){
                        btctl.tryPause()
                        btctl.setAudioStreamMode(1);
                        console.debug("[MBC] [close bt-audio]")
                    }
                    break
                case Constant._DEVICE_TYPE_UNKNOWN:
                    break
                default:
                    break
            }
            break;
        case Constant._DEVICE_STATE_INSERT:
            switch (devType) {
                case Constant._DEVICE_TYPE_UDISK:
                    console.debug("[home Application] usb insert!!!")

                    if (devctl.deviceInfo.devPreBoot) {
                        tryAudioTask('usb', function() {
                            if (HSStore.datas.audioSource === HmiCommon.SourceUSBMP3)
                                HmiCommon.requireSourceOn(HmiCommon.SourceUSBMP3)
                        })
                    }
                    else if (power.accState) {
                        if ((!radioPauseByDevIns) && (radio.openState)) {
                            radioPauseByDevIns = true
                            radio.tryPause()
                        }
                        clearPowerScreen()
                        trySwitch('usb')
                    }
                    power.updateErrState(PowerCtl.EN_DevAbnormalLevel_Inform, PowerCtl.EN_USB_Connected)
                    break
                case Constant._DEVICE_TYPE_IPOD:
                    break
                case Constant._DEVICE_TYPE_CARPLAY:
                case Constant._DEVICE_TYPE_ANDROID:
                    if ((!radioPauseByDevIns) && (radio.openState)) {
                        radio.tryPause()
                        radioPauseByDevIns = true
                    }

                    if (devctl.deviceInfo.devPreBoot) {
                        switch (system.mobileState) {
                        case 1:
                            tryAudioTask('carlife', function() {
                                if (HSStore.datas.audioSource === HmiCommon.SourceCarLife)
                                    HmiCommon.requireSourceOn(HmiCommon.SourceCarLife)
                            })
                            break
                        case 2:
                            tryAudioTask('ecolink', function() {
                                if (HSStore.datas.audioSource === HmiCommon.SourceECOLink)
                                    HmiCommon.requireSourceOn(HmiCommon.SourceECOLink)
                            })
                            break
                        case 3:
                            tryAudioTask('mirrorlink', function() {
                                if (HSStore.datas.audioSource === HmiCommon.SourceMirrLink)
                                    HmiCommon.requireSourceOn(HmiCommon.SourceMirrLink)
                            })
                            break
                        default:
                            break
                        }
                    }
                    else if (power.accState) {
                        clearPowerScreen()
                        if (multiApplications.currentApplication !== 'carlife' &&
                            multiApplications.currentApplication !== 'ecolink' &&
                            multiApplications.currentApplication !== 'mirrorlink') {
                            console.log("[MBC] <home> [onDevStateChanged][PI] from app(", multiApplications.currentApplication, ") page goto ==> app(", system.mobileState, "){1c,2e,3m}")
                            if (system.mobileState === 1) {
                                trySwitch('carlife')
                            }
                            else if (system.mobileState === 2) {
                                trySwitch('ecolink')
                            }
                            else if (system.mobileState === 3) {
                                trySwitch('mirrorlink')
                            }
                        }
                    }
                    break
                case Constant._DEVICE_TYPE_UNKNOWN:
                default:
                    break
            }
            break;
        case Constant._DEVICE_STATE_UNKNOWN:
        default:
            switch (devType) {
                case Constant._DEVICE_TYPE_UDISK:
                    if (devctl.deviceInfo.devPreBoot) {
                        tryAudioTask('usb', function() {
                            if (HSStore.datas.audioSource !== HmiCommon.SourceUSBMP3)
                                HmiCommon.requireSourceOn(HmiCommon.SourceUSBMP3)
                        })
                    }
                    else if (power.accState) {
                        clearPowerScreen()
                        trySwitch('usb')
                    }
                    break
                case Constant._DEVICE_TYPE_IPOD:
                    break
                case Constant._DEVICE_TYPE_CARPLAY:
                    break
                case Constant._DEVICE_TYPE_ANDROID:
                    break
                case Constant._DEVICE_TYPE_UNKNOWN:
                default:
                    break
            }
            break;
        }

        //update usb mifi state by Zhao Xing
        //updateUsbMIFIState(devState, devType);
    }

    Connections {
        target: aux

        onAuxReadyChanged: {
            console.debug("[home Application] onAuxReadyChanged auxReady:" + auxReady)
            if (auxReady) {
                tryAudioTask('aux', function() {
                    clearPowerScreen()

                    //tuhaoming:
                    console.log("[MBC] <home> [onAuxReadyChanged]{interrupt}[",(auxReady === true)?"PI":"PO","]")
                    saveMobileConnect(Constant._MC_CAUSE_AUX_COMMING,false);

                    trySwitch('aux')
                })
            }
            else {
                multiApplications.remove('aux')
                HmiCommon.requireSourceOff(HmiCommon.SourceAUX)
            }
        }
    }
    /* END - by Zhang Yi, 2016.12.16 */

    Connections {
        target: musicctl

        onPlayStateChanged: {
            console.debug("[home Application] musicctl.onPlayStateChanged", playState,
                          ", audioSource:", SoundCommon.audioSource, "Hmi.source:", HmiCommon.source)
            if (playState === Constant._USB_MUSIC_PLAYING) {
                if (HmiCommon.source !== HmiCommon.SourceUSBMP3) {
                    musicctl.pause()
                }
                else HSStore.setData('MusicCtl.playState', true)
            }
        }
    }

    /* BEGIN by Zhang Yi, 2016.12.16
     * Move HF logic to Application, not HomePage.
    */
    property bool isCalling: false
    property bool isBTAConnected: false

    Connections {
        target: btctl

        onTelStatusChanged: {
            console.debug('[home Application] btctl.onTelStatusChanged:', telStatus)

            if (telStatus === 7) {
                isCalling = false
            }
            else {
                if (!isCalling) {
                    isCalling = true
                    tryPause('allNoCarlife')
                }
                trySwitch('hfcall')
            }

            /* BEGIN by Zhou Yongwu at 2016-12-02
             * Power & display should be both on when receive telephone
             */
            clearPowerScreen()
            /* END by Zhou Yongwu at 2016-12-02*/
        }

        /**
          * gewei at 2017-1-5
          * no bta source, not play bt audio;
        **/
        onPlaybackstateChanged: {
            console.debug("[home Application] btctl.onPlaybackstateChanged", playbackstate, HmiCommon.source)
            if (playbackstate == 1) {
                if (HmiCommon.source != HmiCommon.SourceBTA && HmiCommon.source != HmiCommon.SourceECOLink && HmiCommon.source != HmiCommon.SourceAUX) {
                    btctl.plugin_musicPause()
                }
                else HSStore.setData('BtCtl.playbackstate', true)
            }
        }

        onConnectStateChanged: {
            var c = ((connectState & 0x0f) === 0x01)
            console.debug("[home Application] btctl.onConnectStateChanged", connectState, c)
            if (c !== isBTAConnected) {
                isBTAConnected = c
                btaConnectedChanged()
            }
        }
    }

    function btaConnectedChanged() {
        console.debug("[home Application] onIsBTAConnected", isBTAConnected)
        if (isBTAConnected) {
            console.debug("[home Application] bt audio connected")
            if (HmiCommon.source === -1 && (HSStore.datas.audioSource === HmiCommon.SourceBTA || HmiCommon.source == HmiCommon.SourceECOLink)) {
                HmiCommon.requireSourceOn(HSStore.datas.audioSource)
            }
            if (HmiCommon.source != HmiCommon.SourceBTA && HmiCommon.source != HmiCommon.SourceECOLink && HmiCommon.source != HmiCommon.SourceAUX) {
                console.debug("[home Application] bt audio stop")
                btctl.plugin_musicPause();
            }
            power.updateErrState(PowerCtl.EN_DevAbnormalLevel_Inform, PowerCtl.EN_BT_Connected);
        }
        else {
            multiApplications.remove('btaudio')
            if (power.accState) HmiCommon.requireSourceOff(HmiCommon.SourceBTA)
            power.updateErrState(PowerCtl.EN_DevAbnormalLevel_Inform, PowerCtl.EN_BT_UnConnected);
        }
    }
    /* END - by Zhang Yi, 2016.12.16 */

    property var __lastMute

    /* BEGIN by Zhang Yi, 2016.12.16
     * Move source switching & hk logic to Application, not HomePage.
    */
    Connections {
        target: HmiCommon

        property int lastSrc: HmiCommon.SourceRadio
        property int lastK: -1

        Component.onCompleted: {
            lastSrc = HmiCommon.source
        }

        onSourceChanged: {
            switch (HmiCommon.source) {
            case HmiCommon.SourceHF:
                console.debug("[home Application] mcan.stopRemindFromHMI()")
                mcan.stopRemindFromHMI()
                break
            case HmiCommon.SourceTTS:
                console.debug("[home Application] mcan.switchSourceOnSucc()")
                mcan.switchSourceOnSucc()
                break
            default:
                if (isHomeReady) {
                    HSStore.setData('audioSource', HmiCommon.source)
                }
                if (lastSrc === HmiCommon.SourceHF) {
                    mcan.playRemindFromHMI()
                }
                break
            }
            lastSrc = HmiCommon.source
        }

        onStopSource: {
            console.debug("[home Application] onStopSource:", source, "=>", next)
            if (next === HmiCommon.SourceHF ||
                next === HmiCommon.SourceTTS) {
                // Do Nothing.
                return
            }
            switch (source) {
            case HmiCommon.SourceRadio:
                if (!radioPauseByDevIns) {
                    radio.tryPause()
                }
                radioPauseByDevIns = false
                break
            case HmiCommon.SourceUSBMP3:
                if (next === HmiCommon.SourceUSBVideo) {
                    if (playState === Constant._USB_MUSIC_PLAYING) musicctl.pause()
                }
                else musicctl.tryPause()
                break
            case HmiCommon.SourceUSBVideo:
                videoctl.tryPause()
                break
            case HmiCommon.SourceBTA:
                btctl.setAudioStreamMode(1)
                btctl.tryPause()
                break
            case HmiCommon.SourceHF:
                if (__lastMute !== undefined) {
                    SoundCommon.setMute(__lastMute)
                    __lastMute = undefined
                }
                break
            case HmiCommon.SourceCarLife:
                carlife.tryPause()
                break
            default:
                break
            }
        }

        function hkGuard(keycode) {

            /* BEGIN by Zhang Yi, 2016.11.10
             * If the current status is mrev.revStatus, All keys shouldn't be responded.
             * See: Bug #93, #32, #157.
            */
            if (mrev.revStatus) return false
            /* END - by Zhang Yi, 2016.11.10 */

            /* BEGIN by Zhang Yi, 2016.11.16
             * Panel keys shouldn't be responded during HF.
             * See: Bug #404.
            */
            if (HmiCommon.source === HmiCommon.SourceHF) {
                switch (keycode[0]) {
                case HmiCommon.AUDIO_PANEL_VOLUME_INC:
                case HmiCommon.AUDIO_PANEL_VOLUME_DEC:
                case HmiCommon.AUDIO_SWC_MUTE:
                case HmiCommon.AUDIO_SWC_BTANSWER:
                case HmiCommon.AUDIO_SWC_BTHANDUP:
                case HmiCommon.AUDIO_SWC_VOLUME_INC:
                case HmiCommon.AUDIO_SWC_VOLUME_DEC:
                    break
                default:
                    return false
                }
            }
            /* END - by Zhang Yi, 2016.11.16 */

            /* BEGIN by Zhang Yi, 2016.11.08
             * The display on/off logic.
             * See: <HS-M1164 D27-V1.5.xlsx>, 13.2.4
            */
            if ((keycode[1] === HmiCommon.KEY_STA_RELEASED) ||
                (keycode[1] === HmiCommon.KEY_STA_CLICK)) {
                if (statusDispPower === Constant._POWERON_DISPOFF) {
                    switch (keycode[0]) {
                    case HmiCommon.AUDIO_PANEL_VOLUME_INC:
                    case HmiCommon.AUDIO_PANEL_VOLUME_DEC: // Do function, no display-on
                    case HmiCommon.AUDIO_SWC_MUTE:
                    case HmiCommon.AUDIO_SWC_VOLUME_INC:
                    case HmiCommon.AUDIO_SWC_VOLUME_DEC:
                        break
                    default:
                        power.scc = true
                        return false
                    }
                }
                else if (statusDispPower === Constant._POWEROFF_DISPOFF) {
                    power.scc = true
                    return false
                }
            }
            /* END - by Zhang Yi, 2016.11.08 */

            /* BEGIN by Zhang Yi, 2016.11.10
             * If the current status is power-off, Keys shouldn't be responded.
             * See: Bug #516.
            */
            if (!(power.power) && (keycode[0] !== HmiCommon.AUDIO_PANEL_PWR) &&
                                  (keycode[0] !== HmiCommon.AUDIO_PANEL_DISP)) return false
            /* END - by Zhang Yi, 2016.11.10 */

            return true
        }

        property bool longPressedFlag: false

        onKeyEvent: {
            console.debug("[home Application] key:", keycode[0], "state:", keycode[1])

            if (!hkGuard(keycode)) return

            switch (keycode[0]) {
            case HmiCommon.AUDIO_PANEL_DISP:
                if (keycode[1] === HmiCommon.KEY_STA_RELEASED) {
                    console.debug("[home Application] AUDIO_PANEL_DISP: KEY_STA_RELEASED")
                    SoundCommon.beep(0)

                    if (power.scc === true) {
                        console.log("[MBC] <home> [AUDIO_PANEL_DISP]{interrupt}[IN]<",power.scc,">")
                        saveMobileConnect(Constant._MC_CAUSE_KEY_COMMING, false)
                    }

                    /* BEGIN by Zhang Yi, 2016.11.08
                     * The display on/off logic.
                     * See: <HS-M1164 D27-V1.4.xlsx>, 13.2.4
                    */
                    // Here must be POWERON_DISPON or POWEROFF_DISPON
                    power.scc = !(power.scc)
                    /* END - by Zhang Yi, 2016.11.08 */

                }
                break;
            case HmiCommon.AUDIO_PANEL_HOME:
                if (keycode[1] === HmiCommon.KEY_STA_RELEASED) {
                    if (multiApplications.currentApplication !== 'home') {
                        //tuhaoming:
                        console.log("[MBC] <home> [AUDIO_PANEL_HOME]{interrupt}[IN]")
                        SoundCommon.beep(0)
                        saveMobileConnect(Constant._MC_CAUSE_KEY_COMMING, false)
                        multiApplications.changeApplication('home', {properties: {initialPage: "home"}, force: 2});
                    }
                }
                break;
            case HmiCommon.AUDIO_PANEL_PWR:
                console.debug('[home Application] power.power:', power.power, 'power.scc:', power.scc);
                if (keycode[1] === HmiCommon.KEY_STA_RELEASED) {
                    SoundCommon.beep(0)
                    saveMobileConnect(Constant._MC_CAUSE_KEY_COMMING,false)
                    power.power = !(power.power)
                }
                break;
            /* BEGIN by Zhang Yi, 2016.11.17
             * Response vol changing request.
            */
            case HmiCommon.AUDIO_PANEL_VOLUME_INC:
            case HmiCommon.AUDIO_PANEL_VOLUME_DEC:
                if (keycode[1] === HmiCommon.KEY_STA_CLICK) {
                    SoundCommon.beep(0)
                    setVolume(keycode[0] === HmiCommon.AUDIO_PANEL_VOLUME_INC, times)
                }
                break
            /* END - by Zhang Yi, 2016.11.17 */
            case HmiCommon.AUDIO_SWC_MUTE:
                if (keycode[1] === HmiCommon.KEY_STA_RELEASED) {
                    SoundCommon.beep(0)
                    SoundCommon.setMute(!(SoundCommon.mute))
                }
                break;
            case HmiCommon.AUDIO_SWC_MODE:
                if (keycode[1] === HmiCommon.KEY_STA_RELEASED) {
                    console.debug("[home Application] AUDIO_SWC_MODE -- usbState:", (devState === Constant._DEVICE_STATE_INSERT && devType === Constant._DEVICE_TYPE_UDISK), ", btstate:" , btctl.connectState)
                    SoundCommon.beep(0)
                    saveMobileConnect(Constant._MC_CAUSE_MOD_COMMING, false)
                    var source = HmiCommon.source
                    console.debug("[home Application] AUDIO_SWC_MODE -- current source:", source)
                    var _MODE_LIST = ['radio','usb','btaudio','aux']
                    var k = 0
                    for (; k < _MODE_LIST.length; ++k) {
                        if (hasSource(_MODE_LIST[k], source))
                            break
                    }
                    console.debug("[home Application] AUDIO_SWC_MODE -- locate source index:", k, lastK)
                    if (k >= _MODE_LIST.length) {
                        // Unfound...
                        k = lastK
                    }
                    var start_k = k
                    while (true) {
                        ++k
                        if (k >= _MODE_LIST.length) k = 0
                        console.debug("[home Application] AUDIO_SWC_MODE -- current:", k)
                        if (k === start_k) break
                        console.debug("[home Application] AUDIO_SWC_MODE -- _MODE_LIST[k]:", _MODE_LIST[k])
                        if (trySwitch(_MODE_LIST[k])) {
                            sourceActByMode = 1
                            break
                        }
                    }
                    lastK = k
                }
                break

            /* BEGIN by Zhang Yi, 2016.11.09
             * Append swc long press logic.
             * See: <HS-M1164 D27-V1.4.xlsx>, 12.1
            */
            case HmiCommon.AUDIO_SWC_BTANSWER:
                if (keycode[1] === HmiCommon.KEY_STA_RELEASED) {
                    if (longPressedFlag) {
                        longPressedFlag = false
                        break
                    }
                    console.debug("[home Application] AUDIO_SWC_BTANSWER: source =", HmiCommon.source)
                    switch (HmiCommon.source) {
                    case HmiCommon.SourceRadio:
                        SoundCommon.beep(0)
                        radio.recallPreset(2, 1)
                        break
                    case HmiCommon.SourceBTA:
                    case HmiCommon.SourceECOLink:
                        SoundCommon.beep(0)
                        btctl.preTrack()
                        break
                    case HmiCommon.SourceUSBMP3:
                        SoundCommon.beep(0)
                        musicctl.previous()
                        break
                    case HmiCommon.SourceHF:
                        if (btctl.telStatus === 1) {
                            SoundCommon.beep(0)
                            btctl.answerCall(false)
                        } else if (btctl.telStatus === 2) {

                        }
                        break
                    default:
                        break
                    }
                }
                else if (keycode[1] === HmiCommon.KEY_STA_LONG_PRESSED) {
                    switch (HmiCommon.source) {
                    case HmiCommon.SourceRadio:
                        SoundCommon.beep(0)
                        if (radio.radioState === 2) {
                            radio.radioSeekDown(0)
                        }
                        else {
                            radio.radioSeekDown(1)
                        }
                        longPressedFlag = true
                        break
                    default:
                        break
                    }
                }
                break
            case HmiCommon.AUDIO_SWC_BTHANDUP:
                if (keycode[1] === HmiCommon.KEY_STA_RELEASED) {
                    if (longPressedFlag) {
                        longPressedFlag = false
                        break
                    }
                    console.debug("[home Application] AUDIO_SWC_BTHANDUP: source =", HmiCommon.source)
                    switch (HmiCommon.source) {
                    case HmiCommon.SourceRadio:
                        SoundCommon.beep(0)
                        radio.recallPreset(2, 2)
                        break
                    case HmiCommon.SourceBTA:
                    case HmiCommon.SourceECOLink:
                        SoundCommon.beep(0)
                        btctl.nextTrack()
                        break
                    case HmiCommon.SourceUSBMP3:
                        SoundCommon.beep(0)
                        musicctl.next()
                        break
                    case HmiCommon.SourceHF:
                        SoundCommon.beep(0)
                        if (btctl.telStatus === 1) {
                            btctl.refuseCall()
                        } else if (btctl.telStatus === 2) {
                            btctl.hangUp()
                        }
                        break
                    default: break
                    }
                }
                else if (keycode[1] === HmiCommon.KEY_STA_LONG_PRESSED) {
                    switch (HmiCommon.source) {
                    case HmiCommon.SourceRadio:
                        SoundCommon.beep(0)
                        if (radio.radioState === 1) {
                            radio.radioSeekUp(0)
                        }
                        else {
                            radio.radioSeekUp(1)
                        }
                        longPressedFlag = true
                        break
                    default:
                        break
                    }
                }
                break
            /* END - by Zhang Yi, 2016.11.09 */

            /* BEGIN by Zhou Yongwu, 2016.11.09
             * Bug #487 Change the mute logic
             * See: <HS-M1164 D27-V1.4.xlsx>, 13.2.4
            */
            case HmiCommon.AUDIO_SWC_VOLUME_INC:
            case HmiCommon.AUDIO_SWC_VOLUME_DEC:
                if (keycode[1] === HmiCommon.KEY_STA_PRESSED) {
                    /* BEGIN by Zhang Yi, 2016.11.17
                     * Response vol changing request.
                    */
                    setVolume(keycode[0] === HmiCommon.AUDIO_SWC_VOLUME_INC, 1)
                    /* END - by Zhang Yi, 2016.11.17 */
                }
                /* BEGIN by Zhang Yi, 2016.11.10
                 * Append vol-key long press logic.
                 * See: <HS-M1164 D27-V1.4.xlsx>, 12.2.2 & 12.2.3
                */
                else if ((keycode[1] === HmiCommon.KEY_STA_LONG_PRESSED) ||
                         (keycode[1] === HmiCommon.KEY_STA_HOLDING)) {
                    setVolume(keycode[0] === HmiCommon.AUDIO_SWC_VOLUME_INC, 4)
                }
                /* END - by Zhang Yi, 2016.11.10 */
                break
            /* END by Zhou Yongwu, 2016.11.09*/
            default: break;
            }
        }
    }
    /* END - by Zhang Yi, 2016.12.16 */

    Connections {
        target: diag

        onSystemSwitchChanged: {
            console.debug("[home Application] diag radio status:", param);
            if (HmiCommon.source === HmiCommon.SourceRadio) {
                if (Constant._DIAG_SYSTEM_RADIO_OPEN === param) {
                    radio.radioOpen();
                }
                else {
                    radio.radioClose();
                }
            }
        }

        onSystemModeChanged: {
            switch (param) {
            case Constant._DIAG_SYSTEM_SOURCE_TUNER:
                trySwitch('radio')
                break;
            case Constant._DIAG_SYSTEM_SOURCE_USB:
                trySwitch('usb')
                break;
            case Constant._DIAG_SYSTEM_SOURCE_BT:
                trySwitch('btaudio')
                break;
            case Constant._DIAG_SYSTEM_SOURCE_AUX:
                trySwitch('aux')
                break;
            default:
                break;
            }
        }

        onVolumeAdjustChanged: {
            if ((Constant._DIAG_VOLUME_MIN <= param) && (param <= Constant._DIAG_VOLUME_MAX)) { // set volume
                directVolume(param)
            }
            else {
                setVolume(Constant._DIAG_VOLUME_ADD === param, 1)
            }
        }

        onVulomeMuteChanged: {
            if (Constant._DIAG_SET_MUTE == param) {
                SoundCommon.setMute(true);
            }
            else {
                SoundCommon.setMute(false);
            }
        }

        onPlayAdjustChanged: {
            if (HmiCommon.source === HmiCommon.SourceUSBMP3) {
                switch (param) {
                case Constant._DIAG_PLAY_ADJUST_PALY:
                    musicctl.play(0, Constant._USB_MUSIC_PLAY_POSITION);
                    break;
                case Constant._DIAG_PLAY_ADJUST_PAUSE:
                    musicctl.pause();
                    break;
                case Constant._DIAG_PLAY_ADJUST_FAST_FORWARD:
                    break;
                case Constant._DIAG_PLAY_ADJUST_FAST_REWARD:
                    break;
                case Constant._DIAG_PLAY_ADJUST_SKIP_NEXT:
                    musicctl.next();
                    break;
                case Constant._DIAG_PLAY_ADJUST_SKIP_PREVIOUS:
                    musicctl.previous();
                    break;
                default:
                    break;
                }
            }
        }

        onFreqTuneChanged: {
            var diagband = 0; // diag band value
            var band = 0;  // real band value
            var freq = 0; // diag frequence
            var radioBandArr = [
                Constant._RADIO_BAND_FM1, Constant._RADIO_BAND_FM2, Constant._RADIO_BAND_FM3,
                Constant._RADIO_BAND_AM1, Constant._RADIO_BAND_AM2
            ];

            if (HmiCommon.source === HmiCommon.SourceRadio) {
                diagband = array[0]; //第1个字节，表示收音波段Band；
                freq = (array[1] << 8) | array[2]; // 第2和3个字节表示频率
                console.debug("!!!!!!!!!!!!!!!!!!!!!!array 1 2 3:", array[0], array[1], array[2]);
                console.debug("!!!!!!!!!!!!!!!!!!!!!!diagband:", diagband, "  freq:", freq);
                if ((Constant._DIAG_FM1_FREQ == diagband) || (Constant._DIAG_FM2_FREQ == diagband) || (Constant._DIAG_FM3_FREQ == diagband)) {
                    diagband--; // diag value: 1, 2, 3, 4, 5
                    band = radioBandArr[diagband];
                    if ((Constant._DIAG_FM_FREQ_MIN <= freq) && (freq <= Constant._DIAG_FM_FREQ_MAX)) {
                        console.debug("[home Application] diag radio setFrequency: ", band, freq);
                        radio.setFrequency(band, freq);
                    }
                }
                else if ((Constant._DIAG_AM1_FREQ == diagband) || (Constant._DIAG_AM2_FREQ == diagband)) {
                    diagband--; // diag value: 1, 2, 3, 4, 5
                    band = radioBandArr[diagband];
                    if ((Constant._DIAG_AM_FREQ_MIN <= freq) && (freq <= Constant._DIAG_AM_FREQ_MAX)) {
                        console.debug("[home Application] diag radio setFrequency: ", band, freq);
                        radio.setFrequency(band, freq);
                    }
                }
            }
        }

        onBandTuneChanged: {
            var band = 0;
            var radioBandArr = [
                Constant._RADIO_BAND_FM1, Constant._RADIO_BAND_FM2, Constant._RADIO_BAND_FM3,
                Constant._RADIO_BAND_AM1, Constant._RADIO_BAND_AM2
            ];

            if (HmiCommon.source === HmiCommon.SourceRadio) {
                console.debug("multiApplications.currentApplication == radio");
                band = param - 1; // diag value: 1, 2, 3, 4, 5
                if (band < Constant._DIAG_RADIO_BAND_COUNT) {
                    console.debug("[home Application] setRadioBand:", radioBandArr[band]);
                    //radio.setRadioBand(radioBandArr[band]); // set radio band
                    radio.setFrequency(radioBandArr[band],0);
                    radio.getPresetList(radioBandArr[band]);
                }
            }
        }

        onScanAdjustChanged: {
            if (HmiCommon.source === HmiCommon.SourceRadio) {
                var band = radio.radioBand;
                var step = 1;

                if ((Constant._RADIO_BAND_FM1 == band) || (Constant._RADIO_BAND_FM2 == band) || (Constant._RADIO_BAND_FM3 == band)) {
                    step = 2;
                }
                else if ((Constant._RADIO_BAND_AM1 == band) || (Constant._RADIO_BAND_AM2 == band)) {
                    step = 1;
                }


                switch (param) {
                case Constant._DIAG_SCAN_ADJUST_AUTO_SEEK_DOWN:
                    radio.radioSeekDown(step); // seek down start
                    break;
                case Constant._DIAG_SCAN_ADJUST_AUTO_SEEK_UP:
                    radio.radioSeekUp(step); // seek up start
                    break;
                case Constant._DIAG_SCAN_ADJUST_MANUAL_SEEK_DOWN:
                    radio.setTuneDown(step); // seek down 1 step
                    break;
                case Constant._DIAG_SCAN_ADJUST_MANUAL_SEEK_UP:
                    radio.setTuneUp(step); // seek up 1 step
                    break;
                default:
                    break;
                }
            }
        }
    }

    /* BEGIN by Zhao Xing, 2016.12.15
     * add voice remind diag
    */
    property var voiceRemindDialog: null
    property var voiceRemindIds: new Array
    property string message
    property string image

    function parserVoiceRemindTips()
    {
        console.debug("[home Application] parserVoiceRemind");
        if (voiceRemindIds instanceof Array) {
            console.debug("[home Application] parserVoiceRemind is array ", voiceRemindIds.length);
            if (voiceRemindIds.length < 0)
            {
                return;
            }

            var remindId = voiceRemindIds[0]
            showVoiceRemindDiag(remindId)
        }
    }

    function showVoiceRemindDiag(remindId) {
        console.debug("[home Application] showVoiceRemindDiag =", remindId);
        switch(remindId)
        {
        case McanCtl.DOOR_BC_INDEX:
        case McanCtl.DOOR_LF_INDEX:
        case McanCtl.DOOR_LR_INDEX:
        case McanCtl.DOOR_RF_INDEX:
        case McanCtl.DOOR_RR_INDEX:
            message = qsTr("请关闭车门");
            image = "qrc:/resources/voice_remind_door.png";
            break;
        case McanCtl.WATER_TEMP_INDEX:
            message = qsTr("发动机温度过高, 请停车");
            image = "qrc:/resources/voice_remind_high_temp.png";
            break;
        case McanCtl.BELT_MAIN_INDEX:
            message = qsTr("主驾驶安全带未系");
            image = "qrc:/resources/voice_remind_life_belt.png";
            break;
        case McanCtl.BELT_SUB_INDEX:
            message = qsTr("副驾驶安全带未系");
            image = "qrc:/resources/voice_remind_life_belt.png";
            break;
        case McanCtl.BELT_ALL_INDEX:
            message = qsTr("主/副驾驶安全带未系");
            image = "qrc:/resources/voice_remind_life_belt.png";
            break;
        case McanCtl.OVER_SPEED_INDEX:
            message = qsTr("已超过设定车速");
            image = "qrc:/resources/voice_remind_over_speed.png";
            break;
        case McanCtl.FUEL_SHORTAGE_INDEX:
            message = qsTr("燃油量低, 请及时加油");
            image = "qrc:/resources/voice_remind_fuel_up.png";
            break;
        case McanCtl.LIGHT_ON_INDEX:
            message = qsTr("请关闭灯光");
            image = "qrc:/resources/voice_remind_close_light.png";
            break;
        case McanCtl.POWER_ON_INDEX:
            message = qsTr("请关闭电源");
            image = "qrc:/resources/voice_remind_close_power.png";
            break;
        case McanCtl.OIL_PRESS_INDEX:
            message = qsTr("请加注机油");
            image = "qrc:/resources/voice_remind_fill_oil.png";
            break;
        case McanCtl.KEY_IN_INDEX:
            message = qsTr("请拔出钥匙");
            image = "qrc:/resources/voice_remind_pullout_key.png";
            break;
        case McanCtl.BREAK_RELEASE_INDEX:
            message = qsTr("请松开手刹");
            image = "qrc:/resources/voice_remind_handbrake.png";
            break;
        case McanCtl.ROAD_FROZEN_INDEX:
            message = qsTr("请注意路面结冰");
            image = "qrc:/resources/voice_remind_icy_load.png";
            break;
        case McanCtl.MAIN_TRAIN_INDEX:
            message = qsTr("请注意车辆保养");
            image = "qrc:/resources/voice_remind_maintain.png";
            break;
        case McanCtl.ABS_REMIND_INDEX:
            message = qsTr("请维修车辆");
            image = "qrc:/resources/voice_remind_abs.png";
            break;
        case McanCtl.ENGINE_ERROR_INDEX:
            message = qsTr("请维修车辆");
            image = "qrc:/resources/voice_remind_repair.png";
            break;
        default:
            return;
        }

        if (voiceRemindDialog !== null) {
            console.debug("[home Application] showVoiceRemindDiag 1");
            addChildImageToRemind();
        }
        else
        {
            var falg = multiApplications.currentApplication === 'carlife' ||
                    multiApplications.currentApplication === 'ecolink' ||
                    multiApplications.currentApplication === 'mirrorlink' ||
                    multiApplications.currentApplicationPageInfo().item.name === 'video_playing'

            console.debug("[home Application] showVoiceRemindDiag create");
            createTipDialogAsync('qrc:/Instances/Controls/DialogVoiceRemind.qml', {
                                     themeColor: system.interfacemodel,
                                     text: message,
                                     img: image,
                                     isOverlay:falg,
                                 }, dialogVoiceRemind);
            if (falg) {
                videoctl.setOverlay(1, 0x000001, 255)
            }
        }
    }

    function dialogVoiceRemind(dialog) {
        voiceRemindDialog = dialog;
        addChildImageToRemind();
        dialog.onClosed.connect(function(){
            voiceRemindDialog = null;
            if (voiceRemindIds instanceof Array)
            {
                voiceRemindIds.splice(0, voiceRemindIds.length)
            }
        });
    }

    function addChildImageToRemind()
    {
        console.debug("[home Application] addChildImageToRemind", voiceRemindIds.length);
        if (voiceRemindDialog === null)
        {
            console.log("addChildImageToRemind dialog object is null!");
            return;
        }

        voiceRemindDialog.clearChildImage();
        if (voiceRemindIds instanceof Array)
        {
            for (var index in voiceRemindIds)
            {
                var remindId = voiceRemindIds[index];
                if (remindId === McanCtl.DOOR_BC_INDEX || remindId === McanCtl.DOOR_LF_INDEX || remindId === McanCtl.DOOR_LR_INDEX
                        || remindId === McanCtl.DOOR_RF_INDEX || remindId === McanCtl.DOOR_RR_INDEX) {
                    console.debug("[home Application] addChildImageToRemind ", remindId);
                    voiceRemindDialog.addChildImage(remindId, voiceRemindDialog);
                }
            }
        }
    }

    /* END - by Zhao Xing, 2016.12.15 */

    /* BEGIN by Zhang Yi, 2016.12.08
     * Reconsitution volume adjusting logic.
    */
    property var volDialog: null
    property bool isVolDialogShown: false
    property int mainVolume

    Connections {
        target: SoundCommon

        property int lastSrc: -1

        Component.onCompleted: {
            mainVolume = Qt.binding(function() {
                var vol
                switch (HmiCommon.source) {
                case HmiCommon.SourceHF:
                    vol = SoundCommon.bluetoothVolume
                    break
                case HmiCommon.SourceTTS:
                    vol = SoundCommon.warnVolume
                    break
                default:
                    vol = SoundCommon.mediaVolume
                    break
                }
                console.debug("[home Application] ################ mainVolume:", vol)
                return vol
            })
        }

        onAudioSourceChanged: {
            console.debug("[home Application] onAudioSourceChanged:", lastSrc, "=>", audioSource, "Hmi.source =", HmiCommon.source)
            if (HmiCommon.source === -1) return
            if (HmiCommon.source !== audioSource) return
            if (lastSrc === audioSource) return

            if (lastSrc === -1) {
                switch (audioSource) {
                case HmiCommon.SourceRadio:
                    appWindow.decorator.loadState('radio')
                    break
                case HmiCommon.SourceUSBMP3:
                    var loadState = function() {
                        console.debug("@@@@@@@@ Loading MP3 state... mediaScanState:", mediaScanState)
                        if (mediaScanState !== undefined &&
                            mediaScanState !== Constant._USB_SCAN_START &&
                            mediaScanState !== Constant._USB_SCAN_RUN) {
                            if (SoundCommon.audioSource === HmiCommon.SourceUSBMP3)
                                appWindow.decorator.loadState('musicctl')
                            return true
                        }
                        return false
                    }
                    if (!loadState()) {
                        mediaScanStateChanged.connect(function handle() {
                            if (loadState()) mediaScanStateChanged.disconnect(handle)
                        })
                    }
                    break
                default:
                    break
                }
            }
            else {
                switch (audioSource) {
                case HmiCommon.SourceRadio:
                    radio.tryResume(sourceActByMode)
                    break
                case HmiCommon.SourceUSBMP3:
                    if (lastSrc !== HmiCommon.SourceUSBVideo) {
                        musicctl.tryResume(sourceActByMode)
                    }
                    break
                case HmiCommon.SourceUSBVideo:
                    videoctl.tryResume(sourceActByMode)
                    break
                case HmiCommon.SourceBTA:
                    btctl.setAudioStreamMode(0)
                    btctl.tryResume(sourceActByMode)
                    break
                case HmiCommon.SourceHF:
                    __lastMute = SoundCommon.mute
                    SoundCommon.setMute(false)
                    break
                case HmiCommon.SourceCarLife:
                    if (lastSrc !== HmiCommon.SourceHF)
                    {
                        carlife.tryResume()
                    }
                    break
                default:
                    break
                }
                if (lastSrc === HmiCommon.SourceTTS) {
                    tryResume()
                }
            }

            lastSrc = SoundCommon.audioSource
            sourceActByMode = 0
        }
    }

    function directVolume(value, op) {
        console.debug("@@@@ directVolume <<<<", value)
        switch (HmiCommon.source) {
        case HmiCommon.SourceHF:
            SoundCommon.setBluetoothVolume(value)
            break
        case HmiCommon.SourceTTS:
            SoundCommon.setWarnVolume(value)
            break
        default:
            SoundCommon.setMediaVolume(value)
            break
        }
        if ((op === undefined) && power.accState) showVolumeDialog()
    }

    function setVolume(op, offset) {
        if (SoundCommon.mute) SoundCommon.setMute(false)

        var calcVol = function(vol) {
            if (op)
                vol += offset
            else
                vol -= offset
            if (vol > Constant._DIAG_VOLUME_MAX) vol = Constant._DIAG_VOLUME_MAX
            if (vol < Constant._DIAG_VOLUME_MIN) vol = Constant._DIAG_VOLUME_MIN
            return vol
        }

        directVolume(calcVol(function() {
                                 switch (HmiCommon.source) {
                                 case HmiCommon.SourceHF:
                                     return SoundCommon.bluetoothVolume
                                 case HmiCommon.SourceTTS:
                                     return SoundCommon.warnVolume
                                 default:
                                     return SoundCommon.mediaVolume
                                 }
                             }()))
    }


    function showVolumeDialog() {

        if (!isVolDialogShown) {
            isVolDialogShown = true
            createTipDialogAsync('qrc:/Instances/Controls/DialogVolume.qml', {
                                     themeColor: system.interfacemodel,
                                     value: mainVolume,
                                     autoCloseTimeout: 3000,
                                     clickClose: true
                                 }, dialogVol);
            if (multiApplications.currentApplication === 'carlife' ||
                multiApplications.currentApplication === 'ecolink' ||
                multiApplications.currentApplication === 'mirrorlink' ||
                multiApplications.currentApplicationPageInfo().item.name === 'video_playing') {
                videoctl.setOverlay(1, 0x000001, 255)
                ecolink.setVolumeDialogState(1);
            }
        }
    }

    function dialogVol(dialog) {
        volDialog = dialog
        dialog.onSliderValueChanged.connect(function(){ directVolume(dialog.sliderValue, false) })
        dialog.onClosed.connect(function(){ volDialog = null; isVolDialogShown = false; ecolink.setVolumeDialogState(0) })
        dialog.value = Qt.binding(function() { return mainVolume })
    }

    /* END - by Zhang Yi, 2016.12.08 */

    /* BEGIN by Zhang Yi, 2016.12.13
     * Reconsitution power/display on-off logic.
    */
    property int statusDispPower: (power.power ? (power.scc ? Constant._POWERON_DISPON : Constant._POWERON_DISPOFF) :
                                                 (power.scc ? Constant._POWEROFF_DISPON : Constant._POWEROFF_DISPOFF))

    function isDispOffScreen() {
        var powerInfo = multiApplications.getInfo('power')
        return !!(powerInfo && powerInfo.item.getInfo('main'))
    }

    function isPowerOffScreen() {
        var powerInfo = multiApplications.getInfo('power')
        return !!(powerInfo && (powerInfo.item.getInfo('clock') || powerInfo.item.getInfo('number')))
    }

    function switchDispOff(op) {
        console.debug("[home Application] switchDispOff", op, isDispOffScreen());
        if (isDispOffScreen() === op) return
        if (op) {
            if (!isPowerOffScreen()) {
                multiApplications.changeApplication('power', {properties: {initialPage: 'main'}})
            }
            else {
                var switchToMain = function() {
                    if (isPowerOffScreen()) {
                        multiApplications.currentInfo().item.changePage('main')
                        return true
                    }
                    return false
                }
                if (!switchToMain()) {
                    appWindow.__pageChanged.connect(function handle(id) {
                        if (switchToMain()) {
                            appWindow.__pageChanged.disconnect(handle)
                        }
                    })
                }
            }
        }
        else {
            var powerPageInfo = multiApplications.getInfo('power')
            if (powerPageInfo) powerPageInfo.item.remove('main')
        }
    }

    function switchPowerOff(op) {
        console.debug("[home Application] switchPowerOff", op, isPowerOffScreen());
        if (isPowerOffScreen() === op) return

        /* BEGIN by Zhang Yi, 2016.11.16
         * The vol-dialog shouldn't show on power-off screen.
         * See: Bug #244
        */
        if (volDialog !== null) {
            volDialog.close()
        }
        /* END - by Zhang Yi, 2016.11.16 */

        /* Turn power-off */
        if (op) {
            if (system.screenmodel === 1 || system.screenmodel === 0) {
                multiApplications.changeApplication('power', {properties: {initialPage: 'clock'}});
            } else {
                multiApplications.changeApplication('power', {properties: {initialPage: 'number'}});
            }
        }
        /* Turn power-on */
        else {
            multiApplications.remove('power')
        }
    }

    function switchAccOff(op) {
        console.debug("[home Application] switchAccOff:", op, ", scc:", power.scc);
        if (volDialog !== null) {
            volDialog.close()
        }

        if (op) {
            power.scc = true
        }
        switchDispOff(op)
    }

    function onPowerStateChanged() {
        console.debug("[home Application] onPowerStateChanged", power.power);
        switchPowerOff(!(power.power))
        if (power.power) {
            mcan.playRemindFromHMI()
        }
        else {
            mcan.stopRemindFromHMI()
        }
    }

    function onSccStateChanged() {
        console.debug("[home Application] onSccStateChanged", power.scc);
        switchDispOff(!(power.scc))
    }

    function onAccStateChanged() {
        console.debug("[home Application] onAccStateChanged", power.accState);
        if (power.accState) {
            mcan.stopAllByAccOn()
            tryResume()
            if (power.power) {
                SoundCommon.setMute(false)
                bingMuteMonitor()
            }
            btctl.connectMode(true)
        }
        else {
            musicctl.saveMusicInfo()
            videoctl.saveVideoInfo()
            mcan.stopAllByAccOff()
            btctl.connectMode(false)
            btctl.disconnectDev()
            tryPause()
            if (power.power) {
                SoundCommon.muteChanged.disconnect(__muteMonitor)
                statusBar.isMute = false
                SoundCommon.setMute(true)
            }
        }
        switchAccOff(!(power.accState))
    }

    function clearPowerScreen() {
        power.scc = true
        power.power = true
    }
    /* END - by Zhang Yi, 2016.12.13 */

    /* BEGIN by Zhao Xing, 2017.1.18
     * USB MIFI */
    property var usbMIFIDialog
    function updateUsbMIFIState(deviceState, deviceType) {
        console.debug("updateUsbMIFIState:", deviceState, deviceType)
        if (deviceState === undefined || deviceType === undefined) return
        if (deviceState === Constant._DEVICE_STATE_PULLOUT) {
            if (usbMIFIDialog !== undefined) {
                console.debug("usb pullout, mifi close dialog");
                usbMIFIDialog.close();
                usbMIFIDialog = undefined
            }
        } else {
            var tipValue = "";
            if (deviceType === Constant._DEVICE_TYPE_HUB){
                tipValue = qsTr("HUB is Unsupported");
            } else {
                if (deviceState === Constant._DEVICE_STATE_UNKNOWN
                        || deviceState === Constant._DEVICE_STATE_UNSUPPORT) {
                    tipValue = qsTr("Unsupported Device");
                } else if (deviceState === Constant._DEVICE_STATE_NORESPONSE) {
                    tipValue = qsTr("Device No Response");
                }
            }

            if (tipValue !== "") {
                if (usbMIFIDialog !== undefined) {
                    console.debug("mifi update text:" + tipValue);
                    usbMIFIDialog.text = tipValue;
                } else {
                    console.debug("mifi create dialog text:" + tipValue);

                    createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml', {
                                             themeColor: system.interfacemodel,
                                             clickClose:true,
                                             text:tipValue}, dialogUsbMIFI);

                    var currPageInfo = multiApplications.currentApplicationPageInfo()
                    if (multiApplications.currentApplication === 'carlife' ||
                            multiApplications.currentApplication === 'ecolink' ||
                            multiApplications.currentApplication === 'mirrorlink' ||
                            (currPageInfo && currPageInfo.item.name === 'video_playing')) {
                        videoctl.setOverlay(1, 0x000001, 255)
                        ecolink.setVolumeDialogState(1);
                    }
                }
            }
        }
    }

    function dialogUsbMIFI(dialog) {
        usbMIFIDialog = dialog;
        dialog.onClosed.connect(function(){usbMIFIDialog = undefined});
    }

    /* END - by Zhao Xing, 2017.1.18 */
}
