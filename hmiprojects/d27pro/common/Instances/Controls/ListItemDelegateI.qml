import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//连接设备
//IControls.ListItemDelegate{
//    id: root
//    height: 124

//    property url iconurl;
//    property string phonename;

//    useFirstLine: false
//    isFlickable: true

//    contentComponent: Component{
        Item{
            width: 996
            height: 124
            property url iconurl;
            property string phonename;
            Image {
                id: icon
                anchors.left: parent.left
                anchors.leftMargin: 75
                anchors.verticalCenter: parent.verticalCenter
                source: iconurl
            }
            UControls.NonAnimation_Text{
                id: txt
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: icon.right
                anchors.leftMargin: 36
                font.pixelSize: 32
                color: '#FFFFFF'
                text: phonename
            }
            Image {
                id: bottomLine
                anchors.bottom: parent.bottom
                source: "qrc:/resources/list_lineA2.png"
            }
        }
//    }
//}

