import QtQuick 2.3
import Bluetooth 1.0
import 'qrc:/Instances/Core' as ICore

ICore.VirtualApplication {
    id: hfRoot
    property string phoneType
    property int firstCallSeconds: 0
    property string firstCallTime: '00:00'
    property int secondCallSeconds: 0
    property string firstNumber: ''
    property string secondNumber: ''
    property string currentNumber: ''
    property bool pagechanged: false
    property bool isThreeCalling: false

    pages: ({
                callpage: {url: Qt.resolvedUrl('CallPage.qml'),hideBackBtn: true,title: qsTr('电话')},
                incomecallpage: {url: Qt.resolvedUrl('IncomeCallPage.qml'),hideBackBtn: true,title: qsTr('电话')},
                threecalling: {url: Qt.resolvedUrl('ThreeCalling.qml'),hideBackBtn: true,title: qsTr('电话')},
                incallpage: {url: Qt.resolvedUrl('InCallPage.qml'),hideBackBtn: true, title: qsTr('电话')},
                realtimeKeyboard: {url: Qt.resolvedUrl('RealTimeKeyBoard.qml'),title: qsTr('电话')}
            })

    property BtCtl btctl: HSPluginsManager.get('btctl')

    function changeCallPage(page) {
        if (currentPage !== page) changePage(page)
    }

    function hangupCallPages() {
        if (btctl && btctl.telStatus === 7) {
            btctl.setKeyBoardValue("");
            btctl.telStatusChanged.disconnect(checkTelStatus)
            multiApplications.remove('hfcall')
        }
    }

    /* telStatus: 1：来电; 2：通话中; 3：去电; 4：第三方来电; 5：三方通话中; 6: 三方去电; 7: 通话结束 */
    function checkTelStatus() {
        if (!btctl) return
        switch (btctl.telStatus) {
        case 1:
        case 4:
            changeCallPage('incomecallpage')
            break
        case 2:
            changeCallPage('incallpage')
            break
        case 3:
        case 6:
            changeCallPage('callpage')
            break
        case 5:
            changeCallPage('threecalling')
            break
        default:
            hangupCallPages()
            break
        }
    }

    onItemReadyShow: {
        checkTelStatus();
        btctl.telStatusChanged.connect(checkTelStatus)
        currentNumber = Qt.binding(function (){return btctl.currentTalkInfo.number});
    }

    Timer {
        id: firstCallTimer
        interval: 1000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            firstCallSeconds ++;
            console.debug("[onTimerTriggered] first call time = ", firstCallSeconds);
            var hour, minute, second;
            hour = getInt(Math.floor(firstCallSeconds / 3600));
            minute = getInt(Math.floor((firstCallSeconds % 3600) / 60));
            second = getInt(Math.floor((firstCallSeconds % 3600) % 60));
            firstCallTime = hour + ":" + minute + ":" + second;
        }
    }

    function getInt (number) {
        if (number < 10)
            number = "0" + number;
        return number;
    }

    function startFirstTimer() {
        firstCallSeconds = 0;
        firstCallTimer.start();
    }

    function restartFirstTimer() {
        firstCallSeconds = secondCallSeconds;
        firstCallTimer.restart();
    }
}
