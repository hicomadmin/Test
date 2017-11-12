import QtQuick 2.3
import 'qrc:/UI/Private' as Private

Private.Control {

    id: root
    anchors.centerIn: parent
    width: parent.width
    height: parent.height
    visible: false
    z: 999

    property bool animating: false
    property bool autoOpen: true
    property bool destroyWhenClosed: true
    property bool clickClose:false
    property bool mousePenetration: false
    property alias  dialog_z:root.z
    property alias dialog_width:root.width
    property alias dialog_height:root.height

    property QtObject transitionDelegate: Private.DialogTransitionDelegate {}

    property alias contentWidth: mainMouseArea.width
    property alias contentHeight: mainMouseArea.height
    property alias shadowArea: shadowMouseArea
    property alias mainArea: mainMouseArea
    property alias shadowComponent: shadowLoader.sourceComponent
    property alias bgComponent: bgLoader.sourceComponent
    property alias contentComponent: contentLoader.sourceComponent

    signal animationError(var err);
    signal readyOpen
    signal opening
    signal opened
    signal readyClose
    signal closing
    signal closed

    onReadyOpen: { visible = true; }
    onClosed: { visible = false; }

    function open() {
        if (animating) return console.warn('Dialog is animating.');
        animating = true;
        readyOpen();
        var animation = transitionDelegate.getAnimation(shadowMouseArea, mainMouseArea, {parent: root, isOpen: true});

        if (animation) {
            opening();
            animation.stopped.connect(function () {
                animating = false;
                opened();
                if (animation) animation.destroy();
            });
            animation.start();
        } else {
            animationError('Invalid animation');
            opening();
            animating = false;
            opened();
        }
    }

    function close() {
//        if (animating) return console.warn('Dialog is animating.');
        animating = true;
        readyClose();
        var animation = transitionDelegate.getAnimation(shadowMouseArea, mainMouseArea, {parent: root, isOpen: false});

        if (animation) {
            closing();
            animation.stopped.connect(function () {
                animating = false;
                closed();
                if (animation) animation.destroy();
                if (destroyWhenClosed) root.destroy();
            });
            animation.start();
        } else {
            animationError('Invalid animation');
            closing();
            animating = false;
            closed();
            if (destroyWhenClosed) root.destroy();
        }
    }

    MouseArea {
        id: shadowMouseArea
        anchors.fill: parent
        propagateComposedEvents: mousePenetration
        Loader {
            id: shadowLoader
            anchors.fill: parent
        }

        onPressed: {
            if(mousePenetration) {
                root.close();
                mouse.accepted = false;
            }
        }

        onClicked: {
            if(clickClose) {
                root.close();
            }
        }
    }
    MouseArea {
        id: mainMouseArea
        anchors.centerIn: parent
        Loader {
            id: bgLoader
            anchors.fill: parent
        }
        Loader {
            id: contentLoader
            anchors.fill: parent
        }
    }
}
