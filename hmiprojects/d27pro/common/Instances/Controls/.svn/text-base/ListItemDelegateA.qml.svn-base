import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//配对设备
IControls.ListItemDelegate{
    id: root
    height: 124

    property url iconurl;
    property string phonename;
    property string phonestate;
    property string btnname;
    property int thememodel;
    signal notifyclicked;

    useFirstLine: false
    isFlickable: false

    normalColor: '#00000000'
    pressingColor: normalColor
    checkedNormalColor: normalColor
    checkedPressingColor: normalColor

    onStateChanged:{
        console.debug('state: ',state,index);
    }

    contentComponent: Component{
        Item{
            anchors.fill: parent;
            Image {
                id: icon;
                anchors.left: parent.left;
                anchors.leftMargin: 66;
                anchors.verticalCenter: parent.verticalCenter;
                source: iconurl;
            }

            Item{
                anchors.left: icon.right;
                anchors.leftMargin: 45;
                anchors.top: parent.top;
                anchors.topMargin: 20;
                UControls.NonAnimation_Text{
                    id: nametx;
                    font.pixelSize: 32;
                    color: '#FFFFFF';
                    text: phonename;
                    width:645
                    elide:Text.ElideRight
                }
                UControls.NonAnimation_Text{
                    id:statetx;
                    anchors.top: nametx.bottom;
                    anchors.topMargin: 9;
                    font.pixelSize: 30;
                    color: '#73777A'
                    text: phonestate;
                }
            }

            IControls.RoundLabButtonA{
                width: 160;
                height:65;
                anchors.right: parent.right;
                anchors.rightMargin: 10;
                anchors.verticalCenter: parent.verticalCenter;
                themeColor: thememodel
                UControls.NonAnimation_Text{
                    anchors.centerIn: parent;
                    font.pixelSize: 32;
                    color: '#FFFFFF';
                    text: btnname;
                }
                onClicked: notifyclicked();
            }
        }
    }
}

