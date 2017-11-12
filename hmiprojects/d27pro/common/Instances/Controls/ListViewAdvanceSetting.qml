import QtQuick 2.0
//高级设置
Item {
    id: bg
    width: 1040
    height: 628

    ListView{
        id: setting
        width: 994
        height: 628
        model: ListModel{
            ListElement{caption:qsTr("可变氛围灯设置") }
            ListElement{caption:qsTr("语音提醒") }
            ListElement{caption:qsTr("恢复默认设置"); widLine: "1"}
            ListElement{caption:qsTr("版本信息"); widLine: "1"}
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
        ListItemDelegateF{
            textL: qsTr(caption)
            onClicked: {

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
}

