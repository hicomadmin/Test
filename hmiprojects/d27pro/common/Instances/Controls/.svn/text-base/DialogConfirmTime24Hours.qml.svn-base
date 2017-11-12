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

    property color txtColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#fbcaac":"#ffe0c2")
    property color rectColor: themeColor == 0 ? "#184C57":(themeColor == 1?"#F7624B":"#ad7946")
    property color bordColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#fbcaac":"#ffe0c2")
    property color nomalColor: themeColor == 0 ? "#4ff8f4":(themeColor == 1?"#852516":"#BF690D")


    signal confirmed_info(var info);
    signal canceled_info(var info);

    onConfirmed: confirmed_info([setHour, setMinutes]);
    onCanceled: canceled_info([setHour, setMinutes]);


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
                anchors.leftMargin: 176
                z: 1
                color: "transparent"
                PathView{
                    id: hour
                    anchors.fill: parent
                    delegate: hourDelegate
                    model: 24
                    currentIndex: currentHour

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
                    /* BEGIN by Xiong wei, 2016.12.20
                     * Adjust the Confirm Time speed
                    */
                    //maximumFlickVelocity: Math.abs(beginY - endY) >15 ? 1200 : 0
                    maximumFlickVelocity: 0
                   // flickDeceleration: 300
                    //End by xiongwei 2016.12.20
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
                        opacity:check == 1? 1: 0.3
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
                            text: index < 10 ? ("0" + index) : index
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
                    /* BEGIN by Xiong wei, 2016.12.20
                     * Adjust the Confirm Time speed
                    */
                    maximumFlickVelocity:0
                    //flickDeceleration: 200
                    //End by xiongwei 2016.12.20
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
                        setMinutes = currentIndex
                    }
                    Component.onCompleted: {
                        setMinutes = currentIndex
                    }
                    Rectangle{
                        anchors.centerIn: minute
                        width: 160
                        height: 110
                        opacity:check == 2? 1: 0.3
                        radius: 5
                        border.width: 3
                        border.color: check == 2 ? bordColor:nomalColor
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
//                                enabled: check == 2 ? false: true
                                onPressed:   {
                                    check = 2
                                }

                            }
                        }
                    }
                }
            }
        }
    }
}

