import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//专辑列表
IControls.ListItemDelegate{
    id: root
    height: 124

    property string filename;
    property url stateiconurl;
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

            UControls.Animation_Text{
                id: nametx;
                width: 200;
                anchors.left: parent.left;
                anchors.leftMargin: 64;
                font.pixelSize: 32;
                color: '#FFFFFF';
                text: filename;
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
