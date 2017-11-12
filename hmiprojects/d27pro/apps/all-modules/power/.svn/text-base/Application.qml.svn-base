import QtQuick 2.3
import TheXAudio 1.0
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    pages: ({
        main: { url: Qt.resolvedUrl('MainPage.qml'),hideStatusBar:true },
        clock: { url: Qt.resolvedUrl('LockScreenClock.qml'),hideStatusBar:true },
        number: { url: Qt.resolvedUrl('LockScreenNumber.qml'),hideStatusBar:true },
    })
    initialPage: 'main'

    property bool __hadPowerOff: false
    property var __lastMute

    onCurrentPageChanged: {
        if ((!__hadPowerOff) && (currentPage === 'clock' || currentPage === 'number')) {
            __hadPowerOff = true
            var main = mainControl()
            if (main)
            {
                main.tryPause()
                SoundCommon.muteChanged.disconnect(main.__muteMonitor)
            }
            statusBar.isMute = false
            __lastMute = SoundCommon.mute
            SoundCommon.setMute(true)
        }
    }

    onItemReadyHide: {
        console.debug("power onItemHiden:", __hadPowerOff)
        if (__hadPowerOff) {
            SoundCommon.setMute(__lastMute)
            var main = mainControl()
            if (main) {
                main.bingMuteMonitor(__lastMute)
                main.tryResume()
            }
            __hadPowerOff = false
        }
    }
}
