import QtQuick 2.3
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
//import Multimedia 1.0
//import TheXMusic 1.0
//import TheXDevice 1.0
//import TheXFolder 1.0
//import TheXSettings 1.0

ICore.VirtualApplication {
    property var map: ({})
    property var alldata
    property int musicLoadState:Constant._LOADING_SONG

    pages: ({
                music_main: { url: Qt.resolvedUrl('MainPage.qml'), title: qsTr('USB') },
                music_playing: { url:Qt.resolvedUrl('music_playing.qml'),title: qsTr('USB') },
                video_playing:{ url:Qt.resolvedUrl('video_playing.qml'),title: qsTr('USB'),supportFullScreen:true },
                usbStateDialog: {url: Qt.resolvedUrl('usbStateDialog.qml'), title: qsTr('USB') },
                image_full_screen:{url:Qt.resolvedUrl('ImageFullScreen.qml'),title: qsTr('USB'),supportFullScreen:true }
//                albumlist: {url: Qt.resolvedUrl('music_album_list.qml') }
            })

    initialPage: 'usbStateDialog'
}
