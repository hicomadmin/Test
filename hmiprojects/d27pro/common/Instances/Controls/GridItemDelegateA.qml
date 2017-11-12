import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//视频代理
UControls.GridItemDelegateBase{
    id:root;
    width: 328;
    height: 284;

    property string filename;
    property url iconurl;
    property url iconerrorurl;
    property int themeColor

    layerDisp: true;
    normalColor: '#00000000';
    pressingColor:themeColor == 0 ? '#66F8D4' : (themeColor == 1 ? "#FF2200" : "#986142");
    pressingOpacity: 1.0;
    checkedNormalColor: normalColor;

    bgSourceComponent:Component{
        Item{
            Image {
                id:icon;
                anchors.top: parent.top;
                anchors.topMargin: 2;
                anchors.left: parent.left;
                anchors.leftMargin: 5;
                width: 320;
                height: 240;
                source: iconurl
                sourceSize.width: 320
                sourceSize.height: 240
            }
            Image {
                id:iconerr
                visible:icon.status !== Image.Ready
                anchors.top: parent.top;
                anchors.topMargin: 2;
                anchors.left: parent.left;
                anchors.leftMargin: 5;
                width: 320;
                height: 240;
                source: iconerrorurl
            }
            IControls.AnimationText_FontLight{
                id:nametx;
                width: 250;
                height: 35;
                anchors.top: icon.bottom;
                anchors.horizontalCenter: icon.horizontalCenter;
                textColor: '#FFFFFF';
                font.pixelSize: 24
                text: filename;
                textCenter: true
            }
        }
    }

}




