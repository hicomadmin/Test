import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/Instances/Core' as ICore

IControls.DialogConfirmBase{
    id: root;
    contentWidth: 732;
    contentHeight: 430;

    property string textinfo: '';
    property int pixelSizetitle: 36;
    property int pixelSizeinfo: 36;

    signal confirmed_info(var info);
    signal canceled_info(var info);

    property url sourceUrl
    property alias loadItem: load.item
    property bool isVisble: true
    Loader{
        id: load
        anchors.top: parent.top
        anchors.topMargin: 92
        source: sourceUrl
        onLoaded: {
            load.item.complete.connect(function confirmed(txt){
                textinfo = txt;
                load.item.visible = false;
                isVisble = true;
                root.isEnable = true;
                })
        }
    }


    infoComponent: Component{
        Item{
            visible: isVisble
            Rectangle{
                anchors.fill: parent;
                color:themeColor == 0 ? "#103c4b":(themeColor == 1 ?"#480E05":"#3c2513")

                Rectangle{
                    width: 650;
                    height: 88;
                    border.color: themeColor == 0 ? '#1D7A80':(themeColor == 1 ?"#ff2200":"#986142");
                    border.width: 4;
                    anchors {
                        top: parent.top;
                        topMargin: 50; // fixme
                        horizontalCenter: parent.horizontalCenter;
                    }
                    color: '#0A1920';
                    radius: 3;
                    IControls.MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            sourceUrl = "qrc:/settings/VirtualKeyboard.qml"
                            loadItem.txt = textinfo
                            isVisble = false
                            loadItem.visible = true
                            root.isEnable = false

                        }
                    }

                    IControls.NonAnimationText_FontLight {
                        id:infotx;
                       anchors.centerIn: parent;
                       color: "#FFFFFF";
                       text: root.textinfo;
                       font.pixelSize: root.pixelSizetitle;
                   }
                }
            }
        }
    }
    onConfirmed: {
        sourceUrl = "";
        confirmed_info(textinfo);
    }
    onCanceled: {
        sourceUrl = "";
        canceled_info(textinfo);
    }
}

