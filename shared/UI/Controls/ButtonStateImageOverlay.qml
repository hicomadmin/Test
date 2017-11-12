import QtQuick 2.0

Rectangle{
    id: root
//        width:251
//        height:309
    anchors.fill: parent

//    property bool rectVisible:true
//    property string rectColor
//    property double rectOpacity

    state: parent.state
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: root
                color:normalColor
                opacity:normalOpacity
//                rectVisible:normalVisible
            }
        },
        State {
            name: "pressing"
            PropertyChanges {
                target: root
                color:pressingColor
                opacity:pressingOpacity
//                rectVisible:pressingVisible

            }
        },
        State {
            name: "checkedNormal"
            PropertyChanges {
                target: root
                color:checkedNormalColor
                opacity:checkedNormalOpacity
//                rectVisible:checkedNormalVisible
            }
        },
        State {
            name: "checkedPressing"
            PropertyChanges {
                target: root
                color:checkedPressingColor
                opacity:checkedPressingOpacity
//                rectVisible:checkedPressingVisible
            }
        },
        State {
            name: "disabled"
            PropertyChanges {
                target: root
                color:disabledColor
                opacity:disabledOpacity
//                rectVisible:disabledVisible
            }
        },
        State {
            name: "focusing"
            PropertyChanges {
                target: root
                color:disabledColor
                opacity:disabledOpacity
//                rectVisible:focusingVisible
            }
        }
    ]


    property string normalColor
    property string pressingColor
    property string checkedNormalColor: normalColor
    property string checkedPressingColor: normalColor
    property string disabledColor
    property string focusingColor: normalColor

    property double normalOpacity
    property double pressingOpacity
    property double checkedNormalOpacity: normalOpacity
    property double checkedPressingOpacity: normalOpacity
    property double disabledOpacity
    property double focusingOpacity: normalOpacity



}


