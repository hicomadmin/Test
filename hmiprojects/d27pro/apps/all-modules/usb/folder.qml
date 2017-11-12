import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
//import Multimedia 1.0
import TheXMusic 1.0
import TheXDevice 1.0
//import TheXVideo 1.0
import TheXFolder 1.0
import TheXSettings 1.0
//import TheXImage 1.0
import Apps 1.0

HSTab {
    id:folderlisttab
    property bool isCopy: false
    property FolderCtl folderctl: HSPluginsManager.get('folderctl')
    property var folderList:folderctl ? folderctl.folderList : []
    property int fileCount: folderctl ? folderctl.fileCount : 0

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property var deviceInfo: devctl ? devctl.deviceInfo : null
    property var devMountPath: deviceInfo ? deviceInfo.devMountPath : null
    property var mediaInfo: devctl ? devctl.mediaInfo : null
    property var mediaTotal: mediaInfo ? mediaInfo.mediaTotal : 0

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0

    property var targetPath

    onItemShowing:{
        targetPath = devMountPath
        console.debug("devMountPath:",devMountPath)
        if(mediaTotal > 0) {
            folderctl.getFolderList(targetPath);
        }
    }

    Component{
        id:headerview
        Item{
            width: 1040
            height: 100
            Text{
                text:qsTr("返回上一级")
                font.family: "黑体"
                color: targetPath != devMountPath ? "#FFFFFF" : '#3F4244'
                font.pixelSize: 32
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin:89
            }
            IControls.MouseArea{
                id:header_mouse
                anchors.fill: parent
                enabled:targetPath != devMountPath
                onClicked: {

//                    var targetPath = parentPath.substring(0,parentPath.lastIndexOf('/'))
            console.debug("targetPath:",targetPath)
            console.debug("devMountPath:",devMountPath)
                    if(targetPath && targetPath != devMountPath){
                        targetPath = targetPath.substring(0,targetPath.lastIndexOf('/'))
                        folderctl.getFolderList(targetPath);
                    }
                }
            }
        }

    }
    ListModel {
        id: listModel
    }
    IControls.ListView{
        id:folderlist
        visible:(targetPath != devMountPath || listModel.count !== 0) && !listView.paginationLoaderDelegate.processing
        width:1040
        height:628
        p_header:headerview
        clip:true
        //        boundsBehavior:Flickable.StopAtBounds
        anchors{
            top:parent.top
            right:parent.right
        }
        model:listModel
        delegate:Component{
            IControls.ListItemDelegateC{
                themeColor: interfacemodel
                file_name:filename
                iconurl:mediatype === 3 ? "qrc:/resource-usb/Media_Icon_ListFolder.png":
                                                                    (mediatype === 2 ? 'qrc:/resource-usb/Media_Icon_ListPhoto.png':
                                                                                                                 (mediatype === 1 ? 'qrc:/resource-usb/Media_Icon_Listvideo.png':'qrc:/resource-usb/Media_Icon_ListMusic.png' ))
                onClicked:{
                    console.debug("parentpath:",parentPath)
                    switch(mediatype)
                    {
                    case 0:
                        application.changePage('music_playing',{
                                                   title:qsTr('USB') ,
                                                   properties: {
                                                       manualPlay:true,
                                                       trackId: -1,
                                                       trackPath:parentPath + '/' + filename,
                                                       trackPlayRangen:Constant._PLAY_RANGE_FOLDERS
                                                   },
                                                   needUpdate: false
                                               });
                        break;
                    case 1:
                        application.changePage('video_playing',{
                                                   title:qsTr('USB') ,
                                                   properties: {
                                                       trackId: -1,
                                                       trackPath:parentPath + '/' + filename,
                                                       trackPlayRangen:2
                                                   },
                                                   needUpdate: false
                                               });
                        break;
                    case 2:
                        application.changePage('image_full_screen',{
                                                   title:qsTr('USB'),
                                                   properties: {
                                                       imgSource1:"file://" + parentPath + '/' + filename,
                                                       trackId: -1,
                                                       trackPath:parentPath + '/' + filename,
                                                       trackPlayRangen: 1
                                                   },
                                                   needUpdate: true
                                               });
                        console.debug("imagesource:","file://" + parentPath + '/' + filename)
                        break;

                    case 3:
                        targetPath = parentPath + '/' + filename
                        console.debug("targetPath:",targetPath)
                        folderctl.getFolderList(targetPath);
                        folderlist.listView.listView.currentIndex = 0
//                        folderlist.listView.paginationLoaderDelegate.refreshed()
                        break;
                    }
                }

            }

        }
        listView.usePaginationLoader: true
        listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            useLoaderMore: false
            function loadPageAsync(page, cb) {
                var handler = function (folderList) {
                    cb(null, folderList) ;
                }
                var folderctl = HSPluginsManager.get('folderctl');
                folderctl.folderListChanged.connect(handler);
                if(mediaTotal > 0) {
                    folderctl.getFolderList(targetPath);
                } else {
                    cb(null, []);
                }
            }
        }
    }

    Text{
        id:noFolderText
        visible:!folderlist.visible
        anchors.centerIn: parent
        font.pointSize: 28
        text:qsTr(mediaTotal > 0 ? "正在扫描文件..." : '无文件夹文件...')
        color:"white"
    }

}
