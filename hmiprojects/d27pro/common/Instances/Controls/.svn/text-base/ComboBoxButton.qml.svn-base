import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/UI/Private' as UPrivate
import 'qrc:/UI/Controls' as UControls


UPrivate.Control {
    id: root

    property variant items

    property alias comboboxRecWidth: comboboxRec.width
    property alias comboboxRecHeight: comboboxRec.height

    property alias dropdownRecWid: dropdownRec.width
    property alias listViewHeight: listView.listHeight

    property alias selectedItem: bandbutton.btnName
    property alias selectedIndex: listView.currentIndex
    property alias comboboxRecState: comboboxRec.state

    property int themeColor: 0
    signal comboClicked;

    Rectangle {
        id: comboboxRec
        property variant items
        smooth: true
        signal comboClicked

        GradientButtonG {
            id:bandbutton
            anchors.fill: parent
            width: parent.width
            height: parent.height
            btnName: items[0]
            z: 1
            checked: true
            themeColor: root.themeColor
            exclusiveGroup: selected
            /*<Add Radio Requirement 2.3.2.4    chengzhi    2016/11/18      viviewer:       begin*/
            radioButtonDianImg: root.enabled ? "qrc:/resources/radio_ListIcon.png"
                                             : "qrc:/resources/radio_gray_ListIcon.png"
            radioButtonTxtColor: root.enabled ? ('#ffffff') : ('#313236')
            Image {
                anchors.bottom: parent.bottom
                source: themeColor == 0?"qrc:/resources/list_line_left 2.png":(themeColor == 1 ? "qrc:/resources/list_line_left-2.png":"qrc:/resources/list_line_left 2_g.png")
            }
            /*Add Radio Requirement 2.3.2.4    chengzhi    2016/11/18      viviewer:       end>*/
            onClicked: {
                comboboxRec.state = comboboxRec.state==="dropDown"?"":"dropDown"
                console.log("band button clicked")
//                console.log("items length = ",items.length)
//                console.log("drop down state =",comboboxRec.state)
//                console.log("drop down height = ",dropdownRec.height)
//                console.log("list view height = ",listView.height)
//                console.log("set list view height =", listViewHeight)
//                console.log("mode = ",listView.model)
            }
        }

        Rectangle {
            id:dropdownRec
            height:0
            clip:true
            anchors.top: bandbutton.top
            ExclusiveGroup{
                id: selected
            }
            ListView {
                id:listView
                property variant listHeight
                height: items.length*listViewHeight
                highlight: highlight
                model: items
                currentIndex: 0

                delegate: Item {
                    id: delegItem
                    height: listViewHeight
                    width: comboboxRecWidth
                    Image {
                        anchors.bottom: parent.bottom
                        source: "qrc:/resources/list_line_left 2.png"
                    }


                    GradientButtonG {
                        id: listButton
                        anchors.fill: parent
                        btnName: modelData
                        exclusiveGroup: selected
                        themeColor: root.themeColor
                        /*<Add Radio Requirement 2.3.2.4    chengzhi    2016/11/18      viviewer:       begin*/
                        radioButtonDianImg: root.enabled ? "qrc:/resources/radio_ListIcon.png"
                                                         : "qrc:/resources/radio_gray_ListIcon.png"
                        radioButtonTxtColor: root.enabled ? ('#ffffff') : ('#313236')
                        /*Add Radio Requirement 2.3.2.4    chengzhi    2016/11/18      viviewer:       end>*/
                        onClicked: {
                            if(modelData != "--"){
                                if(listView.currentIndex == index){
                                    comboboxRec.state = ""
                                }
                                else{
                                    listView.currentIndex = index;
                                }
                            }
                        }
                    }

                }
            }
        }

        states: State {
            name: "dropDown";
            PropertyChanges { target: dropdownRec; height: items.length*listViewHeight; z: 2}
        }

        Component {
            id: highlight
            Rectangle {
                width: dropdownRec.width;
                height: listViewHeight
                color: root.themeColor == 0 ?"#90105769":(root.themeColor == 1 ?"#90ff2200":"#90986142");
                z: 1
            }
        }

    }
}

