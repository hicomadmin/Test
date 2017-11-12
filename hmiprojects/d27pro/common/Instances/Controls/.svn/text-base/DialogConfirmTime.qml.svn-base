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

    property int currentHour
    property int currentMinutes

    property int setHour
    property int setMinutes
    property bool isAM

    property color txtColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#fbcaac":"#ffe0c2")
    property color rectColor: themeColor == 0 ? "#184C57":(themeColor == 1?"#F7624B":"#ad7946")
    property color bordColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#fbcaac":"#ffe0c2")
    property color nomalColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#852516":"#BF690D")

    signal confirmed_info(var info);
    signal canceled_info(var info);

    onConfirmed: confirmed_info([setHour + 1, setMinutes, isAM]);
    onCanceled: canceled_info([setHour, setMinutes, isAM]);


    infoComponent: datacom;
    Component{
        id:datacom;
        Item {
            width: 742
            height: 475
            property int check: 1
            Rectangle {
                id: hourArea
                width: 160
                height: 300
                anchors.left: parent.left
                anchors.leftMargin: 66
                z: 1
                color: "transparent"
                PathView{
                    id: hour
                    anchors.fill: parent
                    delegate: hourDelegate
                    model: 12
                    currentIndex: currentHour - 1

                    path: Path{
                        startX: hourArea.width/2
                        startY: 0
                        PathAttribute { name: "fontSize"; value: 38; }
                        PathLine { x: hourArea.width/2; y: hourArea.height*0.5; }
                        PathAttribute { name: "fontSize"; value: 54; }
                        PathLine { x: hourArea.width/2; y: hourArea.height; }
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
                        setHour = currentIndex
                    }
                    Component.onCompleted: {
                        setHour = currentIndex
                    }

                    Rectangle{
                        anchors.centerIn: hour
                        width: 160
                        height: 110
                        opacity:check == 1? 1 : 0.3
                        radius: 5
                        border.width: 3
                        border.color: check == 1? bordColor:nomalColor
                        color: check == 1 ? rectColor:"transparent"
                    }

                }

                Component{
                    id: hourDelegate
                    Rectangle{
                        id: wrapper2
                        width: 160
                        height: 110
                        visible: PathView.onPath
                        color: "transparent"

                        NonAnimationText_FontRegular {
                            id: txt
                            anchors.centerIn: parent
                            text: index < 9 ? ("0" + (index + 1)) : index + 1
                            font.pixelSize: wrapper2.PathView.fontSize
                            color: (check == 1&&wrapper2.PathView.isCurrentItem)?txtColor:"#ffffff"
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
            NonAnimationText_FontRegular {
                id: point
                z: 2
                text: qsTr(":")
                font.pixelSize: 70
                anchors.left: hourArea.right
                anchors.leftMargin: 15
                anchors.top: parent.top
                anchors.topMargin: 100
                color: "#ffffff"
            }
            Rectangle {
                id: minuteArea
                width: 160
                height: 300
                z: 1
                anchors.left: hourArea.right
                anchors.leftMargin: 64
                color: "transparent"
                PathView{
                    id: minute
                    anchors.fill: parent
                    delegate: minuteDelegate
                    model: 60
                    currentIndex: currentMinutes

                    path: Path{
                        startX: minuteArea.width/2
                        startY: 0
                        PathAttribute { name: "fontSize"; value: 38; }
                        PathLine { x: minuteArea.width/2; y: minuteArea.height*0.5; }
                        PathAttribute { name: "fontSize"; value: 54; }
                        PathLine { x: minuteArea.width/2; y: minuteArea.height; }
                        PathAttribute { name: "fontSize"; value: 38; }
                    }
                    pathItemCount: 3
                    maximumFlickVelocity: 0
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5
                    dragMargin: parent.width
                    clip: true
                    onFlickStarted: {
                        check = 2
                    }
                    onDragEnded: {
                        positionViewAtIndex(currentIndex ,PathView.SnapPosition)
                    }
                    onCurrentIndexChanged: {
                        setMinutes = currentIndex
                    }
                    Component.onCompleted: {
                        setMinutes = currentIndex
                    }

                    Rectangle{
                        anchors.centerIn: minute
                        width: 160
                        height: 110
                        opacity:check == 2?  1 : 0.3
                        radius: 5
                        border.width: 3
                        border.color: check == 2? bordColor:nomalColor
                        color: check == 2 ? rectColor:"transparent"
                    }

                    Component{
                        id: minuteDelegate
                        Rectangle{
                            id: wrapper2
                            width: 160
                            height: 110
                            visible: PathView.onPath
                            color: "transparent"

                            NonAnimationText_FontRegular {
                                id: txt
                                anchors.centerIn: parent
                                text: index < 10 ? ("0" + index) : index
                                font.pixelSize: wrapper2.PathView.fontSize
                                color: (check == 2&&wrapper2.PathView.isCurrentItem)?txtColor:"#ffffff"
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
            }
                Rectangle {
                    id: amPmArea
                    width: 160
                    height: 300
                    z: 1
                    anchors.left: minuteArea.right
                    anchors.leftMargin: 64
                    color: "transparent"
                    ListView{
                        id: amPm
                        width: 160
                        height: 300
                        delegate: amPmDelegate
                        model: [" ","AM","PM"," "]
                        clip: true
                        currentIndex: isAM ? 1 : 2
//                        boundsBehavior: Flickable.StopAtBounds
                        snapMode: ListView.SnapToItem
                        highlightFollowsCurrentItem: false
                        Rectangle{
                            anchors.centerIn: amPm
                            width: 160
                            height: 110
                            opacity:0.3
                            radius: 5
                            border.width: 3
                            border.color: check == 3 ? bordColor:nomalColor
                            color: check == 3 ? rectColor:"transparent"
                        }
                        /* BEGIN by Xiong wei, 2016.12.20
                         * Adjust the Confirm Time speed
                        */
                        Rectangle{
                            anchors.centerIn: amPm
                            width: 160
                            height: 110
                            visible:check == 3 ? true : false
                            radius: 5
                            border.width: 3
                            border.color: bordColor
                            color: "#00000000"
                        }
                        //End by xiongwei 2016.12.20
                        onCurrentIndexChanged: {
                            isAM = (currentIndex == 1)?true:false
                        }

                        onContentYChanged: {
                            if(check == 3){
                                if(contentY > 50){
                                    currentIndex = 2
                                }
                                else{
                                    currentIndex = 1
                                }
                            }
                        }
                        Component.onCompleted: {
                            isAM = (currentIndex == 1)?true:false
                            positionViewAtIndex(currentIndex,ListView.Center)
                        }

                        Component{
                            id:amPmDelegate
                            Rectangle{
                                id: wrapper
                                width: 160
                                height: 100
                                color: "transparent"

                                NonAnimationText_FontRegular {
                                    id: txt
                                    anchors.centerIn: parent
                                    text: modelData
                                    font.pixelSize: wrapper.ListView.isCurrentItem? 54:38
                                    color: (check == 3 && wrapper.ListView.isCurrentItem)?txtColor:"#ffffff"
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

