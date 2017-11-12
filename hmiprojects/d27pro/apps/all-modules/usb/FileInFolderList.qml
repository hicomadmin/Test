import QtQuick 2.0
import QtQuick.Controls 1.2
import  'qrc:/Instances/Core' as ICore
import  'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls

ICore.Page {
    id: subfileList
    title: '文件夹1'

    function initList () {

    }

    function updateList () {

    }

     function increIndex () {

     }

     function decreIndex () {

     }

    ListModel {
        id: listModel
    }

    IControls.ListViewC {
        id: playlist
        model: listModel
        delegate:IControls.ListItemDelegateC {
                id: itemdistr
                text : trackName
                normalColor: '#FFFFFF'
                pressingColor: '#000000'
                focusingColor: '#FF8F1C'
                onClicked: {
                    listClicked() ;
                    usbctl.dirfileList() ;
                }
                function listClicked () {
                    application.changePage('songlist') ;
                }
        }
    }
    UControls.RatioText {
            anchors.right:parent.right
            anchors.rightMargin: 24+80
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 6
            numColor: '#AAABBB'
            denFontSize: 24
            numFontSize: denFontSize
            denText: 999
            numText: 000
    }
}
