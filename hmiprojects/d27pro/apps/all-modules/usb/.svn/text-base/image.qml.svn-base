import QtQuick 2.0
import QtQuick.Controls 1.2
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant

//import Multimedia 1.0
import TheXImage 1.0
import TheXSettings 1.0
import TheXDevice 1.0
import Apps 1.0

HSTab {
    //Item{
    id:imgGridTab
    property bool isCopy:true

    property DevCtl devctl: HSPluginsManager.get('devctl')
    property var mediaInfo: devctl ? devctl.mediaInfo : null
    property var mediaImage: mediaInfo ? mediaInfo.mediaImage : 0

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0

    property PictureCtl picturectl: HSPluginsManager.get('picturectl')
    property var imageList: picturectl ? picturectl.imageList : null

    ListModel {
        id: listModel
    }

    IControls.GridViewC {
        id:gridViewC
        opacity: imgText.visible ? 0:1
        anchors.left: parent.left
        anchors.leftMargin: 19
        anchors.fill: parent
        model:listModel
        delegate: IControls.GridItemDelegateC {
            id: delegateItem
            themeColor: interfacemodel
            iconurl: "file://" + filepath
            iconerrorurl: "qrc:/resource-usb/Media_Icon_Photo.png"
            onClicked: {
                application.changePage('image_full_screen',{
                                           properties: {
                                               imgSource1:"file://" + filepath,
                                               trackId: ID,
                                               trackPath:filepath,
                                               trackPlayRangen: 0
                                           },
                                           needUpdate: true
                                       } )
            }
        }

        gridView.usePaginationLoader: true
        gridView.paginationLoaderDelegate: UControls.PaginationLoaderDelegate {
            function loadPageAsync(page, cb) {//单页的发送最大不超过50张图片
                console.debug("loadPageAsync mediaImage:" + mediaImage)
                var handler = function (imageList){
                    JSLibs.clearTimeout(timer);
                    picturectl.imageListChanged.disconnect(handler);
                    cb(null, imageList);
                }
                var timer = JSLibs.setTimeout(function () {
                    picturectl.imageListChanged.disconnect(handler);
                    cb(null, []) ;
                }, 1000*30);
                var picturectl = HSPluginsManager.get('picturectl');
                picturectl.imageListChanged.connect(handler);
                if(mediaImage > 0){
                    picturectl.getImageList(page);
                } else{
                    cb(null, []);
                }
            }
        }
    }


    Text{
        id:imgText
        visible: listModel.count === 0
        anchors.centerIn: parent
        font.pointSize: 28
        text:qsTr(mediaImage > 0 ? "正在扫描文件..." : '无图片文件...')
        color:"white"
    }
}
