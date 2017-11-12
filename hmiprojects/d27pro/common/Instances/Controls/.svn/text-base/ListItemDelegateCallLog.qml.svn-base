import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//电话本
IControls.ListItemDelegate{
    id: root
    height: 124


    property url iconurl;
    property string contactname;
    property string contactnum;
    property url stateiconurl;
    property string calltime;
    property int themeColor;

    useFirstLine: false
    isFlickable: false

    normalColor: '#00000000'
    pressingColor: themeColor == 0 ? '#105769' :(themeColor == 1 ? "#FF2200" : "#986142")
    checkedNormalColor: normalColor
    checkedPressingColor: pressingColor

    contentComponent: Component{
        Item{
            anchors.fill: parent;
            Image {
                id: icon;
                anchors.left: parent.left;
                anchors.leftMargin: 42;
                anchors.verticalCenter: parent.verticalCenter;
                source: iconurl;
            }

            Item{
                anchors.left: icon.right;
                anchors.leftMargin: 23;
                anchors.top: parent.top;
                anchors.topMargin: 15;
                UControls.NonAnimation_Text{
                    id: nametx;
                    font.pixelSize: 32;
                    color: '#FFFFFF';
                    text: contactname;
                    width:400
                    elide:Text.ElideRight
                }
                UControls.NonAnimation_Text{
                    id:statetx;
                    anchors.top: nametx.bottom;
                    anchors.topMargin: 15;
                    font.pixelSize: 30;
                    color: '#73777A'
                    text: contactnum;
                    width:400
                    elide:Text.ElideRight
                }
            }

            Image {
                id: iconstate;
                anchors.right: timetx.left;
                anchors.rightMargin: 137;
                anchors.verticalCenter: parent.verticalCenter;
                source: stateiconurl;
            }

            UControls.NonAnimation_Text{
                id:timetx;
                anchors.right: parent.right;
                anchors.rightMargin: 10;
                anchors.verticalCenter: parent.verticalCenter;
                font.pixelSize: 30;
                color: '#FFFFFF'
                text: calltime;
            }
        }
    }
}

