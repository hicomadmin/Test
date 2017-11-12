import QtQuick 2.0
import QtQuick.Controls 1.2
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import TheXSettings 1.0

ICore.Page {
    id: root
    property SystemCtl system
    property bool hours24state


    onSystemChanged: {
        hours24state = Qt.binding(function (){return system.hours24state});
    }

    IControls.NonAnimationText_FontRegular{
        id: timeNum
        anchors.centerIn: parent
        font.pixelSize: 100
        color: "#ffffff"
    }

    IControls.NonAnimationText_FontRegular{
        id: dateNum
        anchors.bottom: timeNum.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 100
        color: "#ffffff"
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            dateNum.text = Qt.formatDateTime(new Date(), "yyyy.MM.dd dddd")
            if(hours24state)
                timeNum.text = Qt.formatDateTime(new Date(), "hh:mm")
            else
                timeNum.text = Qt.formatDateTime(new Date(), "hh:mm ap")
        }
    }

}

