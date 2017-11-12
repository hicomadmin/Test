import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import TheXSettings 1.0
import Apps 1.0

ICore.Page {
    id: root
    property bool check
    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel
    property int themeColor: 0

    /* BEGIN by Xiong wei, 2016.12.13
     * Press the Power button to remove the dialog
    */
    property var currentDialog
    // End by xiongwei 2016 12 13

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
//        interfacemodel = system.interfacemodel
    }
    onInterfacemodelChanged: {
        themeColor = interfacemodel
    }

    /* BEGIN by Xiong wei, 2016.12.13
     * Press the Power button to remove the dialog
    */
    onVisibleChanged: {
        console.log("[SettingTheme] onVisibleChanged visible ")
        if(currentDialog) {
            if (!visible) {
                currentDialog.close()
            }
        }

    }

    function commonDialog(dialog){
        currentDialog = dialog;
        console.debug("[SettingTheme] currentDialog[text]" , currentDialog['text']);
    }
    // End by xiongwei 2016 12 13


    Item{
        width: 1280
        height: 628
        Row{
            id: themeRow
            width: 1280 - 32
            height: 628
            x: 16
            spacing: 15

            Repeater{
                model: [
                    {
                        name: qsTr('科技蓝'),
                        img: "qrc:/resources-settings/tech_blue.png",
                        mainColor: "#184c57",
                        theme: HSTranslator.ThemeBlue
                    },
                    {
                        name: qsTr('魅力橙'),
                        img: "qrc:/resources-settings/orange.png",
                        mainColor: "#ff2200",
                        theme: HSTranslator.ThemeOrange
                    },
                    {
                        name: qsTr('浪漫金'),
                        img: "qrc:/resources-settings/romance_gold.png",
                        mainColor: "#986142",
                        theme: HSTranslator.ThemeGold
                    }
                ];
                Image {
                    id: blue
                    anchors.verticalCenter: parent.verticalCenter
                    source: modelData.img
                    Rectangle{
                        width: 406 - 55
                        height: 258 - 55
                        color: "transparent"
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        border.width: 4
                        border.color: themeColor == index ? modelData.mainColor : "#00000000"
                        IControls.MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(index != themeColor){
                                themeColor = index
                                system.setInterfacemodel(index)
                                ctranslator.setQmlTheme(modelData.theme)
                                //Modify by xiongwei 2016.12.13
                                application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogProgress.qml',{themeColor: index,text:qsTr('主题更换中......')},commonDialog)
                                //End by xiongwei 2016.12.13
                                }
                            }
                        }

                        IControls.NonAnimationText_FontRegular{
                            anchors.bottom: parent.top
                            anchors.bottomMargin: 15
                            z: 1
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: themeColor == index ? modelData.mainColor : "#ffffff"
                            font.pixelSize: 36
                            text: qsTr(modelData.name)
                        }
                    }
                }

            }
        }
    }

}


