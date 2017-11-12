import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
//import Multimedia 1.0
import TheXMusic 1.0
import TheXSettings 1.0

ICore.Page {
    id: root;
    anchors.fill: parent;
    onItemAfterCreated:{
        console.debug('root width: ',root.width);
        console.debug('root height: ',root.height);
    }
    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    IControls.TabBarA{
        id:tabe
        themeColor: interfacemodel
        anchors.fill: parent;
        application: root.application

        tabs: ({
                   music: {url: Qt.resolvedUrl('music.qml')},
                   video: {url: Qt.resolvedUrl('video.qml')},
                   image: {url: Qt.resolvedUrl('image.qml')},
                   folder: {url: Qt.resolvedUrl('folder.qml')},
                   music_album:{ url: Qt.resolvedUrl('music_album_list.qml')}
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
                tabImage:'qrc:/resources-usb/Media_Icon_video.png'
            },
            {
                tab: 'image',
                tabTitle: qsTr("图片"),
                tabImage:'qrc:/resources-usb/Media_Icon_Photo.png'
            },
            {
                tab: 'folder',
                tabTitle: qsTr("文件夹"),
                tabImage:'qrc:/resources-usb/Media_Icon_Folder.png'
            }
        ]
    }
}

