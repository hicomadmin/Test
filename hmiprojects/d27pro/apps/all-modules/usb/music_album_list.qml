import QtQuick 2.0
import QtQuick.Controls 1.2
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
    id:albumlistTab
    property bool isCopy: false
    property string  albname
    property string  iconurl

    property MusicCtl musicctl: HSPluginsManager.get('musicctl')
    property var musicInfo : musicctl ? musicctl.musicInfo : null
    property var musicInfoId : musicInfo ? musicInfo.ID : null
    property bool isPlay: musicctl ?  musicctl.playState === Constant._USB_MUSIC_PLAYING : false
    property bool isPause: musicctl ?  musicctl.playState === Constant._USB_MUSIC_PAUSE : false

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property var mediaInfo: devctl ? devctl.mediaInfo : null
    property var mediaMusic: mediaInfo ? mediaInfo.mediaMusic : 0

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0



    Rectangle{
        id:backgroud
        color:"transparent"
        width:1040
        height:628
        y:-105
        z:1
        Image{
            source: interfacemodel == 0 ? "qrc:/resource-usb/Media_albumlist_BG.png" :
                                          (interfacemodel == 1 ? "qrc:/resource-usb/Media_albumlist_BG_o.png" :" ")
            anchors.fill: parent
        }
        Rectangle{
            id:album_bg
            width:parent.width
            height:183
            anchors{
                top:parent.top
                left:parent.left
            }
            color:"#20272D"
            Image{
                id:albumIcon
                width: 160
                height: 160
                source:iconurl
                onStatusChanged: {
                    if(status != Image.Ready) {
                        source = "qrc:/resource-usb/Media_Icon_MusicPicture_160.png"
                    }
                }
                anchors{
                    verticalCenter: parent.verticalCenter
                    left:parent.left
                    leftMargin: 60
                }
            }
            IControls.NonAnimationText_FontLight{
                id:albumName
                width:200
                height:90
                text:albname
                color:interfacemodel == 0 ? "#73F7D6" :(interfacemodel == 1 ? "#FF2200" : "#986142")
                font.pixelSize: 48
                elide:Text.ElideRight
                anchors{
                    left:albumIcon.right
                    leftMargin: 38
                    top:parent.top
                    topMargin: 46
                    right: album_list.left
                }
            }
            IControls.RoundLabButtonD{
                id: album_list
                width: 200;
                height: 90;
                IControls.NonAnimationText_FontRegular{
                    text: qsTr("专辑列表")
                    color:"#b0b4b7"
                    font.pixelSize: 30
                    anchors.centerIn: parent
                }

                anchors{
                    right:parent.right
                    rightMargin: 51
                    top:parent.top
                    topMargin: 44
                }
                onClicked: {
                    tabview.switchTab("album",{
                                          title:qsTr('USB'),
                                          properties: {
                                              //albname:k_name,
                                              isCopy: false,

                                          },
                                          needUpdate: false

                                      });
//                    console.debug("track name:",albname)
//                    console.debug("trackArtist:",artist)
                    //                application.changePage('music_main');
                }
            }
        }
        ListModel {
            id: listModel
        }

        IControls.ListView{
            id:albtracklist
            width:1040
            height:445
            clip:true
            //        boundsBehavior:Flickable.StopAtBounds
            anchors{
                top:album_bg.bottom
                topMargin: 17
                left:parent.left
            }


            model:listModel
            delegate:IControls.ListItemDelegateE{
                iconvisible:false
                music_filename:title
                themeColor: interfacemodel
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
                    console.debug("music_album_list onClicked ID:" + ID)
                    application.changePage('music_playing',{
                                               title:qsTr('USB') ,
                                               properties: {
                                                   manualPlay:true,
                                                   trackId: ID,
                                                   trackPath:null,
                                                   trackPlayRangen:Constant._PLAY_RANGE_ALBUMS
                                               },
                                               needUpdate: true
                                           });
                }
            }
            listView.usePaginationLoader: true
            listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
                function loadPageAsync(page, cb) {
                    var musicctl = HSPluginsManager.get('musicctl');
                    musicctl.songlistChanged.connect(function handler(songlist){
                        musicctl.songlistChanged.disconnect(handler);
                        cb(null, songlist);

                        function getItems(datas) {
                            var items = '';
                            for(var key in datas){
                                var value=datas[key];//key所对应的value
                                items += (key + ":" + value + ", ");
                            }
                            return items
                        }

                        var device = '';
                        for(var item in songlist){
                            var jValue=songlist[item];//key所对应的value
                            device += (item + ":[" + getItems(jValue) + "], ");
                        }
                        console.debug("music_album_list songlist : " + device + " musicInfoId:" + musicInfoId + " isPause:" + isPause + " isPlay:" + isPlay);
                    });
                    if(mediaMusic > 0){
                            var data =[albname,page]
                        musicctl.getSongByAlbum(data);
                        console.debug("musicinfo test:",albtracklist)
                    } else {
                        cb(null, []) ;
                    }
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
