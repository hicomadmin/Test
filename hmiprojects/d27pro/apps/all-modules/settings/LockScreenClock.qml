import QtQuick 2.0
import QtQuick.Controls 1.2
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore

ICore.Page {

    Rectangle {
        id: root
        anchors.fill: parent
        color: "transparent"
        property real hours
        property real minutes
        property real seconds

        Image {
            id: bg
            anchors.centerIn: parent
            source: "qrc:/resources-settings/clock_BJ_02.png"
            Image {
                id: hour
                anchors.centerIn: parent
                rotation: 270
                source: "qrc:/resources-settings/colck__icon_shizhen_02.png"
                transform: Rotation {
                    id: hourRotation
                    origin.x: hour.width/2
                    origin.y: hour.height/2
                    axis.z:  1
                    angle: (hours * 30) + (minutes * 0.5)
                    Behavior on angle {
                        SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                    }
                }
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
                rotation: 270
                source: "qrc:/resources-settings/colck__icon_fenzhen_01.png"
                transform: Rotation {
                    id: minuteRotation
                    origin.x: minute.width/2
                    origin.y: minute.height/2
                    axis.z:  1
                    angle: minutes * 6
                    Behavior on angle {
                        SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                    }
                }
            }
            Image {
                id: yuan
                anchors.centerIn: parent
                source: "qrc:/resources-settings/colck__icon_yuandian_01.png"
            }
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: root.timeChanged()
            }
        }
        function timeChanged() {
            var date = new Date;
            hours = date.getHours()
            minutes = date.getMinutes()
            seconds = date.getUTCSeconds();
        }
    }
}
