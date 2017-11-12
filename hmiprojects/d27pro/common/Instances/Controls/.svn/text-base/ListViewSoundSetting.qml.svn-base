import QtQuick 2.0
Item {
    id: bg
    width: 1040
    height: 628

    ListView{
        id: setting
        width: 994
        height: 628
        model: ListModel{
            ListElement{caption:qsTr("按键音") }
            ListElement{caption:qsTr("通话音量") }
            ListElement{caption:qsTr("媒体音量") }
            ListElement{caption:qsTr("导航和语音提示音") }
            ListElement{caption:qsTr("等响度"); widLine: "2"}
            ListElement{caption:qsTr("高音"); widLine: "2"}
            ListElement{caption:qsTr("低音"); widLine: "2"}
            ListElement{caption:qsTr("音场设置"); widLine: "2"}
            ListElement{caption:qsTr("音效设置"); widLine: "2"}
            ListElement{caption:qsTr("Arkmys音效"); widLine: "2"}
            ListElement{caption:qsTr("音量随速曲线"); widLine: "3"}
        }
        section.property: "widLine"
//        section.criteria: ViewSection.FullString
        section.delegate: wideLine
        delegate: item
        clip: true
//        snapMode: ListView.SnapToItem
        boundsBehavior: Flickable.StopAtBounds
    }
    Component{
        id: item
        Item {
            id: name
            width: 1040
            height: 124

            Loader{
                id: slider
                active: (index >= 1 && index <= 3)||index == 5||index == 6
                sourceComponent: Component{
                    ListItemDelegateG{
                        text: qsTr(caption)
                        numFlag: (index == 5||index == 6)?true:false
                        onValueChanged: {

                        }
                    }

                }
            }
            Loader{
                id: switches
                active: index == 0 || index == 4
                sourceComponent: Component{
                    ListItemDelegateH{
                        text: qsTr(caption)
                        onCheckedChanged: {

                        }
                    }
                }
            }
            Loader{
                id: txt
                active: index > 6
                sourceComponent: Component{
                    ListItemDelegateF{
                        textL: qsTr(caption)
                        onClicked: {

                        }

                    }
                }
            }
        }


    }
    Component{
        id: wideLine
        Item{
            width: 1040
            height: 40
            Rectangle{
                id: rect
                width: 1040
                height: 40
                color: "#ffffff"
                opacity: 0.06

            }
            Image {
                id: bottomLine
                anchors.bottom: rect.bottom
                source: "qrc:/resources/list_lineA2.png"
            }
        }
    }
    Fixed_ScrollBar{
//        y: 92
        anchors.right: parent.right
        anchors.rightMargin: 10
        view: setting
    }
}

