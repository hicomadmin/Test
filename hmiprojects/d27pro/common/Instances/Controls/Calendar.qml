import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1

Rectangle {
    id:calendarRoot
    visible: true
    width: 1280
    height: 720

    Calendar{
        width: parent.width
        height: parent.height
        weekNumbersVisible: false
        style: CalendarStylePage{

        }
    }
  }

