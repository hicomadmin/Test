import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import TheXMcan 1.0

UControls.Dialog{
    id: root;
    contentWidth: 732
    contentHeight: 550
    clickClose: true

    property bool autoClose: false
    property int themeColor: 0
    property string text: ""
    property bool isOverlay:false
    property string img: "qrc:/resources/voice_remind_bg_blue.png"
    property var objects: new Array

    shadowComponent: Component {  //整个窗口背景
        Item {
            id: background;
            width: root.width;
            height: root.height;
            Image {
                id: bgImage;
                visible: !isOverlay
                anchors.bottom: parent.bottom;
                source: "qrc:/resources/voice_remind_bg_black.png";
            }
            Rectangle {
                id: bgImage2
                visible: isOverlay
                anchors.bottom: parent.bottom;
                width:1280
                height: 628
                color: "#000001"
            }
        }
    }

    contentComponent: Component {   //弹出框中的内容
        Item {
            id:content;
            width: root.width;
            height: root.height;

            Image {
                id: sourceImage;
                anchors.top: parent.top;
                anchors.topMargin: 44;
                anchors.horizontalCenter: parent.horizontalCenter;
                antialiasing:true;
                smooth: true;
                source: root.img;
            }

            UControls.Label{
                id: info;
                anchors.top: sourceImage.top;
                anchors.topMargin: 23;
                anchors.horizontalCenter: sourceImage.horizontalCenter;
                color: "#FFFFFF";
                font.pixelSize: 38;
                text: qsTr(root.text);
            }
        }
    }

    onClosed:
    {
        console.debug("dialog voice remind onClosed");
        objects.splice(0, objects.length);
    }

    function addChildImage(remindId, parentItem)
    {
        console.debug("[home Application] addChildImage", remindId);
        var url;
        var topMargin;
        var leftMargin;
        switch (remindId)
        {
        case McanCtl.DOOR_BC_INDEX:
            topMargin = 555;
            leftMargin = 598;
            url = "\"qrc:/resources/voice_remind_trunk.png\"";
            break;
        case McanCtl.DOOR_LF_INDEX:
            topMargin = 373;
            leftMargin = 524;
            url = "\"qrc:/resources/voice_remind_left_up.png\"";
            break;
        case McanCtl.DOOR_LR_INDEX:
            topMargin = 430;
            leftMargin = 524;
            url = "\"qrc:/resources/voice_remind_left_down.png\"";
            break;
        case McanCtl.DOOR_RF_INDEX:
            topMargin = 373;
            leftMargin = 695;
            url = "\"qrc:/resources/voice_remind_right_up.png\"";
            break;
        case McanCtl.DOOR_RR_INDEX:
            topMargin = 430;
            leftMargin = 695;
            url = "\"qrc:/resources/voice_remind_right_down.png\"";
            break;
        default:
            return;
        }
        var obj = Qt.createQmlObject('import QtQuick 2.3; Image {' +
                                     'anchors.top: root.top;' +
                                     'anchors.topMargin: ' + topMargin + ';' +
                                     'anchors.left: root.left;' +
                                     'anchors.leftMargin: ' + leftMargin + ';' +
                                     'source: ' + url + ';' +
                                     '}',
                                     parentItem,
                                     "dynamicSnippet");
        objects.push(obj);
    }

    function clearChildImage()
    {
        console.debug("[home Application] clearChildImage", objects.length);
        for (var i in objects) {
            objects[i].destroy();            //delete qml object
        }
        objects.splice(0, objects.length)    //clear the array of objects
    }
}
