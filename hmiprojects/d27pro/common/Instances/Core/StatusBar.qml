import 'qrc:/UI/Private' as Private
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/Core' as UCore
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import QtQuick 2.3

Private.Control {
    id: root

    width: parent.width
    height: 92

    property bool timeFormt: false
    property int  themeColor: 0
    property real carTemperature: 0.0
    property bool hideBackBtn: false

    property url btUrl: isBtConnected ? 'qrc:/resources/home_Icon_BT_ON_03.png' :
                                        'qrc:/resources/home_Icon_BT_OFF.png'
    property url wifiUrl: 'qrc:/resources/home_Icon_wifi.png'
    property url muteUrl: 'qrc:/resources/home_Icon_SY.png'

    property string title
    property alias isBtOn: btloader.visible
    property bool isBtConnected: false
    property alias isWifiOn: wifiloader.visible
    property alias isMute: muteloader.visible

    signal back

    onCarTemperatureChanged: {
        console.debug('onCarTemperatureChanged:', carTemperature)
        tempeLab.text = ""
        if ((carTemperature > 256) && (carTemperature < 287)) {
            tempeLab.text = "-"
            tempeLab.text += ((carTemperature % 256).toString() + "℃")
        }
        else if (carTemperature === 255){
            tempeLab.text = '-- ' + "℃";
        }
        else if (carTemperature < 86){
            tempeLab.text += ((carTemperature % 256).toString() + "℃")
        }
    }

    /* BEGIN by Zhao Xing, 2016.12.14
     * update time when format changed.
    */
    onTimeFormtChanged: updateTimeLable()
    /* END - by Zhao Xing, 2016.12.14 */

    /* BEGIN by Zhang Yi, 2016.12.02
     * Add this for language switching logic.
    */
    function setTitle(tit) {
        title = tit
        updateTitle(tit)
    }

    function updateTitle(tit) {
        tit = ctranslator.trans("Application", tit)
        titleLabel.text = (tit === "") ? qsTr(title) : tit
    }

    Connections {
        target: ctranslator
        onMonitorStateChanged: updateTitle(title)
    }
    /* END - by Zhang Yi, 2016.12.02 */

//    function updateTimeText() {
//        timeLabel.text = currentDateTime()
//    }
    /* BEGIN by Li Peng, 2016.11.24
     * update time.
    */
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: updateTimeLable()
    }
    /* END by Li Peng, 2016.11.24.
    */

    function updateTimeLable() {
        timeLabel.text = currentDateTime()
    }

    /* Begin by Zhou Yongwu, 2016.11.29
     * Modify the time for 12 hours format
     */
    function currentDateTime(){
        var wholeTime = Qt.formatDateTime(new Date(), "hh:mm")
        if (timeFormt) {
            return wholeTime
        } else {
            if (wholeTime.substring(0,2) > 12) {
                return (wholeTime.substring(0,2) - 12) + wholeTime.substring(2, 5) + " PM"
            } else if (wholeTime.substring(0,2) == 12) {
                return wholeTime + "PM"
            } else if (wholeTime.substring(0,2) == 00){
                return 12 + wholeTime.substring(2, 5) + " AM"
            } else {
                return wholeTime + " AM"
            }
        }
    }
    /* End by Zhou Yongwu, 2016.11.29
     */


    Rectangle {
        anchors.fill: parent;
        color: "#000000";

        UControls.GradientButton {
            id: backBtn;
            width: 120;
            height: parent.height;
            contentcompent: Component{
                Image {
                    source: 'qrc:/resources/home_Btn_return_nml.png';
                }
            }
            normalGradient: Gradient {
                GradientStop { position: 0.0; color: "#22252A" }
                GradientStop { position: 1.0; color: '#000002'}
            }
            normalGradientDirection: ({start:Qt.point(0,0),end:Qt.point(0,height)});
            pressingGradient: Gradient {
                GradientStop { position: 0.0; color: themeColor == 0 ? "#105769" : (themeColor == 1 ? "#9B1702" : "#986142" ) }
                GradientStop { position: 1.0; color: themeColor == 0 ? "#105769" : (themeColor == 1 ? "#9B1702" : "#986142" ) }
            }
            pressingGradientDirection: ({start:Qt.point(0,0),end:Qt.point(width,0)});
            visible: !hideBackBtn
            onClicked: back();
        }
        IControls.NonAnimationText_FontRegular {
            id: titleLabel
            anchors{
                left: backBtn.right;
                leftMargin: 36;
                verticalCenter: parent.verticalCenter;
            }
            font.pixelSize: 38
            color: '#FFFFFF'
        }
        //Time show:
        IControls.NonAnimationText_FontRegular {
            id:timeLabel
            anchors.centerIn: parent;
            font.pixelSize: 44
            color:'#FFFFFF';
//            text: currentDateTime();
    //        text:(clock < 10)?('0'+clock):clock +':'+ (minutes < 10)?('0'+minutes):minutes
        }

        Flow {
            id: statesFlow;
            anchors {
                right: parent.right;
                rightMargin: 120;
                verticalCenter: parent.verticalCenter;
            }
            spacing: 20;
            layoutDirection: Qt.RightToLeft;

            Loader {
                id: btloader
                visible: false
                active: btloader.visible
                width: 37
                height: 21
                sourceComponent: btState
            }

            Loader {
                id: wifiloader
                visible: false
                active: wifiloader.visible
                width: 37
                height: 21
                sourceComponent: wifiState
            }

            Loader {
                id: muteloader
                visible: false
                active: muteloader.visible
                width: 37
                height: 21
                sourceComponent: muteState
            }
        }

        Component {
            id: btState
            Rectangle {
                width: 37
                height: 21
                color: "#00000000"
                Image {
                    id: btStatusImage
                    source: btUrl
                    anchors.centerIn: parent
                }
            }
        }

        Component {
            id: wifiState
            Rectangle {
                width: 37
                height: 21
                color: "#00000000"
                Image {
                    id: wifiStatusImage
                    source: wifiUrl
                    anchors.centerIn: parent
                }
            }
        }

        Component {
            id: muteState
            Rectangle {
                width: 37
                height: 21
                color: "#00000000"
                Image {
                    id: muteStatusImage
                    source: muteUrl
                    anchors.centerIn: parent
                }
            }
        }

        IControls.NonAnimationText_FontRegular{
            id: tempeLab;
            anchors{
                right: parent.right;
                rightMargin: 20;
                verticalCenter: parent.verticalCenter;
            }
            font.pixelSize: 38;
            text: '-- ' + "℃";
            color: "#FFFFFF";
        }

    }
}

