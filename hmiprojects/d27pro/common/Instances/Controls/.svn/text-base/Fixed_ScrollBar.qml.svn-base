import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
//不带刷新加载功能的滚动条，适用于行数固定的列表，如设置界面。
Rectangle{


    id:root
    width:0
    height:0
    color:"transparent"
    property var view

    Rectangle {
        id: fixed_scrollbar
        x:-10
        y:view.visibleArea.yPosition * view.height
        width: 9
        height: view.visibleArea.heightRatio * view.height;
        color: "#5c5f61"


        // 鼠标区域
        IControls.MouseArea {
            id: mouseArea
            anchors.fill: fixed_scrollbar
            drag.target: fixed_scrollbar
            drag.axis: Drag.YAxis
            drag.minimumY: 0
            drag.maximumY: view.height - fixed_scrollbar.height

            // 拖动
            onMouseYChanged: {
                view.contentY = fixed_scrollbar.y / view.height * view.contentHeight
            }
        }
    }

}
