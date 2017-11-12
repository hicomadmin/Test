import QtQuick 2.0
import QtQuick.Controls 1.2
import  'qrc:/Instances/Core' as ICore
import  'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
import  Multimedia 1.0
ICore.Page {
    id: subfilePage

    property UsbCtl usbctl
    property string  foldername
    property bool  isPlay
    property var musicinfo
    onUsbctlChanged: {
        isPlay = Qt.binding(function() {return usbctl.playbackState === 4 ? true :false})
        musicinfo = Qt.binding(function(){return usbctl.musicinfo})
    }

    ListModel {
        id: listModel
    }

    IControls.ListViewC {
        id: subdirlist
        model: listModel
        delegate:IControls.ListItemDelegateC {
            text :trackName
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
                visible:isPlay ?(musicinfo.filename ===trackName ? true : false) : false
            }
            onClicked: {
                subdirlist.listView.listView.currentIndex === index
                application.changePage('music',{
                                    properties: { curTrack:trackName,
                                                  list:subdirlist, modelData:listModel
                                           },needUpdate: true
                               } )
            }
        }
        listView.usePaginationLoader: true
        listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page, cb) {
                var usbctl = HSPluginsManager.get('usbctl');
                usbctl.dirfilelistChanged.connect(function handler(dirfilelist){
                    usbctl.dirfilelistChanged.disconnect(handler);
                    cb(null, dirfilelist) ;
                });
                var data= ({'name': foldername, 'page': page})
                usbctl.requestLoadData("getdirfilelist", data);
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
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6
        numColor: '#AAABBB'
        denFontSize: 24
        numFontSize: denFontSize
        denText: subdirlist ?  subdirlist.model.count: 0
        numText: subdirlist ?  subdirlist.listView.listView.currentIndex +1 : 0
    }
    }
}
