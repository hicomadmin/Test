import QtQuick 2.0
import QtQuick.Controls 1.2
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
//import Multimedia 1.0
import TheXMusic 1.0
import TheXDevice 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id: root
    property bool isCopy: false
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property MusicCtl musicctl: HSPluginsManager.get('musicctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0

    onItemShowing: {
        console.debug("music onItemShowing application.musicLoadState:" + application.musicLoadState)
    }

    Text{
        id:noMusicText
        visible: application.musicLoadState !== Constant._IDLE_SONG
        anchors.centerIn: parent
        font.pointSize: 28
        color:"white"
        text: qsTr(application.musicLoadState === Constant._LOADING_SONG ? "正在扫描文件...":"无音频文件...")
    }

    IControls.TabBarH{
        id:tabBar
        opacity: noMusicText.visible ? 0 : 1
        anchors.fill: parent;
        application: root.application
        themeColor: interfacemodel

        tabs: ({
                   all: {url: Qt.resolvedUrl('music_all.qml')},
                   album: {url: Qt.resolvedUrl('music_album.qml')},
                   artist: {url: Qt.resolvedUrl('music_artist.qml')},
                   albumlist: {url: Qt.resolvedUrl('music_album_list.qml')},
                   artistlist: {url: Qt.resolvedUrl('music_artist_list.qml')}
               })
        initialTab: 'all';
        tabsModel: [
            {
                tab: 'all',
                tabTitle: qsTr("全部"),
                //                tabImage:'qrc:/resource-usb/Media_Icon_Music.png'
            },
            {
                tab: 'album',
                tabTitle: qsTr("专辑"),
                //                tabImage:'qrc:/resources-usb/Media_Icon_video.png'
            },
            {
                tab: 'artist',
                tabTitle: qsTr("歌手"),
                //                tabImage:'qrc:/resources-usb/Media_Icon_Photo.png'
            }
        ]
    }


}
