import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
import 'qrc:/UI/JSLibs/Util.js' as Util
import QtMultimedia 5.0
//import Multimedia 1.0
import Bluetooth 1.0
import TheXVideo 1.0
import TheXDevice 1.0
import TheXMcan 1.0
import TheXSettings 1.0
import TheXPresenter 1.0

ICore.Page {
    id: root;
    anchors.fill: parent;
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property int statas
    property int seekPos
    property int  videoState : 1
    property int vifilecount
    property string path
    property double speed
    property bool  speedingflag : false
    property bool  isInit : false

    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0

    property VideoCtl videoctl: HSPluginsManager.get('videoctl')
    property var playState: videoctl ? videoctl.playState : Constant._USB_MUSIC_STOP
    property var during: videoctl ? videoctl.during: null
    property var position: (during && during[1] !== undefined) ? during[1] : 0
    property var duration: (during && during[0] !== undefined) ? during[0] : 0

    property double trackId:0 //The source of the local page index
    property string trackPath //The source of the local page play path
    property var trackPlayRangen:0 //The source of the local page play range

    /* BEGIN by Zhang Yi, 2016.11.22
     * McanCtl should only be constructed once.
    */
    property McanCtl mcan: HSPluginsManager.get('mcan')

    Connections {
        target: mcan

        onCarSpeedChanged: {
            speed = mcan.carSpeed / 100;
            if(speed > 20)
            {
                if (!speedingflag)
                {
                    speedingflag = true;
                    speedtime.restart();
                    application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',{themeColor:interfacemodel,text: qsTr("为了行车安全，系统会关闭视频"),autoCloseTimeout: 3000 });
                }
            }
        }
    }
    /* END - by Zhang Yi, 2016.11.22 */

    Timer {
        id: speedtime
        interval: 5000
        repeat: false
        onTriggered: {
            speedingflag = false;
            if(speed > 20)
            {
                videoctl.pause();
                timer.stop();
                application.back();
            }
        }
    }

    Rectangle {
        id:bg
        width: parent.width
        height: parent.height
        color: '#000001'
        Loader{
            id:poploader
            active: false
            anchors.centerIn: parent
            sourceComponent: Component{
                Rectangle { //弹出框
                    height: 100
                    color: interfacemodel == 0 ? "#103c4b":(interfacemodel == 1 ?"#480E05":"#986142")
                    opacity: 0.9
                    UControls.Label {
                        anchors.centerIn: parent
                        color: "#FFFFFF"
                        text: qsTr('不支持此视频')
                        font.pixelSize: 36
                        Component.onCompleted: {
                            parent.width = width + 128;
                            parent.height = height;
                        }
                    }
                }
            }
        }
    }

    property var lastPlayState :Constant._USB_MUSIC_STOP
    onPlayStateChanged: {
        setOverlay()
        console.debug("video_playing playState:" + playState )
        if(playState === Constant._USB_MUSIC_PLAYING) {
            application.appWindow.backBtnEnable = true
            poploader.active = false
        } else if(lastPlayState === Constant._USB_MUSIC_ERROR && playState === Constant._USB_MUSIC_STOP) {
            application.appWindow.backBtnEnable = true
            poploader.active = true
            setControllerShow(true)
            timer.stop()
        } else if (playState === Constant._USB_MUSIC_END) {
            poploader.active = false
            application.appWindow.backBtnEnable = false
        }
        lastPlayState = playState
    }

    function onCreate() {
        if(isInit) return;
        isInit = true;
        console.debug("video_playing onCreate trackId:" + trackId + " trackPath:" + trackPath + " trackPlayRangen:" + trackPlayRangen)
        setOverlay()
        poploader.active = false
        application.appWindow.backBtnEnable = false
        if(trackPath) {
            videoctl.play(trackPath);
        } else {
            videoctl.play([trackId, 2, 0, 0]);
        }
        videoctl.setScale(1)
        videoctl.setPlayRangen(trackPlayRangen)
    }

    onItemShowing: {
        console.debug("video_playing onItemShowing HmiCommon.getCurrentSource():" + HmiCommon.getCurrentSource() )
        onCreate()
        setControllerShow(true)
        timer.restart();
    }

    Component.onDestruction: {
        videoctl.stop()
    }

    function setOverlay() {
        videoctl.setOverlay(1, 0x000001, 255)
    }

    IControls.ProgressBarA{
        id:video_progressBar
        themeColor: interfacemodel
        visible:true
        z:1
        anchors{
            bottom:video_controller.top
            bottomMargin: 27
            left:parent.left
            leftMargin: 202
        }
        value: position
        maximumValue:duration
        onPressedChanged: {
            if(pressed) {
                timer.stop()
                value = value
            } else {
                timer.restart()
                videoctl.seek(value/1000)
                timeval.restart()
            }
        }
    }

    onPositionChanged: {
        if(!video_progressBar.pressed && video_progressBar.value != position) {
            video_progressBar.value = Qt.binding(function(){return position})
        }
    }


    Timer{
        id:timeval
        interval: 125
        repeat: false
        onTriggered: {
            setOverlay()
        }
    }
    IControls.NonAnimationText_FontRegular {
        id: positionText
        visible:true
        z:1
        anchors {
            bottom:video_controller.top
            bottomMargin: 29
            right:video_progressBar.left
            rightMargin: 22
        }
        font.pixelSize: 34

        color: "#A5A6A8"
        text: Util.formatTime(position)
        renderType: Text.QtRendering
    }

    IControls.NonAnimationText_FontRegular {
        id: durationText
        visible:true
        z:1
        anchors {
            top:positionText.top
            left:video_progressBar.right
            leftMargin: 22
        }
        font.pixelSize: 34

        color: "#A5A6A8"
        text: Util.formatTime(duration)
        renderType: Text.QtRendering
    }
    Row{
        id:video_controller
        visible:true
        z:1
        anchors.bottom:parent.bottom
        ExclusiveGroup{
            id: chosen
        }
        IControls.IconButtonB{
            id:button_up
            themeColor: interfacemodel
            width:424
            height:147
            exclusiveGroup: chosen
            color:'#000001'
            normalSource: 'qrc:/resource-usb/Media_Icon_Up_nml.png'
            pressingSource: normalSource
            onClicked: {
                if(!application.appWindow.backBtnEnable)return
                poploader.active = false
                application.appWindow.backBtnEnable = false
                timer.restart();
                videoctl.previous()
            }
        }
        Image{
            id:line1
            source:'qrc:/resource-usb/Media_Image_Button_Line.png'
        }

        IControls.IconButtonB{
            id:button_play
            themeColor: interfacemodel
            width:424
            height:147
            exclusiveGroup: chosen
            color:'#000001'
            iconSource: playState === Constant._USB_MUSIC_PLAYING ?
                            "qrc:/resource-usb/Media_Icon_Stop_nml.png" : "qrc:/resource-usb/Media_Icon_Play_nml.png"
            //            pressingSource: normalSource
            onClicked: {
                timer.restart();
                if(playState === Constant._USB_MUSIC_PLAYING){
                    videoctl.pause();
                }else{
                    videoctl.resume();
                }
            }
        }
        Image{
            id:line2
            source:'qrc:/resource-usb/Media_Image_Button_Line.png'
        }
        IControls.IconButtonB{
            id:button_down
            themeColor: interfacemodel
            width:424
            height:147
            exclusiveGroup: chosen
            color:'#000001'
            normalSource: 'qrc:/resource-usb/Media_Icon_Down_nml.png'
            pressingSource: normalSource
            onClicked: {
                if(!application.appWindow.backBtnEnable)return
                poploader.active = false
                application.appWindow.backBtnEnable = false
                videoctl.next()
                timer.restart();
            }
        }
    }
    Timer{
        id:timer
        interval: 5000
        repeat:false
        triggeredOnStart: false
        onTriggered: {
            setControllerShow(false)
            application.appWindow.backBtnEnable = true
        }

    }

    IControls.MouseArea{
        id:toucharea
        width:1280
        height:481
        anchors.fill: parent
        onClicked: {
            setControllerShow(!video_controller.visible)
        }
    }

    function setControllerShow(visible) {
        console.debug("video_playing setControllerShow visible:" + visible)
        if(video_controller.visible != visible) {
            video_controller.visible = visible
            positionText.visible = visible
            durationText.visible = visible
            video_progressBar.visible = visible
            application.appWindow.hideStatusBar = !visible
        }
        if(visible) {
            timer.restart()
        }
    }


}
