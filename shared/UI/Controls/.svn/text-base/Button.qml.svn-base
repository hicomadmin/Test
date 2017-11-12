import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Controls' as Controls

Private.Control {
    id: root
    property bool pressing: false
    property bool disabled: false
    property bool checked: false
    /* BEGIN by Xiong wei, 2016.12.27
     *  Add longpress states
    */
    property bool longHoldPressed: false
    // End by xiongwei 2016.12.27

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
                 : (activeFocus ? 'focusing' : (disabled ? 'disabled' : (checked ? "checkedNormal" : (longHoldPressed ? "longPressing" : "normal"))))


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
            onClicked: clicked()
            onDoubleClicked: doubleClicked()
            onPressAndHold: longPressed()
            onPressed: {
                pressing = true;
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
