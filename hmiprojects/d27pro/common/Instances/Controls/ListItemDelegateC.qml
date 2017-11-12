import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//文件夹
IControls.ListItemDelegate{
    id: root
    height: 124


    property url iconurl;
    property string file_name;
    property url stateiconurl;
    property string filetype;
    property int themeColor;

    useFirstLine: false
    isFlickable: false

    normalColor: '#00000000'
    pressingColor: themeColor == 0 ? '#105769' :(themeColor == 1 ? "#FF2200" : "#986142")
    checkedNormalColor: normalColor
    checkedPressingColor: normalColor

    contentComponent: Component{
        Item{
            anchors.fill: parent;
            Image {
                id: icon;
                anchors.left: parent.left;
                anchors.leftMargin: 89;
                anchors.verticalCenter: parent.verticalCenter;
                source: iconurl;
            }

            UControls.NonAnimation_Text{
                id: nametx;
                width: 800
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon.right;
                anchors.leftMargin: filetype === 'folder' ? 26 : 59;
                font.pixelSize: 32;
                color: '#FFFFFF';
                text: file_name;
                elide:Text.ElideRight
            }

            Image {
                id: iconstate;
                anchors.right: parent.right;
                anchors.rightMargin: 10;
                anchors.verticalCenter: parent.verticalCenter;
                source: stateiconurl;
            }
        }
    }
}
