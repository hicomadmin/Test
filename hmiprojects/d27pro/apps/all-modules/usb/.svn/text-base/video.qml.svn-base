import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs
//import Multimedia 1.0
import TheXVideo 1.0
import TheXDevice 1.0
import QtMultimedia 5.0
import TheXMcan 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id:videoTab
    property bool isCopy: false
    property double speed

    property VideoCtl videoctl: HSPluginsManager.get('videoctl')
    property var videoList: videoctl ? videoctl.videoList: null

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property var mediaInfo: devctl ? devctl.mediaInfo : null
    property var mediaVideo: mediaInfo ? mediaInfo.mediaVideo : 0
    property var videoCover: videoctl ? videoctl.videoCover : null
    property var map: ({})

    /* BEGIN by Zhang Yi, 2016.11.22
     * McanCtl should only be constructed once.
    */
    property McanCtl mcan: HSPluginsManager.get('mcan')

    Connections {
        target: mcan

        onCarSpeedChanged: {
            speed = mcan.carSpeed / 100;
        }
    }
    /* END - by Zhang Yi, 2016.11.22 */

    ListModel {
        id: listModel
    }

    IControls.GridViewA{
        id:videolistview
        opacity: noVideoText.visible ? 0:1
        width:1020
        height:628
        clip:true
        anchors{
            top:parent.top
            topMargin: 5
            left:parent.left
            leftMargin: 16
        }
        model:listModel
        delegate:Component{
            IControls.GridItemDelegateA{
                id:delegateItem
                filename: listModel.get(index).filename
                themeColor: interfacemodel
                iconurl: map[ID] ? map[ID]: ''
                iconerrorurl: interfacemodel == 0 ? 'qrc:/resource-usb/Media_Icon_Listvideo.png':
                                                    (interfacemodel == 1 ? "qrc:/resource-usb/Media_Icon_Listvideo.png" : "qrc:/resource-usb/Media_Icon_Listvideo.png")
                onClicked:{
                    if(speed>20)
                    {
                        application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor: interfacemodel,text: qsTr("为了行车安全，请不要观看视频"),autoCloseTimeout: 3000 });
                    }
                    else
                    {
                        console.debug("video onClicked ID:" + ID)
                    application.changePage('video_playing',{
                                               properties: {
                                                   trackId: ID,
                                                   trackPath:null,
                                                   trackPlayRangen:0
                                               },
                                               needUpdate: false
                                           });
                    }
                }
                Connections {
                    target: videoTab
                    onVideoCoverChanged: {
                        map[videoCover.ID] = "file://" + videoCover.coverPath
                        if(ID == videoCover.ID) {
                             delegateItem.iconurl = Qt.binding(function(){return map[ID] ? map[ID]:''})
                        }
                    }
                }
            }

        }
        gridView.usePaginationLoader: true
        gridView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page, cb) {
                var handler = function (videoList){
                    JSLibs.clearTimeout(timer);
                    videoctl.videoListChanged.disconnect(handler);
                    cb(null, videoList);
                };
                var timer = JSLibs.setTimeout(function () {
                    videoctl.videoListChanged.disconnect(handler);
                    cb(null, []) ;
                }, 1000*15);
                var videoctl = HSPluginsManager.get('videoctl');
                videoctl.videoListChanged.connect(handler);
                if(mediaVideo > 0){
                    videoctl.getVideoList(page);
                } else {
                    cb(null, []);
                }
            }
        }
    }


    Text{
        id:noVideoText
        visible: listModel.count === 0
        anchors.centerIn: parent
        font.pointSize: 28
        text:qsTr(mediaVideo > 0 ? "正在扫描文件..." : '无视频文件...')
        color:"white"
    }

}

