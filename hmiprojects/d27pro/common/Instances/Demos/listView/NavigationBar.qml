import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import 'qrc:/UI/Core' as UCore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    anchors.left: parent.left

    property url sourceImage: '';
    Grid {
        id: gridBtn
        columns: 1
        rows: 4
        spacing:4
        anchors {
            top: parent.top
            left: parent.left
        }
        Repeater {
            id:btnRepeater

            model: [
                {
                    iconNormalSource: 'qrc:/resources/Media_Icon_Music.png',
                    btnName: QT_TR_NOOP('音乐'),
                    visable: true
                    //page: 'quickDial'
                },
                {
                    iconNormalSource: 'qrc:/resources/Media_Icon_video.png',
                    btnName: QT_TR_NOOP('视频'),
                    visable: true
                    //page: 'cm'
                },
                {
                    iconNormalSource: 'qrc:/resources/Media_Icon_Photo.png',
                    btnName: QT_TR_NOOP('图片'),
                    visable: true
                   // page: 'phoneBook'
                },
                {
                    iconNormalSource: 'qrc:/resources/Media_Icon_Folder.png',
                    btnName: QT_TR_NOOP('文件夹'),
                    visable: true
                   // page: ''
                }
            ]
           delegate:Component{
               UControls.LabelButton {
                id: btn
                width: 242
                height: 154
                bgSourceComponent: Component {
                   UControls.Bg_Gradient{
                       id:btn_gradient
    //                    rotiation:90
                       Rectangle{
                           id:splitline
                           width:btn_gradient.width
                           Image{
                               id:imageline;
                               source: sourceImage;
                               fillMode:Image.Stretch
                           }
                           anchors.top: btn_gradient.bottom
                       }
                   }

                }
                onClicked: {
                    console.debug("onStateChanged: " ,state);
                    if(state === "checkedNormal" ){
                         sourceImage = 'qrc:/resources/list_line_left 1.png'

                    } else {
                         sourceImage = 'qrc:/resources/list_line_left 2.png'
                    }

                }

//                onStateChanged: {
//
//                }
                label.font.pixelSize: 36
                normalColor: '#ffffff'
                focusingColor: normalColor
                text: qsTr(modelData.btnName)
                label.anchors {
                    left: btn.left
                    leftMargin: 100
                    verticalCenter: btn.verticalCenter
                }
                UControls.Icon {
                    anchors {
                        left: btn.left
                        leftMargin: 41
                        verticalCenter: btn.verticalCenter
                    }
                    source: modelData.iconNormalSource

                    }
                }

           }
        }
}
}
