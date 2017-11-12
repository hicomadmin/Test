import QtQuick 2.0
import QtQuick.Controls 1.2
import  'qrc:/Instances/Core' as ICore
import  'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
import  Multimedia 1.0

ICore.Page {
    id: albumlistPage

    property UsbCtl  usbctl
    property string  albname
    property bool  isPlay
    property var musicinfo

    onUsbctlChanged: {
        isPlay = Qt.binding(function(){return usbctl.playbackState === 4 ? true :false})
        musicinfo = Qt.binding(function(){return usbctl.musicinfo})
    }

    ListModel {
        id: listModel
    }

    IControls.ListViewC {
        id:albtracklist
        anchors.top: parent.top
        model: listModel
        delegate: IControls.ListItemDelegateC {
            text: trackName
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
                visible:isPlay ?(musicinfo.filename === trackName ? true : false) : false
            }
            onClicked: {
                application.changePage('music',{
                                    properties: { curTrack: trackName,
                                                  list:albtracklist, modelData:listModel
                                           },needUpdate: true
                               } )
            }
        }
        listView.usePaginationLoader: true
        listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page, cb) {
                var usbctl = HSPluginsManager.get('usbctl');
                usbctl.albumtracklistChanged.connect(function handler(albumtracklist){
                    usbctl.albumtracklistChanged.disconnect(handler);
                    cb(null, albumtracklist) ;
                });
                var data = ({'albumname': albname ,'page':page})
                usbctl.requestLoadData("getalbumtracklist", data);
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
            denText: albtracklist ?  albtracklist.model.count : 0
            numText: albtracklist ?  albtracklist.listView.listView.currentIndex+1 : 0
        }
    }
}
