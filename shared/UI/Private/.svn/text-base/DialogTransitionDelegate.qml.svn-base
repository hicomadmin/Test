import QtQuick 2.3

QtObject {
    id: root

    property Component open: DialogTransition {
        NumberAnimation {
            target: dialogItem
            property: "opacity"
            duration: 600
            from: 0
            to: 1
            easing.type: Easing.InOutCirc
        }
        NumberAnimation {
            target: mainItem
            property: "scale"
            duration: 600
            from: 2
            to: 1
            easing.type: Easing.InOutCirc
        }
    }
    property Component close: DialogTransition {
        NumberAnimation {
            target: dialogItem
            property: "opacity"
            duration: 600
            from: 1
            to: 0
            easing.type: Easing.InOutCirc
        }
        NumberAnimation {
            target: mainItem
            property: "scale"
            duration: 600
            from: 1
            to: 2
            easing.type: Easing.InOutCirc
        }
    }

    function getAnimation(shadowItem, mainItem, opts) {
//        var animation = opts.isOpen ? open : close;
//        return animation.createObject(opts.parent || root, {dialogItem: opts.parent, shadowItem: shadowItem, mainItem: mainItem});
        return null
    }
}
