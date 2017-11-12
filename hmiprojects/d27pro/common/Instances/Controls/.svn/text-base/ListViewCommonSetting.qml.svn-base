import QtQuick 2.0
//通用设置
Item {
    id: bg
    width: 1040
    height: 628

    ListView{
        id: setting
        width: 994
        height: 628
        model: ListModel{
            ListElement{caption:qsTr("设定日期") }
            ListElement{caption:qsTr("设定时间") }
            ListElement{caption:qsTr("使用24小时格式") }
            ListElement{caption:qsTr("屏幕亮度"); widLine: "1"}
            ListElement{caption:qsTr("主题"); widLine: "2"}
            ListElement{caption:qsTr("屏保待机"); widLine: "2"}
            ListElement{caption:qsTr("语言"); widLine: "2"}
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
                id: txt
                active: index != 2 && index != 3
                sourceComponent: Component{
                    ListItemDelegateF{
                        textL: qsTr(caption)

                    }
                }
            }
            Loader{
                id: switches
                active: index == 2
                sourceComponent: Component{
                    ListItemDelegateH{
                        text: qsTr(caption)
                        onCheckedChanged: {

                        }
                    }
                }
            }
            Loader{
                id: slider
                active: index == 3
                sourceComponent: Component{
                    ListItemDelegateG{
                        text: qsTr(caption)
                        numFlag: false
                        onValueChanged: {

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

