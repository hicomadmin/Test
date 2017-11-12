import QtQuick 2.0
import QtQuick.Controls 1.2
import  'qrc:/Instances/Core' as ICore
import  'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
//import  Multimedia 1.0
import TheXDevice 1.0
import TheXFolder 1.0
import TheXSettings 1.0
import Apps 1.0

HSTab {
    id: subfileTab
    property bool isCopy: false
    property FolderCtl folderctl: HSPluginsManager.get('folderctl')
    property var folderList:folderctl ? folderctl.folderList : []
    property int fileCount: folderctl ? folderctl.fileCount : 0

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property var deviceInfo: devctl ? devctl.deviceInfo : null
    property var devMountPath: deviceInfo ? deviceInfo.devMountPath : null

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0

    property var memoryPath
    property var loaderdirPath
    property var targetPath

    ListModel {
        id: listModel
    }
    Component{
        id:headerview
        Item{
            width: 1040
            height: 100
            Text{
                text:qsTr("返回上一级")
                font.family: "黑体"
                color:"#FFFFFF"
                font.pixelSize: 32
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin:89
            }
            IControls.MouseArea{
                id:header_mouse
                anchors.fill: parent
                onClicked: {

//                    var targetPath = parentPath.substring(0,parentPath.lastIndexOf('/'))
		    console.debug("targetPath:",targetPath)
            console.debug("memoryPath:",memoryPath)
                    if(targetPath == memoryPath){
                        tabview.switchTab("folder",{
                                              title:qsTr('USB'),
                                              properties: {
                                                  isCopy: false,
                                              },
                                              needUpdate: false

                                          });

                    }else{
                        folderctl.getFolderList(targetPath);
                    }
                }
            }
        }

    }

    IControls.ListView {
        id:childfolderlist
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
                    console.debug("parentPath:", parentPath)
                    switch(mediatype)
                    {
                    case 0:
                        application.changePage('music_playing',{
                                                   title:qsTr('USB') ,
                                                   properties: {
                                                       trackId: -1,
                                                       trackPath:parentPath + '/' + filename,
                                                       trackPlayRangen:Constant._PLAY_RANGE_FOLDERS
                                                   },
                                                   needUpdate: false
                                               });
                        break;
                    case 1:
                        usbctl.stop();
                        application.changePage('vedio_playing',{
                                                   title:qsTr('USB') ,
                                                   properties: {
                                                       videoIndex:index,
                                                       list:folderlist,
                                                       modelData:listModel
                                                   },
                                                   needUpdate: false
                                               });
                        break;
                    case 2:
                        application.changePage('image_full_screen',{
                                                   title:qsTr('USB'),
                                                   properties:{
                                                       imgSource1:"file://" + parentPath + '/' + filename,
                                                       imgIndex:index,
                                                       imgModel:listModel
                                                   },
                                                   needUpdate: false
                                               });
                        break;
                    case 3:
                        //                          memoryPath: folderFileInfo[index].parentPath
                        targetPath = parentPath
                        console.debug("mediapath:",parentPath + '/' + filename)
                        folderctl.getFolderList(parentPath + '/' + filename);
                        break;
                    }  //end of switch

                } //end of onClick
            }  //end of IControls.ListItemDelegateC
        }
        listView.usePaginationLoader: true
        listView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page, cb) {
                var folderctl = HSPluginsManager.get('folderctl');
                folderctl.folderListChanged.connect(function handler(folderList){
                    folderctl.folderListChanged.disconnect(handler);
                    cb(null, folderList) ;
                });
            }
        }//end of delegate
    } //end of listview

    onItemShowing: {
        targetPath = memoryPath
        console.debug("loaderdirPath:",loaderdirPath)
        folderctl.getFolderList(loaderdirPath);
    }
}
