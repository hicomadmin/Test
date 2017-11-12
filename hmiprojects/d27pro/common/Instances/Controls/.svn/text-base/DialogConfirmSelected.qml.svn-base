import QtQuick 2.0
import QtQuick.Controls 1.4
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

IControls.DialogConfirmBase{
    id: root;
    contentWidth: 732;
    contentHeight: 610;

    property string textinfo: '';
    property int pixelSizetitle: 36;
    property int pixelSizeinfo: 36;
    property int index: 0;

    property url buttonON: root.themeColor == 0?"qrc:/resources/set_icon_NO.png":(themeColor == 1 ? "qrc:/resources/set_icon_NO_o.png":"qrc:/resources/set_icon_NO_g.png")
    property url buttonOff: root.themeColor == 0?"qrc:/resources/set_icon_off.png":(themeColor == 1 ? "qrc:/resources/set_icon_off_o.png":"qrc:/resources/set_icon_off_g.png")
    signal confirmed_info(var info);
    signal canceled_info(var info);

    infoComponent: infocom;

    onConfirmed: confirmed_info(root.index);
    onCanceled: canceled_info(root.index);

    Component{
        id:infocom;
        Column{
            width: root.width;
            height: 610-110-2;
            ExclusiveGroup{
                id: selectgroup;
            }
            Repeater{

                model: [{
                    name:'OPEN',
                    select: root.index === index ? true : false
                },
                {
                    name:'WPA-PSK',
                    select: root.index === index ? true : false
                },
                {
                    name:'WPA-2-PSK',
                    select: root.index === index ? true : false
                }
                ];
                Item{
                    width: parent.width;
                    height: 122 +2;
                    Image {
                        anchors.bottom: selectitem.top;
                        source: themeColor == 0?"qrc:/resources/Popup_line.png":(themeColor == 1 ? "qrc:/resources/Popup_line_o.png":"qrc:/resources/Popup_line_g.png")
                    }
                    Rectangle{
                        id:selectitem;
                        width: parent.width;
                        height: 122;
                        color:"#00000000";
                        IControls.NonAnimationText_FontLight{
                            anchors.left: parent.left;
                            anchors.leftMargin: 50;
                            anchors.verticalCenter: parent.verticalCenter;
                            text: qsTr(modelData.name)
                            color: "#FFFFFF";
                            font.pixelSize: 36
                        }
                        UControls.ImageButton {
                            id: btn
                            width: 62;
                            height: 62;
                            anchors.right: parent.right;
                            anchors.rightMargin: 50;
                            anchors.verticalCenter: parent.verticalCenter;
                            normalSource: buttonOff
                            checkedNormalSource: buttonON
                            checked: root.index === index ? true : false;  // modelData.select;
                            exclusiveGroup: selectgroup;

                        }
                        IControls.MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                btn.checked = true
                                root.index = index
                            }
                        }
                    }
                }
            }
        }
    }
}


