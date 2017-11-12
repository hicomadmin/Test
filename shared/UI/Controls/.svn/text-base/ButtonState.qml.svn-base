import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Controls' as Controls

Private.Control {
    id: root
    property bool pressing: false
    property bool disabled: false
    property bool checked: false


    property ExclusiveGroup exclusiveGroup

    signal clicked
    signal doubleClicked
    signal longPressed
    signal pressed
    signal released
    signal canceled
    signal checked

    onExclusiveGroupChanged: exclusiveGroup && exclusiveGroup.bindCheckable(root)

    Binding {
        target: root
        property: 'state'
        value: pressing ?
                   (checked ? 'checkedPressing' : 'pressing')
                 : (activeFocus ? 'focusing' : (disabled ? 'disabled' : (checked ? "checkedNormal" : "normal")))


//            activeFocus
//                ? 'focusing'
//                : disabled
//                   ? 'disabled'
//                   : checked
//                       ? (pressing ? 'checkedPressing' : 'checkedNormal')
//                       : (pressing ?  'pressing' : 'normal')
    }
    Connections {
            target: mouseArea
            onClicked:
            {
                checked = true;
                clicked()
            }
            onDoubleClicked: doubleClicked()
            onPressAndHold:
            {
                checked = true;
                longPressed()
            }
            onPressed: {
                pressing = true;
                checked = false;
                pressed();
            }
            onReleased: {
                pressing = false;
                released();
            }
            onCanceled: {
                pressing = false;
                canceled();
            }
        }
    Controls.MouseArea {
        id: mouseArea
        enabled: !root.disabled
        anchors.fill: parent
    }
}
