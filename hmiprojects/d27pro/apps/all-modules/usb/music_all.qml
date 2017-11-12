import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
//import Multimedia 1.0
import TheXMusic 1.0
import TheXDevice 1.0
import TheXSettings 1.0
import TheXPresenter 1.0
import Apps 1.0

HSTab {
    id:songlistTab

    property bool isCopy: false
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property var mediaInfo: devctl ? devctl.mediaInfo : null
    property var mediaMusic: mediaInfo ? mediaInfo.mediaMusic : 0

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0

    property MusicCtl musicctl: HSPluginsManager.get('musicctl')
    property var musicInfo : musicctl ? musicctl.musicInfo : null
    property var musicInfoId : musicInfo ? musicInfo.ID : null
    property var songlist: musicctl.songlist
    property bool isPlay: musicctl ?  musicctl.playState === Constant._USB_MUSIC_PLAYING : false
    property bool isPause: musicctl ?  musicctl.playState === Constant._USB_MUSIC_PAUSE : false
    property var songCover: musicctl ? musicctl.songCover : null
    property var map: ({})

    onItemFirstShown: {
        console.debug("music_all onItemShowing application.musicLoadState:" + application.musicLoadState)
    }

    function setmusicLoadState(musicLoadState){
        application.musicLoadState = musicLoadState;
        console.debug("music_all setmusicLoadState application.musicLoadState:" + application.musicLoadState)
    }

    Image{
        id:split_line
        width:1040
        height:2
        anchors{
            top:parent.top
            topMargin:18
            left:parent.left
        }
        source: 'qrc:/resource-usb/Media_listTab_line.png'
    }
    ListModel {
        id: listModel
    }

    IControls.ListView{
        id:tracklist
        width:1040
        height:480
        clip:true
        anchors{
            top:split_line.bottom
            topMargin: 17
            left:parent.left
        }
        model:listModel
        delegate:IControls.ListItemDelegateE{
            id:delegateItem
            music_filename:title
            themeColor: interfacemodel
            iconurl: map[ID] ? map[ID]: ''
            iconerrorurl: "qrc:/resource-usb/Media_Icon_MusicPicture_100.png"
            music_artistname:artist
            stateiconurl: getPlayState(ID)
            mousestateenabled: musicInfoId == ID
            onMousestateclicked: {
                if(HmiCommon.source !== HmiCommon.SourceTTS) {
                    if (HmiCommon.source !== HmiCommon.SourceUSBMP3) {
                        HmiCommon.requireSourceOn(HmiCommon.SourceUSBMP3)
                    }
                    if(isPlay){
                        musicctl.pause()
                    } else if(isPause) {
                        musicctl.resume()
                    }
                }
            }
            onClicked:{
                console.debug("musicInfoId:" + musicInfoId + " ID:" + ID + " " + (musicInfoId == ID))
                console.debug("title:",title)
                console.debug("artist:",artist)
                application.changePage('music_playing',{
                                           title:qsTr('USB') ,
                                           properties: {
                                               manualPlay:true,
                                               trackId: ID,
                                               trackPath:null,
                                               trackPlayRangen:Constant._PLAY_RANGE_ALL
                                           },
                                           needUpdate: true
                                       });
            }
            Connections {
                target: songlistTab
                onSongCoverChanged: {
                    map[songCover.ID] = "file://" + songCover.albpic
                    if(ID == songCover.ID) {
                         delegateItem.iconurl = Qt.binding(function(){return map[ID] ? map[ID]:''})
                    }
                }
            }
        }
        listView.usePaginationLoader: true
        listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page, cb) {
                console.debug("music_all loadPageAsync mediaMusic:" + mediaMusic + " page:" + page)
                var musicctl = HSPluginsManager.get('musicctl');
                musicctl.songlistChanged.connect(function handler(songlist){
                    console.debug("music_all loadPageAsync handler songlist" + songlist.length + " page:" + page)
                    musicctl.songlistChanged.disconnect(handler)
                    cb(null, songlist)
                    setmusicLoadState(Constant._IDLE_SONG)
                });
                if(mediaMusic > 0) {
                    console.debug("music_all loadPageAsync getAllSong mediaMusic" + mediaMusic + " page:" + page)
                    musicctl.getAllSong(page);
                    if(page === 1)setmusicLoadState(Constant._LOADING_SONG)
                } else {
                    cb(null, []);
                    setmusicLoadState(Constant._NO_SONG)
                }
            }
        }
    }

    function getPlayState(ID) {
        if(musicInfoId == ID) {
            if(isPause) {
                switch(interfacemodel) {
                case 0:
                    return 'qrc:/resource-usb/Media_Icon_ListPlay.png'
                case 1:
                    return 'qrc:/resource-usb/Media_Icon_ListPlay_o.png'
                case 2:
                    return 'qrc:/resource-usb/Media_Icon_ListPlay_g.png'
                }
            } else if (isPlay) {
                switch(interfacemodel) {
                case 0:
                    return 'qrc:/resource-usb/Media_Icon_Liststop.png'
                case 1:
                    return 'qrc:/resource-usb/Media_Icon_Liststop_o.png'
                case 2:
                    return 'qrc:/resource-usb/Media_Icon_Liststop_g.png'
                }
            }
        }
        return ''
    }
}

