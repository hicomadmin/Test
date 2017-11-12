import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//import Multimedia 1.0
import TheXMusic 1.0
import TheXDevice 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id:albumTab

    property bool isCopy: false

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0

    property MusicCtl musicctl: HSPluginsManager.get('musicctl')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property var mediaInfo: devctl ? devctl.mediaInfo : null
    property var mediaMusic: mediaInfo ? mediaInfo.mediaMusic : 0
    property var albumCover: musicctl ? musicctl.albumCover : null
    property var map: ({})

    ListModel {
        id: listModel
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
    IControls.GridViewB{
        id:albumlist
        width:1040
        height:500

        clip:true
        //        boundsBehavior:Flickable.StopAtBounds
        anchors{
            top:split_line.bottom
            topMargin: 13
            left:parent.left
            leftMargin: 17
        }
        model:listModel

//        albumName	专辑名字
//        coverPath	专辑图片路径
//        ID	临时编号

        delegate:Component{
            IControls.GridItemDelegateB{
                id:delegateItem
                themeColor: interfacemodel
                file_name: albumName
                iconurl: map[ID] ? map[ID]: ''
                iconerrorurl: "qrc:/resource-usb/Media_Icon_MusicPicture.png"
                onClicked:{
                        tabview.switchTab("albumlist",{
                                              title:qsTr('USB'),
                                              properties: {
                                                  albname:albumName,
                                                  iconurl:iconurl,
                                                  isCopy: false,

                                              },
                                              needUpdate: false

                                          });
                }
                Connections {
                    target: albumTab
                    onAlbumCoverChanged: {
                        map[albumCover.ID] = "file://" + albumCover.coverPath
                        if(ID == albumCover.ID) {
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
                musicctl.albumlistChanged.connect(function handler(albumlist){
                    musicctl.albumlistChanged.disconnect(handler);
                    cb(null, albumlist) ;

                    function getItems(datas) {
                        var items = '';
                        for(var key in datas){
                            var value=datas[key];//key所对应的value
                            items += (key + ":" + value + ", ");
                        }
                        return items
                    }

                    var device = '';
                    for(var item in albumlist) {
                        var jValue=albumlist[item];//key所对应的value
                        device += (item + ":[" + getItems(jValue) + "], ");
                    }
                    console.debug("music_album albumlist : " + device);
                });
                if(mediaMusic > 0){
                    musicctl.getAlbumList(page);
                } else {
                    cb(null, []) ;
                }
            }
        }
    }

}
