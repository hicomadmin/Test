import QtQuick 2.0
import QtQuick.Controls 1.2
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//import Multimedia 1.0
import TheXMusic 1.0
import TheXDevice 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id:artistTab
    property bool isCopy: false
    property MusicCtl musicctl: HSPluginsManager.get('musicctl')

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property var mediaInfo: devctl ? devctl.mediaInfo : null
    property var mediaMusic: mediaInfo ? mediaInfo.mediaMusic : 0

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0
    property var artistCover: musicctl ? musicctl.artistCover : null
    property var map: ({})

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
    IControls.GridViewB{
        id:artistlist
        width:1040
        height:505

        clip:true
        //        boundsBehavior:Flickable.StopAtBounds
        anchors{
            top:split_line.bottom
            topMargin: 13
            left:parent.left
            leftMargin: 17
        }
        model:listModel
//        artist	歌手名称
//        coverPath	专辑图片路径
//        ID	临时编号

        delegate:Component{
            IControls.GridItemDelegateB{
                id:delegateItem
                file_name: artist
                themeColor: interfacemodel
                iconurl: map[ID] ? map[ID]: ''
                iconerrorurl:"qrc:/resource-usb/Media_Icon_MusicPicture.png"
                onClicked:{
                    tabview.switchTab('artistlist',{
                                          title:qsTr('USB'),
                                          properties:{
                                              artist:artist,
                                              iconurl:iconurl,
                                          }
                                      })
                }
                Connections {
                    target: artistTab
                    onArtistCoverChanged: {
                        map[artistCover.ID] = "file://" + artistCover.coverPath
                        if(ID == artistCover.ID) {
                             delegateItem.iconurl = Qt.binding(function(){return map[ID] ? map[ID]:''})
                        }
                    }
                }
            }
        }
        gridView.usePaginationLoader: true
        gridView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page, cb) {
                var musicctl = HSPluginsManager.get('musicctl');
                musicctl.artistlistChanged.connect(function handler(artistlist){
                    musicctl.artistlistChanged.disconnect(handler);
                    cb(null, artistlist) ;

                    function getItems(datas) {
                        var items = '';
                        for(var key in datas){
                            var value=datas[key];//key所对应的value
                            items += (key + ":" + value + ", ");
                        }
                        return items
                    }

                    var device = '';
                    for(var item in artistlist){
                        var jValue=artistlist[item];//key所对应的value
                        device += (item + ":[" + getItems(jValue) + "], ");
                    }
                    console.debug("music_artist artistlist : " + device);
                });
                if(mediaMusic > 0){
                    musicctl.getArtistList(page);
                    console.debug("album test:")
                } else{
                    console.debug("album else test:",artistlist)
                }
            }
        }
    }
}
