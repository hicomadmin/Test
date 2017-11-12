import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//音乐全部
IControls.ListItemDelegate{
    id: root
    height: 124

    property url iconurl
    property bool iconvisible:true
    property url iconerrorurl
    property string music_filename;
    property string music_artistname;
    property url stateiconurl;
    property bool mousestateenabled
    signal mousestateclicked
    property int themeColor;

    useFirstLine: false
    isFlickable: false

    normalColor: '#00000000'
    pressingColor: themeColor == 0 ? '#105769' :(themeColor == 1 ? "#FF2200" : "#986142")
    checkedNormalColor: normalColor
    checkedPressingColor: normalColor

    contentComponent: Component{
        Item{

            Image {
                id: icon;
                width: iconvisible ? 100 : 0
                height: 100
                anchors.left: parent.left;
                anchors.leftMargin: 70
                anchors.verticalCenter: parent.verticalCenter;
                fillMode: Image.PreserveAspectCrop
                source: iconurl
                sourceSize.width: 100
                sourceSize.height: 100
                clip: true
            }
            Image {
                id:iconerr
                visible:icon.status !== Image.Ready
                width: iconvisible ? 100 : 0
                height: 100
                anchors.left: parent.left;
                anchors.leftMargin: 70
                anchors.verticalCenter: parent.verticalCenter;
                fillMode: Image.PreserveAspectCrop
                source: iconerrorurl
                sourceSize.width: 100
                sourceSize.height: 100
                clip: true
            }

            Item{
                anchors.left: icon.right;
                anchors.leftMargin: 41;
                anchors.top: parent.top;
                anchors.topMargin: 10;
                UControls.NonAnimation_Text{
                    id: nametx;
                    width: 750;
                    font.pixelSize: 38;
                    color: '#EBEEF0';
                    text: music_filename ? music_filename : qsTr("未知");
                    elide:Text.ElideRight
                }
                UControls.NonAnimation_Text{
                    id:statetx;
                    anchors.top: nametx.bottom;
                    font.pixelSize: 32;
                    color: '#818789'
                    text: music_artistname ? music_artistname : qsTr("未知");
                }
            }

            Image {
                id: iconstate;
                width: 130
                anchors.right: parent.right;
                anchors.rightMargin: 35;
                anchors.verticalCenter: parent.verticalCenter;
                source: stateiconurl;
                fillMode: Image.PreserveAspectFit
                IControls.MouseArea {
                    id: mousestate
                    anchors.fill: parent
                    enabled: mousestateenabled
                    onClicked: mousestateclicked()
                }
            }
        }
    }
}

