import QtQuick.Controls 1.2
import QtQuick 2.5
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Controls' as UControls
Rectangle {
    id: seekControl
        width: 384
        height: 4
        color: "transparent"
        property int duration: 0
        property int playPosition: 0
        property int seekPosition: 0
        property bool enabled: true
        property bool seeking: false
        property bool music: false
         property bool show: true
        property alias slider: positionSlider

        UControls.Text {
            height: 19
            anchors { bottom: seekControl.top; bottomMargin: 14 }
            font.pixelSize: 36
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
            smooth: true
            text: formatTime(playPosition)
            visible: show
            renderType: Text.QtRendering
        }

        onPlayPositionChanged: {
            positionSlider.sync = true
            positionSlider.value = playPosition
            positionSlider.sync = false
        }

        UControls.Slider {
            id: positionSlider
            focusStepSize: music ? 5000 : 10000
            maximumValue: seekControl.duration
            property bool sync: false

            onValueChanged: {
                if (!sync)
                    seekControl.seekPosition = value
            }
        }

        function formatTime(timeInMs) {
            if (!timeInMs || timeInMs <= 0) {
                if (music) {
                    if (metaData.item.mediaSource) {
                        return "00:00"
                    } else {
                        return "--:--"
                    }
                } else {
                    if (metaData.item.mediaSource) {
                        return "00:00:00"
                    } else {
                        return "--:--:--"
                    }
                }
            }
            var hour, minute, second;
            var seconds = timeInMs / 1000;
            if (music) {
                minute = Math.floor(seconds / 60)
                second = Math.floor(seconds % 60)
            } else {
                hour = Math.floor(seconds / 3600)
                minute = Math.floor((seconds % 3600) / 60);
                second = Math.floor(seconds % 60);
            }
            if (second < 10) second = "0" + second;
            if (minute < 10) minute = "0" + minute;
            if (hour < 10) hour = "0" + hour;
            if (music) {
                return minute + ":" + second
            } else {
                return hour + ":" + minute + ":" + second
            }
        }
}
