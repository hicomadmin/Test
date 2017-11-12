import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import TheXAux 1.0

ICore.Page {
    id: mainPage

    property AUXCtl aux: HSPluginsManager.get('aux')

    visible: false

    onAuxChanged: {
        aux.getAllInfo();
        console.debug("auxReady: ", aux.auxReady);
    }

    Image {
        anchors.centerIn: parent
        source: "qrc:/resources-theAUX/media-icon-AUX_example_icon.png"
    }

/*<Bug #214     chengzhi/1608003   20161021    begin*/
//    IControls.NonAnimationText_FontRegular {
//        id: gainTxt
//        anchors.top: parent.top
//        anchors.topMargin: 135   //143
//        anchors.horizontalCenter: parent.horizontalCenter
//        text: qsTr("增益设置")
//        color: "#FFFFFF"
//        font.pixelSize: 36
//    }


//    ExclusiveGroup {
//        id: gainInputGroup
//    }

//    Row {
//        id: gaingrid
//        anchors.left: parent.left
//        anchors.leftMargin: 111
//        anchors.top: parent.top
//        anchors.topMargin: 290
//        //gainState	增益等级	double	int: 1, low 2, mid 3, high
//        layoutDirection: Qt.RightToLeft

//        spacing: 119

//        Repeater {
//            model: ["低","中","高"]
//            IControls.RoundIconButtonA {
//                id: rbtn
//                width: 270
//                height: 104
//                normalSource: "qrc:/resources-theAUX/media-icon-AUX_zyseting_s.png"
//                pressingSource: "qrc:/resources-theAUX/media-icon-AUX_zyseting_sel.png"
//                checked: (index === (gainState - 1)) ? true: false

//                exclusiveGroup: gainInputGroup

//                onClicked: {
//                    if(!checked){
//                        checked = true

//                        aux.setGainState( index + 1);
//                        console.debug("The Aux setGainState:", index + 1);
//                    }

//                }
//                onLongPressed: {
//                }

//                Image {
//                    id: checkimg
//                    anchors.left: parent.left
//                    anchors.leftMargin: 44
//                    anchors.verticalCenter:  parent.verticalCenter
//                    source: rbtn.checked ? "qrc:/resources/set_icon_NO.png" : "qrc:/resources/set_icon_off.png"
//                }

//                IControls.NonAnimationText_FontRegular {
//                    id: checktxt
//                    anchors.left: checkimg.right
//                    anchors.leftMargin: 93
//                    anchors.verticalCenter: parent.verticalCenter
//                    font.pixelSize: 36
//                    color: "#FFFFFF"
//                    text: qsTr(modelData)
//                }

//            }
//        }

//    }
/*Bug #214    chengzhi/1608003   20161021    end*/
}

