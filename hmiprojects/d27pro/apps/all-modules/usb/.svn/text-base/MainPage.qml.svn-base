import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
//import Multimedia 1.0
import TheXMusic 1.0
import TheXDevice 1.0
import TheXVideo 1.0
import TheXImage 1.0
import TheXFolder 1.0
import TheXSettings 1.0
ICore.Page {
    id: menulist
    property bool isCopy: false
    property MusicCtl musicctl: HSPluginsManager.get('musicctl')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property int filenum
    property bool havedata
    property int interfacemodel

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    IControls.TabBarA{
        id:tabe
        anchors.fill: parent;
        application: menulist.application
        themeColor: interfacemodel

        tabs: ({
                   music: {url: Qt.resolvedUrl('music.qml')},
                   video: {url: Qt.resolvedUrl('video.qml')},
                   image: {url: Qt.resolvedUrl('image.qml')},
                   folder: {url: Qt.resolvedUrl('folder.qml')},
                   childfolderlist: {url: Qt.resolvedUrl('childFolderlist.qml')},
                   child_folderlist: {url: Qt.resolvedUrl('childFolderlist.qml')}
//                   albumlist:{ url: Qt.resolvedUrl('music_album_list.qml')}
               })
        initialTab: 'music';
        tabsModel: [
            {
                tab: 'music',
                tabTitle: qsTr("音乐"),
                tabImage:'qrc:/resource-usb/Media_Icon_Music.png'
            },
            {
                tab: 'video',
                tabTitle: qsTr("视频"),
                tabImage:'qrc:/resource-usb/Media_Icon_video.png'
            },
            {
                tab: 'image',
                tabTitle: qsTr("图片"),
                tabImage:'qrc:/resource-usb/Media_Icon_Photo.png'
            },
            {
                tab: 'folder',
                tabTitle: qsTr("文件夹"),
                tabImage:'qrc:/resource-usb/Media_Icon_Folder.png'
            }

        ]
    }
}
