import QtQuick 2.3
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.1
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs
import QtMultimedia 5.0
import TheXMusic 1.0
import TheXSettings 1.0
import TheXAudio 1.0
import TheXPresenter 1.0

ICore.Page {
    id: root;
    property bool isCopy: false
    anchors.fill: parent;

    property var dialogTips: null

    readonly property int _ALL_CYCLES: 0
    readonly property int _SINGLE_CYCLE: 1
    readonly property int _SHUFFLE_PLAYBACK: 2

    property SystemCtl system: HSPluginsManager.get('system')
    property MusicCtl musicctl: HSPluginsManager.get('musicctl')

    property int playState: Constant._USB_MUSIC_STOP
    property int playRangen: Constant._PLAY_RANGE_ALL //The source of the middleware play range
    property int random: Constant._RANDOM_CLOSE
    property var musicInfo: null
    property var during: []
    property int position: 0
    property int duration: 0

    property bool isCover: Constant._NO_ALBUMS	//是否存在专辑图片	bool
    property int length: 0	//歌曲长度	double
    property string musictitle: '  '	//歌曲标题	QString
    property string artist: '  '	//艺术家名字	QString
    property string album: ''	//专辑名字	QString
    property string filename: ''	//歌曲名字	QString
    property var _ID	//歌曲编号,所在数据库编号	double
    property string albpic: ''	//专辑图片存放路径	QString

    property int trackId:0 //The source of the local page index
    property string trackPath //The source of the local page play path
    property int trackPlayRangen:Constant._PLAY_RANGE_ALL //The source of the local page play range
    property int loopType: _ALL_CYCLES

    property var albumCover: null
    property bool manualPlay:false

    readonly property var ifModel_0: ({
                                          music_bg: "qrc:/resource-usb/media-music-play_bg.png",
                                          transparent_bg: "qrc:/resource-usb/Media_background2.png",
                                          abcover: "qrc:/resource-usb/Media_Icon_Musicbig.png",
                                          songNameColor: "#66F8D4",
                                          btnColor: ["#267284", "#0E5263"]
                                      })
    readonly property var ifModel_1: ({
                                          music_bg: "qrc:/resource-usb/media-music-play_bg_o.png",
                                          transparent_bg: "qrc:/resource-usb/Media_background2_o.png",
                                          abcover: "qrc:/resource-usb/Media_Icon_Musicbig_o.png",
                                          songNameColor: "#FF2200",
                                          btnColor: ["#9B1702", "#2D0D07"]
                                      })
    readonly property var ifModel_d: ({
                                          music_bg: "qrc:/resource-usb/media-music-play_bg_g.png",
                                          transparent_bg: "qrc:/resource-usb/Media_background2_g.png",
                                          abcover: "qrc:/resource-usb/Media_Icon_Musicbig_g.png",
                                          songNameColor: "#986142",
                                          btnColor: ["#ab7c48", "#855033"]
                                      })
    property var ifModel: {
        switch (system.interfacemodel) {
        case 0:  ifModel_0; break
        case 1:  ifModel_1; break
        default: ifModel_d; break
        }
    }

    function prepareDatas() {
        playState = Qt.binding(function (){ return musicctl.playState })
        playRangen = Qt.binding(function (){ return musicctl.playRangen })
        random = Qt.binding(function (){ return musicctl.random })
        musicInfo = Qt.binding(function (){ return musicctl.musicInfo })
        during = Qt.binding(function (){ return musicctl.during })
        position = Qt.binding(function (){ return during[1] ? during[1] : 0 })
        duration = Qt.binding(function (){ return during[0] ? during[0] : 0 })

        isCover = Qt.binding(function (){ return (musicInfo && musicInfo.isCover !== undefined) ? musicInfo.isCover : Constant._NO_ALBUMS })
        length = Qt.binding(function (){ return (musicInfo && musicInfo.length !== undefined) ? musicInfo.length : 0 })
        musictitle = Qt.binding(function (){ return (musicInfo && musicInfo.title !== undefined) ? musicInfo.title : '' })
        artist = Qt.binding(function (){ return (musicInfo && musicInfo.artist !== undefined) ? musicInfo.artist : '' })
        album = Qt.binding(function (){ return (musicInfo && musicInfo.album !== undefined) ? musicInfo.album : '' })
        filename = Qt.binding(function (){ return (musicInfo && musicInfo.filename !== undefined) ? musicInfo.filename : '' })
        _ID = Qt.binding(function (){ return (musicInfo && musicInfo.ID !== undefined) ? musicInfo.ID : '' })
        albpic = Qt.binding(function (){ return (_ID === '') ? '' : "file:///tmp/albumCover/" + _ID + ".jpg" })

        loopType = Qt.binding(function (){ return playRangen === Constant._PLAY_RANGE_SINGLE ? _SINGLE_CYCLE : (random === Constant._RANDOM_OPEN ? _SHUFFLE_PLAYBACK : _ALL_CYCLES ) })
        albumCover = Qt.binding(function (){ return musicctl.albumCover })
    }

    onReadyToShow: {
        console.debug("music_playing onReadyToShow trackPath:" + trackPath + " trackId:" + trackId + " _ID:"+ _ID + " playState:" + playState)
        JSLibs.async.nextTick(prepareDatas)
    }

    onItemShown: {
        if(manualPlay || application.lastAudioSource !== HmiCommon.SourceUSBMP3) {
            if (trackPath !== '') {
                musicctl.play(trackPath)
            } else {
                musicctl.play(trackId, Constant._USB_MUSIC_PLAY_POSITION)
            }
        }
        if(loopType !== _SINGLE_CYCLE) {
            musicctl.setPlayRangen(trackPlayRangen)
        }
        manualPlay = false
    }

    onAlbumCoverChanged: {
        if (albumCover && (albumCover.ID === _ID)) {
            abcover.source = "file://" + albumCover.coverPath
        }
    }

    onAlbpicChanged: {
        abcover.source = albpic
        console.debug("music_playing albpic : " + albpic);
    }

    function getLoopIcon() {
        var loopicon
        switch(loopType) {
        case _SINGLE_CYCLE:
            loopicon = 'qrc:/resource-usb/Media_Icon_Circulation1.png'
            break;
        case _SHUFFLE_PLAYBACK:
            loopicon = 'qrc:/resource-usb/Media_Icon_Random.png'
            break;
        case _ALL_CYCLES:
        default:
            loopicon = 'qrc:/resource-usb/Media_Icon_Circulation.png'
            break;
        }
        return loopicon
    }

    Image {
        id:music_bg
        width:1280
        height:720
        x:0
        y:0
        source:ifModel.music_bg
    }

    Image {
        id:transparent_background
        width:944
        height:546
        x:227
        y:7
        source:ifModel.transparent_bg
    }

    Image {
        id:abcover
        width:422
        height:346
        anchors{
            left:parent.left
            leftMargin: 58
            top:parent.top
            topMargin: 46
        }
        source: albpic
        onStatusChanged: {
            if(status !== Image.Ready) {
                source = ifModel.abcover
            }
        }
    }

    IControls.AnimationText_FontRegular {
        id: songNameText
        height:120
        width:419
        anchors{
            top:parent.top
            topMargin: 113
            left:abcover.right
            leftMargin:62
        }
        text:musictitle !== '' ? musictitle : qsTr("未知");
        font.pixelSize: 83
        textColor:ifModel.songNameColor
    }

    IControls.NonAnimationText_FontRegular {
        id: artistname
        height:33
        width:419
        anchors{
            top:songNameText.bottom
            topMargin: 30
            left:songNameText.left
        }
        text:artist !== '' ? artist : qsTr("未知");
        font.pixelSize: 36
        color:'#CBD6D8'
    }

    IControls.NonAnimationText_FontRegular {
        id: albumname
        height:33
        width:419
        anchors{
            top:artistname.bottom
            topMargin: 12
            left:songNameText.left
        }
        text: album !== '' ? album : ''
        elide:Text.ElideRight
        font.pixelSize: 36
        color:'#CBD6D8'
    }

    IControls.RoundLabButtonD {
        id: music_list
        width: 120;
        height: 98;
        normalSource: 'qrc:/resource-usb/Media_Icon_List.png'
        anchors{
            right:parent.right
            rightMargin: 29
            top:parent.top
            topMargin: 40
        }
        onClicked: {
            application.changePage('music_main')
        }
    }

    IControls.RoundLabButtonD {
        id: music_mode
        width: 120;
        height: 98;
        normalSource: getLoopIcon()
        anchors{
            right:parent.right
            rightMargin: 29
            top:music_list.bottom
            topMargin: 19
        }

        onClicked:{
            switch(loopType) {
            case _SINGLE_CYCLE:
                /* set loop is single cycle */
                musicctl.setPlayRangen(trackPlayRangen)
                musicctl.setRandom(Constant._RANDOM_OPEN)
                application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip_music.qml',{themeColor:system.interfacemodel,text: qsTr("随机播放")},callBackDialog);
                break;
            case _SHUFFLE_PLAYBACK:
                /* set loop is all cycles */
                musicctl.setPlayRangen(trackPlayRangen)
                musicctl.setRandom(Constant._RANDOM_CLOSE)
                application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip_music.qml',{themeColor:system.interfacemodel,text: qsTr("全部循环")},callBackDialog);
                break;
            case _ALL_CYCLES:
            default:
                /* set loop is single cycle */
                musicctl.setPlayRangen(Constant._PLAY_RANGE_SINGLE)
                musicctl.setRandom(Constant._RANDOM_CLOSE)
                application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip_music.qml',{themeColor:system.interfacemodel,text: qsTr("单曲循环")},callBackDialog);
                break;
            }
        }
    }

    function callBackDialog(dialog){
        closeDialog()
        console.debug("........................................Close the old dialog...................")
        dialogTips = dialog
        if (!(autocloser.running)) {
            closeDialog()
        }
    }

    function closeDialog()
    {
        if(dialogTips)
        {
            dialogTips.close()
            dialogTips = null
        }
    }

    IControls.ProgressBarA {
        id: progressBar
        themeColor: system.interfacemodel
        anchors {
            bottom:music_controller.top
            bottomMargin: 15
            left: parent.left
            leftMargin: 202
        }
        maximumValue: root.duration
        onPressedChanged: {
            if (!pressed) {
                 if (HmiCommon.source !== HmiCommon.SourceTTS) musicctl.seek(value/1000)
            }
        }
    }

    onPositionChanged: {
        if (!progressBar.pressed && progressBar.value != position) {
            progressBar.value = position
        }
    }

    IControls.NonAnimationText_FontRegular {
        id: positionText

        anchors {
            top:abcover.bottom
            topMargin: 34
            right:progressBar.left
            rightMargin: 22
        }
        font.family: "黑体"
        font.pixelSize: 34

        color: "#FFFFFF"
        text: JSLibs.formatTime(position)
        renderType: Text.QtRendering
    }

    IControls.NonAnimationText_FontRegular {
        id: durationText
        anchors {
            top: positionText.top
            left: progressBar.right
            leftMargin: 21
        }
        font.family: "黑体"
        font.pixelSize: 34
        color: "#FFFFFF"
        text: JSLibs.formatTime(duration)
        renderType: Text.QtRendering
    }


    Row {
        id: music_controller
        anchors.bottom: parent.bottom

        IControls.IconButton_Normal {
            id:button_up
            width: 424
            height: 147
            bgGradient: Gradient {
                GradientStop { position: 0.0; color: "#343638" }
                GradientStop { position: 1.0; color: "#1a1b1d" }
            }
            bgPressingGradient: Gradient {
                GradientStop { position: 0.0; color: ifModel.btnColor[0] }
                GradientStop { position: 1.0; color: ifModel.btnColor[1] }
            }
            source: 'qrc:/resource-usb/Media_Icon_Up_nml.png'
            onClicked: {
                 if(HmiCommon.source !== HmiCommon.SourceTTS) musicctl.previous()
            }
        }
        Image{
            id:line1
            source:'qrc:/resource-usb/Media_Button_Line.png'
        }
        IControls.IconButton_Normal {
            id:button_play
            width: 424
            height: 147
            bgGradient: Gradient {
                GradientStop { position: 0.0; color: "#343638" }
                GradientStop { position: 1.0; color: "#1a1b1d" }
            }
            bgPressingGradient: Gradient {
                GradientStop { position: 0.0; color: ifModel.btnColor[0] }
                GradientStop { position: 1.0; color: ifModel.btnColor[1] }
            }
            source: playState === Constant._USB_MUSIC_PLAYING ?
                        "qrc:/resource-usb/Media_Icon_Stop_nml.png" : "qrc:/resource-usb/Media_Icon_Play_nml.png"
            onClicked: {
                if (HmiCommon.source !== HmiCommon.SourceTTS) {
                    if(playState === Constant._USB_MUSIC_PLAYING) {
                        musicctl.pause()
                    } else {
                        musicctl.resume()
                    }
                }
            }
        }
        Image{
            id:line2
            source:'qrc:/resource-usb/Media_Button_Line.png'
        }
        IControls.IconButton_Normal {
            id:button_down
            width: 424
            height: 147
            bgGradient: Gradient {
                GradientStop { position: 0.0; color: "#343638" }
                GradientStop { position: 1.0; color: "#1a1b1d" }
            }
            bgPressingGradient: Gradient {
                GradientStop { position: 0.0; color: ifModel.btnColor[0] }
                GradientStop { position: 1.0; color: ifModel.btnColor[1] }
            }
            source: 'qrc:/resource-usb/Media_Icon_Down_nml.png'
            onClicked: {
                 if(HmiCommon.source !== HmiCommon.SourceTTS) musicctl.next()
            }
        }
    }

    onPlayStateChanged: {
        console.debug("music_playing playState:" + playState )
        if(playState === Constant._USB_MUSIC_PLAYING) {
            poploader.active = false
        } else if(playState === Constant._USB_MUSIC_ERROR) {
            poploader.active = true
        } else if (playState === Constant._USB_MUSIC_END) {
            poploader.active = false
        }
    }

    Loader{
        id:poploader
        active: false
        anchors.centerIn: parent
        sourceComponent: Component{
            Rectangle { //弹出框
                height: 100
                color: system.interfacemodel == 0 ? "#103c4b":(system.interfacemodel == 1 ?"#480E05":"#986142")
                opacity: 0.9
                UControls.Label {
                    anchors.centerIn: parent
                    color: "#FFFFFF"
                    text: qsTr('不支持此歌曲')
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
