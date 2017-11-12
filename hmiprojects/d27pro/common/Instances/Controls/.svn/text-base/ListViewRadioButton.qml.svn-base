import QtQuick 2.0
import QtQuick.Controls 1.2

Image {
    id: bg
    source: "qrc:/resources/BG.png"

    ListView{
        id: listLight
        width: 1180
        height: 628
        anchors.top: parent.top
        anchors.topMargin: 92
        anchors.left: parent.left
        anchors.leftMargin: 46
        model:[qsTr("关闭"),qsTr("红色"),qsTr("粉紫色"),qsTr("黄色"),qsTr("橙色"),qsTr("冰蓝色"),qsTr("白色"),qsTr("冰绿色"),qsTr("随主题色")]
        delegate: items
        clip: true
    }
    ExclusiveGroup{
        id: selected
    }
    Component{
        id: items
        ListDelegateRadioButton{
            text: qsTr(modelData)
            exclusiveGroup: selected
        }
    }
    Fixed_ScrollBar{
        y: 92
        visible: listLight.visible
        view: listLight
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
}


