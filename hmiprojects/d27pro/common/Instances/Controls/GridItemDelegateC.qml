import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//图片代理
UControls.GridItemDelegateBase{
    id:root;
    width: 240;
    height: 240;

    property url iconurl
    property url iconerrorurl
    property int themeColor;
    layerDisp: false;
    normalColor: '#00000000';
    pressingColor: themeColor == 0 ? '#66F8D4' : (themeColor == 1 ? "#FF2200" : "#986142");
    pressingOpacity: 0.5;
    checkedNormalColor: normalColor;



    bgSourceComponent:Component{
        Item{
            Image {
                id:icon;
                width: 240;
                height: 240;
                fillMode: Image.PreserveAspectCrop
                source: iconurl
                sourceSize.width: 240
                sourceSize.height: 240
                asynchronous: true
                cache: false
                clip: true
            }
            Image {
                id:iconerr
                visible:icon.status !== Image.Ready
                width: 240
                height: 240
                fillMode: Image.PreserveAspectCrop
                source: iconerrorurl
                sourceSize.width: 240
                sourceSize.height: 240
                clip: true
            }
        }
    }

}






