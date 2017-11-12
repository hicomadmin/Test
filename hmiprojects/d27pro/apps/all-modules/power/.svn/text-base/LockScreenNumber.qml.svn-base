import QtQuick 2.0
import QtQuick.Controls 1.2
import TheXSettings 1.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore

ICore.Page {
    id: root
//    property real hours
//    property real minutes
//    property real seconds
//    property string showHour
//    property string showMinute
//    property string showAM

    property SystemCtl system: HSPluginsManager.get('system')
    /* BEGIN by Xiong wei, 2016.12.14
     * Adjust the format of the digital clock Screen saver in English mode
    */
    property bool timeformt: system.hours24state
    property real language: system.language
    // End by xiongwei 2016.12.14

//    Connections {
//        target: system

//        onHours24stateChanged: {
//            timeformt = hours24state
//        }
//        Component.onCompleted: {
//            timeformt = hours24state
//        }
//    }

    IControls.NonAnimationText_FontRegular{
        id: timeNum
        anchors.centerIn: parent
        font.pixelSize: 100
        color: "#ffffff"
        text: currentDateTime()
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeNum.text = currentDateTime()
    }

    function currentDateTime(){
        /* BEGIN by Xiong wei, 2016.12.14
         * Adjust the format of the digital clock Screen saver in English mode
        */
        var nowTime = Qt.formatDateTime(new Date(), "hh:mm")
        if(timeformt){
             return nowTime;
        } else {
             var showTime = Qt.formatDateTime(new Date(), "hh:mm AP")
             if(nowTime.substring(0,2) >= 12) {
                 return showTime.substring(0,5) + "PM"
             } else {
                 return showTime.substring(0,5) + "AM"
             }

        }
        //End by xiongwei 2016.12.14
    }
//    function timeChanged() {
//        var date = new Date;
//        hours = date.getHours()
//        minutes = date.getMinutes()
//        seconds = date.getUTCSeconds();
//    }
}

