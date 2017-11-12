import QtQuick 2.0
import QtQuick.Controls 1.2
import  'qrc:/Instances/Core' as ICore
import  'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
import  Multimedia 1.0

ICore.Page {
    id: albumlistPage

    property UsbCtl  usbctl
    property string  artist
    property bool  isPlay
    property var musicinfo

    onUsbctlChanged: {
        isPlay = Qt.binding(function (){return usbctl.playbackState === 4 ? true :false})
        musicinfo = Qt.binding(function(){return usbctl.musicinfo})
    }

    ListModel {
        id: listModel
    }

    IControls.ListViewC {
        id:albumlist
        anchors.top: parent.top
        model: listModel
        delegate: IControls.ListItemDelegateC {
            text: k_name
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
                visible:isPlay ?(musicinfo.album === k_name ? true : false) : false
            }
            onClicked: {
                application.changePage('albumtracklist',{
                                                title:qsTr('曲目'),
                                                properties:{ albname:k_name}
                                       })
            }
        }
        listView.usePaginationLoader: true
        listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page, cb) {
                var usbctl = HSPluginsManager.get('usbctl');
                usbctl.albumlistChanged.connect(function handler(albumlist){
                    usbctl.albumlistChanged.disconnect(handler);
                    cb(null, albumlist) ;
                });
                var data = ({'page':page})
                usbctl.requestLoadData("getalbumlist", data);
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
            denText: albumlist ?  albumlist.model.count : 0
            numText: albumlist ?  albumlist.listView.listView.currentIndex+1 : 0
        }
    }
}
