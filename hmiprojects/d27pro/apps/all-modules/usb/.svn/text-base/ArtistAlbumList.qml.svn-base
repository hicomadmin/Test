import QtQuick 2.0
import QtQuick.Controls 1.2
import  'qrc:/Instances/Core' as ICore
import  'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
import  Multimedia 1.0

ICore.Page {
    id: artistalbumPage

    property UsbCtl usbctl
    property string  artistName
    property bool  isPlay
    property string curTrack
    property var musicinfo

    onUsbctlChanged: {
        isPlay = Qt.binding(function(){return usbctl.playbackState === 4 ? true :false })
        curTrack = Qt.binding(function(){return usbctl.source})
        musicinfo = Qt.binding(function(){return usbctl.musicinfo})
    }

    ListModel {
        id: listModel
    }

    IControls.ListViewC {
        id: artistalbumlist
        model: listModel
        delegate:IControls.ListItemDelegateC {
            text : k_name
            normalColor: '#FFFFFF'
            pressingColor: '#000000'
            focusingColor: '#FF8F1C'
            Image {
                id:spkicon
                width: 48
                height: 42
                anchors.right: parent.right
                anchors.rightMargin: 42
                anchors.verticalCenter: parent.verticalCenter
                source: 'qrc:/resource-usb/Icon_volume.png'
                visible:isPlay ?(musicinfo.album=== listModel.get(index).k_name ? true : false) : false
            }
            onClicked: {
                 application.changePage('artalbumtracklist',{
                                            title:qsTr('曲目') ,
                                            properties: {
                                                artistName : artistName,
                                                albName: artistalbumlist.model.get(index).k_name
                                            }
                                        } )
            }
        }
        listView.usePaginationLoader: true
        listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page , cb) {
                var usbctl = HSPluginsManager.get('usbctl');
                usbctl.artistalbumlistChanged.connect(function handler(artistalbumlist){
                    usbctl.artistalbumlistChanged.disconnect(handler);
                    cb(null, artistalbumlist) ;
                });
                var data = ({'artistname':artistName, 'page':page})
                usbctl.requestLoadData("getartistalbumlist", data);
            }
        }
    }
    Item {
        width: 800-56-80
        height: 418
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 56
        UControls.RatioText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 6
            numColor: '#AAABBB'
            denFontSize: 24
            numFontSize: denFontSize
            denText: artistalbumlist ? artistalbumlist.model.count: 999
            numText: artistalbumlist ? artistalbumlist.listView.listView.currentIndex +1 : 0
        }
    }
}
