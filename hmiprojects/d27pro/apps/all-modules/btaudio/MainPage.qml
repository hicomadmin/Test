import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls
import  Bluetooth 1.0
import TheXSettings 1.0
import TheXPresenter 1.0

//BT audio信息页


ICore.Page {
    id: btaudioPage

    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')


    //property bool btstate
    property int  btaState      //bta connectState
    property int  playbackstate /*0:未定义 1:播放 2：停止 3：暂停 4:快进 5：快退 6：ERROR*/

    //property int  position   //单位s
    //property int  duration   //单位s

    property string mediaTitle
    property string artist
    property string album

    property int interfacemodel

    property var musicinfo


    onBtctlChanged: {
        btaState = Qt.binding(function (){return btctl.connectState});
        playbackstate = Qt.binding(function (){return btctl.playbackstate});
        //position = Qt.binding(function (){return btctl.position});
        //duration = Qt.binding(function (){return btctl.duration});

//        mediaTitle = Qt.binding(function(){return btctl.musicinfo.mediaTitle});
//        artist = Qt.binding(function(){return btctl.musicinfo.artist});
//        album = Qt.binding(function(){return btctl.musicinfo.album});

        musicinfo =  Qt.binding(function(){return btctl.musicinfo});
    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    onItemShown: {
        btctl.setAudioStreamMode(0)
        if (application.lastAudioSource !== HmiCommon.SourceBTA) {
            btctl.musicPlay()
        }
    }

    onMusicinfoChanged: {
        console.debug("[BTAudio] onMusicinfoChanged title= " , musicinfo.mediaTitle)
        showID3()
    }

    onPlaybackstateChanged: {
        console.debug("[BTAudio] onPlaybackstateChanged playbackstate " , playbackstate)
        if(playbackstate == 1) {
            showID3()
        }
    }

//    onPositionChanged: {
//        console.debug("onPositionChanged position " , position)
//        showProgress()
//    }

//    onDurationChanged: {
//        console.debug("onDurationChanged duration" , duration)
//        showProgress()
//    }

    function showID3() {
        if(musicinfo) {
            notsuportinfo.visible = false
            musicID3info.visible = false
            //adjust is track change
            if ("true" === musicinfo.trackChange) {
                console.debug("[BTAudio] id3 timer started!");
                id3Timer.start();
            } else {
                console.debug("[BTAudio] id3 timer stoped!");
                id3Timer.stop();
                if(musicinfo.mediaTitle === "" && musicinfo.artist === "" && musicinfo.album === "") {
                    notsuportinfo.visible = true
                    musicID3info.visible = false
                } else {
                    musicname.text = musicinfo.mediaTitle
                    artistname.text = musicinfo.artist
                    albumname.text = musicinfo.album
                    notsuportinfo.visible = false
                    musicID3info.visible = true
                }
            }
        } else {
            notsuportinfo.visible = true
            musicID3info.visible = false
        }
    }

    Timer {
        id: id3Timer
        repeat: false
        interval: 500
        onTriggered: {
            console.debug("[BTAudio] id3 timer triggered!");
            notsuportinfo.visible = true;
            musicID3info.visible = false;
        }
    }

//    function showProgress() {
//        console.debug("position =" , position)
//        console.debug("duration =" , duration)
//        if(position > duration || duration == 0) {
//            progressBarItem.visible = false;
//        } else {
//            progressBarItem.visible = true;
//        }
//    }

    Image {
        id: id3bk  //227,7光晕
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 227
        anchors.topMargin: 7
        source: (interfacemodel === 0x00)?"qrc:/resource-btaudio/Media_background2.png":((interfacemodel === 0x01)?"qrc:/resource-btaudio/Media_background2_1.png":"qrc:/resource-btaudio/Media_background2_1.png")
        visible: ((btaState & 0x0f)===0x01)
    }

    Image {
        id: btaidentifybk
        anchors {
            left: parent.left
            leftMargin: 58
            top: parent.top
            topMargin: 46
        }
        source: (interfacemodel === 0x00) ? "qrc:/resource-btaudio/Media_Icon_BTMusicbig.png":((interfacemodel === 0x01)?"qrc:/resource-btaudio/Media_Icon_BTMusicbig1.png":"qrc:/resource-btaudio/Media_Icon_BTMusicbig2.png")
    }

    Item {
        id: notsuportinfo
        //蓝牙连接一个设备，前期没有播放的话是获取不到ID3信息的，但是不表明它就不支持ID3信息显示
        //因此最好要有一个是否低于1.4的属性接口，playbackstate默认初始化值为0，播放状态时playbackstate值也为0，分不清,因此用下面的几个条件综合判断还是不妥,待接口
        width: 1280
        height: 628    //720-92
        visible: false
        IControls.NonAnimationText_FontRegular {
            id: notify
            width: 333
            anchors {
                left: parent.left
                leftMargin: 645
                top: parent.top
                topMargin: 192
            }
            text: qsTr("当前蓝牙设备不支持\n\n  歌曲信息显示！")
            color: "#FFFFFF"
            font.pixelSize: 36
            wrapMode: Text.WordWrap
        }
    }

    Item {
        id: musicID3info
        //小米3手机当id3信息为空时直接为空'',而魅族手机发送的是unknown,因此具体显示什么由手机发送的决定
        width: 1280
        height: 628    //720-92
        visible: false

        IControls.AnimationText_FontRegular {
            id: musicname
            width: 524             //329
            height: 125            //95
            anchors {
                left: parent.left
                leftMargin: 550   //600
                top: parent.top
                topMargin: 70     //100    //113
            }
            text: mediaTitle
            textColor: (interfacemodel === 0x00) ? "#66f8d4" : ((interfacemodel === 0x01) ? "#FF2200" : "#986142")
            font.pixelSize: 83
        }

        IControls.AnimationText_FontRegular {
            id: artistname
            width: 524              //329
            height: 55              //45

            anchors {
                left: parent.left
                leftMargin: 550
                top: musicname.bottom
                topMargin:  25        //37
            }
            text: artist
            textColor: "#FFFFFF"
            font.pixelSize: 36
        }

        IControls.AnimationText_FontRegular {
            id: albumname
            width: 524          //329
            height: 55          //45

            anchors {
                left: parent.left
                leftMargin: 550                //600
                top: artistname.bottom
                topMargin: 5                   //12
            }
            text: album
            textColor: "#FFFFFF"
            font.pixelSize: 36
        }

        //remove progressbar --2017-2-8 by gaojun
//        Item {
//            id: progressBarItem
//            IControls.NonAnimationText_FontRegular {
//                id: currentplaytime

//                anchors.right: btaudioprogressBar.left
//                anchors.rightMargin: 22
//                anchors.top: parent.top
//                anchors.topMargin: 424    //720-92-204

//                text: position ? formatTime(position) : '00:00'
//                color: "#FFFFFF"
//                font.pixelSize: 34
//            }

//            IControls.NonAnimationText_FontRegular {
//                id: timeinall

//                anchors.left: btaudioprogressBar.right
//                anchors.leftMargin: 22
//                anchors.top: parent.top
//                anchors.topMargin: 424      //720-92-204

//                //text: "05:48:59"
//                text: duration ? formatTime(duration) : "00:00"
//                color: "#FFFFFF"
//                font.pixelSize: 34
//            }

//            IControls.ProgressBarA {
//                id: btaudioprogressBar

//                anchors.top: parent.top
//                anchors.topMargin: 424    //720-92-204
//                anchors.left: parent.left
//                anchors.leftMargin: 206

//                maximumValue: duration
//                minimumValue: 0

//                stepSize: 1
//                value: position

//                IControls.MouseArea {
//                    //覆盖进度条的点击区域，不让外界点击
//                    id: progressBar_cover
//                    anchors.fill: parent
//                }
//            }
//        }

    }

    IControls.IconButton_MediaMusicPlayMark {
        id: btn_pre
        width: 424
        themeColor: interfacemodel
        source:'qrc:/resource-btaudio/Media_Icon_Up_nml.png'
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        UControls.GradientBar {
            id: gradBarA
            gradient_width: btn_pre.width
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            underBtnGradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#4B4B4B"
                }
                GradientStop {
                    position: 1.0
                    color: "#8C8D8C"
                }
            }
        }

        onClicked: {
            btctl.preTrack();
        }
    }

    Image {
        id: btn_line1
        anchors.left: parent.left
        anchors.leftMargin: 422
        anchors.bottom: parent.bottom
        source: "qrc:/resource-btaudio/Media_Button_Line.png"
    }

    IControls.IconButton_MediaMusicPlayMark {
        id: btn_playpause
        width: 424
        themeColor: interfacemodel
        //=0,播放状态，显示暂停图片.   = 1/2 停止/暂停
        source: (playbackstate != 1) ? 'qrc:/resource-btaudio/Media_Icon_Play_nml.png' : 'qrc:/resource-btaudio/Media_Icon_Stop_nml.png'
        anchors.left: parent.left
        anchors.leftMargin: 428
        anchors.bottom: parent.bottom

        UControls.GradientBar {
            id: gradBarB
            gradient_width: btn_pre.width
            anchors.left: parent.left
            anchors.bottom:  parent.bottom
            underBtnGradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#8E8F8F"
                }
                GradientStop {
                    position: 1.0
                    color: "#989A99"
                }
            }
        }

        onClicked: {
            console.debug("playbackstate ==  " , playbackstate)
            if( playbackstate == 1 ){
                btctl.musicPause();
            }else {
                btctl.musicPlay();
            }
        }
    }


    Image {
        id: btn_line2
        anchors.left: parent.left
        anchors.leftMargin: 850
        anchors.bottom: parent.bottom
        source: "qrc:/resource-btaudio/Media_Button_Line.png"
    }


    IControls.IconButton_MediaMusicPlayMark {
        id: btn_next
        width: 424
        themeColor: interfacemodel
        source:'qrc:/resource-btaudio/Media_Icon_Down_nml.png'
        anchors.left: parent.left
        anchors.leftMargin: 856
        anchors.bottom: parent.bottom

        UControls.GradientBar {
            id: gradBarC
            gradient_width: btn_pre.width
            anchors.left: parent.left
            anchors.bottom:  parent.bottom
            underBtnGradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#969897"
                }
                GradientStop {
                    position: 1.0
                    color: "#4B4B4B"
                }
            }
        }

        onClicked: {
            btctl.nextTrack();
        }
    }

    //格式化时间函数 00:00:00
    function formatTime(timeInMs) {
        if (!timeInMs || timeInMs <= 0) {
            return "00:00"
        }
        var hours = 0, minute = 0, second = 0;
        var seconds = timeInMs;

        if(seconds > 59 ){
            minute = Math.floor(seconds / 60)
            second = Math.floor(seconds % 60)
            if(minute > 59 ){
                hours = Math.floor(minute / 60)
                minute = Math.floor(minute % 60)
            }
        }else {
            second = Math.floor(seconds)
        }
        if (second < 10) second = "0" + second;
        if (minute < 10) minute = "0" + minute;
        if(hours == 0){
            return minute + ":" + second
        }else {
            return hours + ":" + minute + ":" + second
        }
    }

}

