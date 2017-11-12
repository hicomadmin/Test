import QtQuick 2.0
import 'qrc:/UI/Controls' as Controls

Controls.ColorButton {
    id: root
    checked: ListView.isCurrentItem
    width: ListView.view.width
    onClicked: {
        if (ListView.view) {
            ListView.view.currentIndex = index;
        }
    }
}

