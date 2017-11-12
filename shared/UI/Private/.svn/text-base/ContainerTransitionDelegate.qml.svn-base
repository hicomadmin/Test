import QtQuick 2.3

QtObject {
    id: root

    property Component inFadeOutFade: ContainerTransition {
        PropertyAnimation {
            target: exitItem
            property: "opacity"
            from: 1
            to: 0
            easing.type: Easing.Linear
            duration: 400
        }

        PropertyAnimation {
            target: enterItem
            property: "opacity"
            from: 0
            to: 1
            easing.type: Easing.Linear
            duration: 400
        }
    }

    function getAnimation(inEl, outEl, opts) {
//        return inFadeOutFade.createObject(opts.parent || root, {enterItem: inEl.item, exitItem: outEl.item});
        return null
    }
}
