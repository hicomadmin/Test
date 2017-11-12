import QtQuick 2.3

QtObject {
    id: root

    property FocusScope currentScope
    // 定义默认7种常用键的值
    readonly property int keyPageUp: Qt.Key_PageUp
    readonly property int keyPageDown: Qt.Key_PageDown
    readonly property int keyDirectionUp: Qt.Key_Up
    readonly property int keyDirectionDown: Qt.Key_Down
    readonly property int keyDirectionLeft: Qt.Key_Left
    readonly property int keyDirectionRight: Qt.Key_Right
    readonly property int keyEnter: Qt.Key_Return

    readonly property int longPressMilliSeconds: 800
    property bool useKeyEventEmitter: true
    // 自定义事件接收器：如 { clicked: {k_102:  xxx方法} }
    property var customKeyEventReceiver: null

    property Timer keyEventTimer: Timer {
        interval: longPressMilliSeconds
        repeat: false
        triggeredOnStart: false
        onTriggered: if (keycode) keyLongPressed(keycode);

        property int keycode: -1
    }

    signal keysOnPressed(var event)
    signal keysOnReleased(var event)

    signal pressedEventEmitter(var event)
    signal releasedEventEmitter(var event)

    signal beforeProcessingKeyPressed(int keycode)
    signal keyPressed(int keycode)
    signal afterProcessingKeyPressed(int keycode)

    signal beforeProcessingKeyReleased(int keycode)
    signal keyReleased(int keycode)
    signal afterProcessingKeyReleased(int keycode)

    signal beforeProcessingKeyClicked(int keycode)
    signal keyClicked(int keycode)
    signal afterProcessingKeyClicked(int keycode)

    signal beforeProcessingKeyLongPressed(int keycode)
    signal keyLongPressed(int keycode)
    signal afterProcessingKeyLongPressed(int keycode)

    signal pageUpDownEvent(string direction, string type)
    signal fourDirectionEvent(string direction, string type)
    signal enterEvent(string type)
    signal otherEvent(int code, string type)

    Component.onCompleted: {
        currentScope.Keys.pressed.connect(keysOnPressed);
        currentScope.Keys.released.connect(keysOnReleased);
    }

    onKeysOnPressed: if (useKeyEventEmitter) pressedEventEmitter(event);
    onKeysOnReleased: if (useKeyEventEmitter) releasedEventEmitter(event);
    onPressedEventEmitter: {
        if (event.isAutoRepeat) return;
        event.accepted = true;
        keyPressed(event.key);
    }
    onReleasedEventEmitter: {
        if (event.isAutoRepeat) return;
        keyReleased(event.key);
    }
    onKeyPressed: {
        beforeProcessingKeyPressed(keycode);

        keyEventTimer.keycode = keycode;
        keyEventTimer.restart();

        _confirmKeyEventReceiver('pressed', keycode);

        afterProcessingKeyPressed(keycode);
    }
    onKeyReleased: {
        beforeProcessingKeyPressed(keycode);

        _confirmKeyEventReceiver('released', keycode);

        if (keyEventTimer.running) {
            // clicked
            keyEventTimer.stop();
            keyClicked(keycode);
        }
        afterProcessingKeyPressed(keycode);
    }
    onKeyClicked: {
        beforeProcessingKeyClicked(keycode);
        _confirmKeyEventReceiver('clicked', keycode);
        afterProcessingKeyClicked(keycode);
    }
    onKeyLongPressed: {
        beforeProcessingKeyLongPressed(keycode);
        _confirmKeyEventReceiver('longPressed', keycode);
        afterProcessingKeyLongPressed(keycode);
    }

    /*
    * 确认Key事件接收器，检查是否有自定义的事件接收器
    * type包括pressed, released, clicked, longPressed
    */
    function _confirmKeyEventReceiver(type, keycode) {
        if (customKeyEventReceiver
                && customKeyEventReceiver[type]
                && customKeyEventReceiver[type]['k_' + keycode]) {
            // 执行自定义事件接收器
            (customKeyEventReceiver[type]['k_' + keycode])(type, keycode);
        } else {
            // 使用默认事件接收器
            _useDefaultKeyEventReceiver(type, keycode);
        }
    }

    /* 定义默认的Key事件接收器 */
    function _useDefaultKeyEventReceiver(type, keycode) {
        switch (keycode) {
            case keyPageUp:
                pageUpDownEvent('up', type);
                break;
            case keyPageDown:
                pageUpDownEvent('down', type);
                break;
            case keyDirectionUp:
                fourDirectionEvent('up', type);
                break;
            case keyDirectionDown:
                fourDirectionEvent('down', type);
                break;
            case keyDirectionLeft:
                fourDirectionEvent('left', type);
                break;
            case keyDirectionRight:
                fourDirectionEvent('right', type);
                break;
            case keyEnter:
                enterEvent(type);
                break;
            default:
                otherEvent(keycode, type);
                break;
        }
    }
}
