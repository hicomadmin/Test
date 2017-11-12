import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1

Rectangle {
    id:calendarRoot
    visible: true
    width: 346
    height: 720
    color: "#00000000"
    property alias selectedDay: calendar.selectedDate

    Calendar{
        id: calendar
        width: 346
        height: 628
        anchors.right: parent.right
        anchors.top: parent.top
        weekNumbersVisible: false
        style: MiniCalendarStylePage{

        }
    }
  }

