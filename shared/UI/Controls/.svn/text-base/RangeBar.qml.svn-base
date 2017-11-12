import QtQuick 2.3
import 'qrc:/UI/Private' as Private

Private.Control {
    id: root

    property real stepSize: 0.1
    property real maximumValue: 1.0
    property real minimumValue: 0.0
    property real value: minimumValue

    property alias reduceComponent: reduceLoader.sourceComponent
    property alias increaseComponent: increaseLoader.sourceComponent
    property alias dataAreaComponent: dataAreaLoader.sourceComponent

    readonly property int count: parseInt((maximumValue - minimumValue) / stepSize) + 1
    readonly property int valueIndex: parseInt((value - minimumValue) / stepSize)
    readonly property bool canReduce: valueIndex > 0
    readonly property bool canIncrease: valueIndex < count - 1

    function setValueIndex(index) {
        setValue(index * stepSize + minimumValue);
    }

    function setValue(v) {
        if (v <= maximumValue && v >= minimumValue) value = v;
    }

    function reduceStep() {
        setValue(value - stepSize);
    }

    function increaseStep() {
        setValue(value + stepSize);
    }

    function bindReduceItem() {
        var item = reduceLoader.item;
        if (item && item['clicked']) {
            item['clicked'].connect(reduceStep);
            item.disabled = Qt.binding(function () { return !root.canReduce; })
        }
    }

    function bindIncreaseItem() {
        var item = increaseLoader.item;
        if (item && item['clicked']) {
            item['clicked'].connect(increaseStep);
            item.disabled = Qt.binding(function () { return !root.canIncrease; })
        }
    }

    Loader {
        id: reduceLoader
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        onLoaded: root.bindReduceItem();
    }
    Loader {
        id: increaseLoader
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        onLoaded: root.bindIncreaseItem();
    }
    Loader {
        id: dataAreaLoader
        anchors.centerIn: parent
    }
}
