import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//音乐代理
UControls.GridItemDelegateBase{
    id:root;
    width: 250;
    height: 281;

    property string file_name;
    property url iconurl;
    property url iconerrorurl;
    property int themeColor;

    layerDisp: true;
    normalColor: '#00000000';
    pressingColor: themeColor == 0 ? '#66F8D4' : (themeColor == 1 ? "#FF2200" : "#986142");
    pressingOpacity: 1.0;
    checkedNormalColor: normalColor;

    onStateChanged: {
        console.debug('state: ',state,index);
    }

    bgSourceComponent:Component{
        Item{
            Image {
                id:icon;
                anchors.top: parent.top;
                anchors.topMargin: 2;
                anchors.left: parent.left;
                anchors.leftMargin: 5;
                width: 240;
                height: 240;
                source: iconurl;
            }
            Image {
                id:iconerr
                visible:icon.status !== Image.Ready
                anchors.top: parent.top;
                anchors.topMargin: 2;
                anchors.left: parent.left;
                anchors.leftMargin: 5;
                width: 240;
                height: 240;
                source: iconerrorurl;
            }
            IControls.AnimationText_FontLight{
                id:nametx;
                width: 250;
                height: 40;
                anchors.top: icon.bottom;
                anchors.horizontalCenter: icon.horizontalCenter;
                textColor: '#FFFFFF';
                font.pixelSize: 26
                text: file_name;
                textCenter:true
            }
        }
    }

}




