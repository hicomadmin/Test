import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

IControls.DialogConfirmBase{
    id: root;
    contentWidth: 732;
    contentHeight: 589;

    property string textinfo: '';
    property int pixelSizetitle: 36;
    property int pixelSizeinfo: 36;

    //input parameter
    property int currentYear
    property int currentMonth
    property int currentDay

    property int setYear
    property int setMonth
    property int setDay


    property color txtColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#fbcaac":"#ffe0c2")
    property color rectColor: themeColor == 0 ? "#184C57":(themeColor == 1?"#852516":"#ad7946")
    property color bordColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#fbcaac":"#ffe0c2")
    property color nomalColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#F7624B":"#BF690D")

    signal confirmed_info(var info);
    signal canceled_info(var info);

    onConfirmed: confirmed_info([setYear + 1970, setMonth + 1, setDay + 1]);
    onCanceled: canceled_info([setYear, setMonth, setDay]);

    infoComponent: datacom;
    Component{
        id:datacom;
        Item {
            width: 742
            height: 475
            property bool isLeap: false     // 表示当前年份是否闰年，改变年时改变
            property bool daychanges: false // 是否有天的改变
            property int currentMonthDays   // 当年和月份改变时，动态改变为当月的天数
            property int oldDayIndex        // 改变前,当前天的索引，月份和天改变时改变
            property int currentDayIndex    // 当前应该显示的天数索引
            property int check: 1
            Rectangle {
                id: root
                width: 160
                height: 300
                z: 1
                anchors.left: parent.left
                anchors.leftMargin: 66
                color: "transparent"
                PathView{
                    id: year
                    anchors.fill: parent
                    delegate: yearDelegate
                    model: 80
                    currentIndex: currentYear - 1970

                    path: Path{
                        startX: root.width/2
                        startY: 0
                        PathAttribute { name: "fontSize"; value: 38; }
                        PathLine { x: root.width/2; y: root.height*0.5; }
                        PathAttribute { name: "fontSize"; value: 54; }
                        PathLine { x: root.width/2; y: root.height; }
                        PathAttribute { name: "fontSize"; value: 38; }
                    }
                    pathItemCount: 3
                    maximumFlickVelocity: 0
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    dragMargin: parent.width
                    clip: true
                    onFlickStarted: {
                        check = 1
                    }
                    onDragEnded: {
                        positionViewAtIndex(currentIndex ,PathView.SnapPosition)
                    }

                    onCurrentIndexChanged: {
                        setYear = currentIndex
                        oldDayIndex = root3.dayIndex
                        if((currentIndex + 1970) % 4 == 0 && (currentIndex + 1970) % 400 != 0||(currentIndex + 1970) % 400 == 0){
                            isLeap = true
                        }
                        else{
                            isLeap = false
                        }

                        if(isLeap == true && ((currentMonthDays == 28) || (currentMonthDays == 29))){
                            currentMonthDays = 29
                        }
                        if(isLeap == false && ((currentMonthDays == 28) || (currentMonthDays == 29))){
                            currentMonthDays = 28
                        }

                    }
                    Component.onCompleted: {
                        if((currentIndex + 1970) % 4 == 0 && (currentIndex + 1970) % 400 != 0||(currentIndex + 1970) % 400 == 0){
                            isLeap = true
                        }
                        else{
                            isLeap = false
                        }
                    }
                    Rectangle{
                        anchors.centerIn: year
                        width: 160
                        height: 110
                        opacity:check == 1? 1: 0.3
                        radius: 5
                        border.width: 3
                        border.color: check == 1? /*"#4ff8f4"*/bordColor:nomalColor/*"#47636f"*/
                        color: check == 1 ? /*"#184C57"*/rectColor:"transparent"
                    }
                }

                Component{
                    id: yearDelegate
                    Rectangle{
                        id: wrapper2
                        width: 160
                        height: 110
                        visible: PathView.onPath
                        color: "transparent"

                        NonAnimationText_FontRegular {
                            id: txt
                            anchors.centerIn: parent
                            text: index + 1970
                            font.pixelSize: wrapper2.PathView.fontSize
                            color: (check == 1&&wrapper2.PathView.isCurrentItem)?/*"#4ff8f4"*/txtColor:"#ffffff"
                        }
                        IControls.MouseArea{
                            anchors.fill: parent
                            enabled: check == 1 ? false: true
                            onPressed:   {
                                check = 1
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: root2
                width: 160
                height: 300
                z: 1
                anchors.left: root.right
                anchors.leftMargin: 64
                color: "transparent"
                PathView{
                    id: month
                    anchors.fill: parent
                    delegate: monthDelegate
                    model: 12
                    currentIndex: currentMonth - 1

                    path: Path{
                        startX: root2.width/2
                        startY: 0
                        PathAttribute { name: "fontSize"; value: 38; }
                        PathLine { x: root2.width/2; y: root2.height*0.5; }
                        PathAttribute { name: "fontSize"; value: 54; }
                        PathLine { x: root2.width/2; y: root2.height; }
                        PathAttribute { name: "fontSize"; value: 38; }
                    }
                    pathItemCount: 3
                    maximumFlickVelocity: 0
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    clip: true
                    dragMargin: parent.width
                    onFlickStarted: {
                        check = 2
                    }
                    onDragEnded: {
                        positionViewAtIndex(currentIndex ,PathView.SnapPosition)
                    }
                    onCurrentIndexChanged: {
                        setMonth = currentIndex
                        oldDayIndex = root3.dayIndex
                        if((currentIndex + 1) == 4 || (currentIndex + 1) == 6||(currentIndex + 1) == 9||(currentIndex + 1) == 11){
                            currentMonthDays = 30
                        }
                        else if(currentIndex + 1 == 2){
                            if(isLeap)
                                currentMonthDays = 29
                            else
                                currentMonthDays = 28
                        }
                        else{
                            currentMonthDays = 31
                        }

                    }
                    Component.onCompleted: {
                        if((currentIndex + 1) == 4 || (currentIndex + 1) == 6||(currentIndex + 1) == 9||(currentIndex + 1) == 11){
                            currentMonthDays = 30
                        }
                        else if(currentIndex + 1 == 2){
                            if(isLeap)
                                currentMonthDays = 29
                            else
                                currentMonthDays = 28
                        }
                        else{
                            currentMonthDays = 31
                        }
                    }
                    Rectangle{
                        anchors.centerIn: month
                        width: 160
                        height: 110
                        opacity:check == 2? 1: 0.3
                        radius: 5
                        border.width: 3
                        border.color: check == 2? /*"#4ff8f4"*/bordColor:nomalColor
                        color: check == 2 ? /*"#184C57"*/rectColor:"transparent"
                    }
                }


                Component{
                    id: monthDelegate
                    Rectangle{
                        id: wrapper2
                        width: 160
                        height: 110
                        visible: PathView.onPath
                        color: "transparent"

                        NonAnimationText_FontRegular {
                            id: txt
                            anchors.centerIn: parent
                            text: index < 9 ? ("0" + (index + 1)) : (index + 1)
                            font.pixelSize: wrapper2.PathView.fontSize
                            color: (check == 2&&wrapper2.PathView.isCurrentItem)?/*"#4ff8f4"*/txtColor:"#ffffff"
                        }
                        IControls.MouseArea{
                            anchors.fill: parent
                            enabled: check == 2 ? false: true
                            onPressed:   {
                                check = 2
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: root3
                width: 160
                height: 300
                z: 1
                anchors.left: root2.right
                anchors.leftMargin: 64
                color: "transparent"
                property alias dayIndex: day.currentIndex

                PathView{
                    id: day
                    anchors.fill: parent
                    delegate: dayDelegate
                    model: currentMonthDays
                    currentIndex: currentDay - 1

                    path: Path{
                        startX: root3.width/2
                        startY: 0
                        PathAttribute { name: "fontSize"; value: 38; }
                        PathLine { x: root3.width/2; y: root3.height*0.5; }
                        PathAttribute { name: "fontSize"; value: 54; }
                        PathLine { x: root3.width/2; y: root3.height; }
                        PathAttribute { name: "fontSize"; value: 38; }
                    }
                    pathItemCount: 3
                    maximumFlickVelocity: 0
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    clip: true
                    dragMargin: parent.width
                    onFlickStarted: {
                        check = 3
                    }
                    onDragEnded: {
                        positionViewAtIndex(currentIndex ,PathView.SnapPosition)
                    }
                    onModelChanged: { //月份改变
                        //currentMonthDays      //当前月份的天数
                        //oldDayIndex      //调整前保存的天数
                        //currentIndex   //当前展示的天数
                        currentDayIndex = currentMonthDays  > oldDayIndex ? oldDayIndex : (currentMonthDays - 1);
                        positionViewAtIndex(currentDayIndex,PathView.Center);

                    }
                    onCurrentIndexChanged: {
                        setDay = currentIndex
                    }

                    Rectangle{
                        anchors.centerIn: day
                        width: 160
                        height: 110
                        opacity:check == 3? 1: 0.3
                        radius: 5
                        border.width: 3
                        border.color: check == 3 ? /*"#4ff8f4"*/bordColor:nomalColor
                        color: check == 3 ? /*"#184C57"*/rectColor:"transparent"
                    }

                    Component{
                        id: dayDelegate
                        Rectangle{
                            id: wrapper
                            width: 160
                            height: 110
                            visible: PathView.onPath
                            color: "transparent"

                            NonAnimationText_FontRegular {
                                id: txt
                                anchors.centerIn: parent
                                text: index < 9 ? ("0" + (index + 1)) : (index + 1)
                                font.pixelSize: wrapper.PathView.fontSize
                                color: (check == 3 && wrapper.PathView.isCurrentItem)?/*"#4ff8f4"*/txtColor:"#ffffff"
                            }
                            IControls.MouseArea{
                                anchors.fill: parent
                                enabled: check == 3 ? false: true
                                onPressed:   {
                                    check = 3
                                }
                            }
                        }
                    }
                }
            }

        }
    }

}
