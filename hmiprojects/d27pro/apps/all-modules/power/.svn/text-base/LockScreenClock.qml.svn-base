import QtQuick 2.0
import QtQuick.Controls 1.2
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore

ICore.Page {
    id:proot;
    property real hours
    property real minutes
    property real seconds

    onItemShowing: {
        timeChanged();
    }

    Rectangle {
        id: root
        anchors.fill: parent
        color: "transparent"
        Image {
            id: bg
            anchors.centerIn: parent
            source: "qrc:/resource-power/clock_BJ_02.png"
            Image {
                id: hour
                anchors.centerIn: parent
                rotation: 270 + (hours * 30) + (minutes * 0.5)
                source: "qrc:/resource-power/colck__icon_shizhen_02.png"
                IControls.MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log(mouseX,mouseY)
                    }
                }
            }
            Image {
                id: minute
                anchors.centerIn: parent
                rotation: 270 + minutes * 6
                source: "qrc:/resource-power/colck__icon_fenzhen_01.png"
            }
            Image {
                id: yuan
                anchors.centerIn: parent
                source: "qrc:/resource-power/colck__icon_yuandian_01.png"
            }
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: proot.timeChanged()
            }
        }
    }
    function timeChanged() {
        var date = new Date;
        hours = date.getHours()
        minutes = date.getMinutes()
        seconds = date.getUTCSeconds();
    }
}
