import QtQuick 2.3
import 'qrc:/UI/Private' as Private

QtObject {
    id: root

//    property Component inMoveUp: Private.ContainerTransition {
//        PropertyAnimation {
//            target: exitItem
//            property: "opacity"
//            from: 1
//            to: 0
//            easing.type: Easing.InOutCirc
//            duration: 600
//        }
//        PropertyAnimation {
//            target: enterItem
//            property: "y"
//            from: enterItem && enterItem.height
//            to: 0
//            easing.type: Easing.InOutCirc
//            duration: 600
//        }
//    }

//    property Component outMoveDown: Private.ContainerTransition {
//        PropertyAnimation {
//            target: enterItem
//            property: "opacity"
//            from: 0
//            to: 1
//            easing.type: Easing.InOutCirc
//            duration: 600
//        }
//        PropertyAnimation {
//            target: exitItem
//            property: "y"
//            from: 0
//            to: exitItem && exitItem.height
//            easing.type: Easing.InOutCirc
//            duration: 600
//        }
//    }

//    property Component inFadeOutFade: Private.ContainerTransition {
//        PropertyAnimation {
//            target: exitItem
//            property: "opacity"
//            from: 1
//            to: 0
//            easing.type: Easing.Linear
//            duration: 400
//        }

//        PropertyAnimation {
//            target: enterItem
//            property: "opacity"
//            from: 0
//            to: 1
//            easing.type: Easing.Linear
//            duration: 400
//        }
//    }

    function getAnimation(inEl, outEl, opts) {
//        var com;

//        if (inEl.id === 'home') {
//            com = outMoveDown
//        } else if (outEl.id === 'home') {
//            com = inMoveUp;
//        } else {
//            // TODO
//            com = inFadeOutFade;
//        }

//        return com.createObject(opts.parent || root, {enterItem: inEl.item, exitItem: outEl.item});
        return null
    }
}
