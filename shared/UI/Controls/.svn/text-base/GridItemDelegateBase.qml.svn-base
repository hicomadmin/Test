import QtQuick 2.0
import 'qrc:/UI/Controls' as Controls

Controls.BgImageButton {
    id: root
    checked: GridView.isCurrentItem
    width: GridView.view.width
    onClicked: {
        if (GridView.view) {
            GridView.view.currentIndex = index;
        }
    }
}
