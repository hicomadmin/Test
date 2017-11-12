import QtQuick 2.3

LabelButton {
    id: root
    checked: ListView.isCurrentItem
    width: ListView.view.width
    onClicked: {
        if (ListView.view) {
            ListView.view.currentIndex = index;
        }
    }
}
