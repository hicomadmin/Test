import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import TheXPresenter 1.0
import TheXRadio 1.0
import TheXAudio 1.0
import TheXSettings 1.0
import TheXDevice 1.0
import TheXMusic 1.0
import TheXWifi 1.0

import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

ICore.Page {
    id: root
    anchors.fill: parent

    property MusicCtl musicctl: HSPluginsManager.get('musicctl')
    property DevCtl devctl: HSPluginsManager.get('devctl')
    property RadioCtl radio: HSPluginsManager.get('radio')
    property SystemCtl system: HSPluginsManager.get('system')
    property WifiCtl wifictl: HSPluginsManager.get('wifictl')

    property int devState: Constant._DEVICE_STATE_UNKNOWN
    property int devType: Constant._DEVICE_TYPE_UNKNOWN

    property int playState: Constant._USB_MUSIC_STOP
    property int playRangen: Constant._PLAY_RANGE_ALL //The source of the middleware play range
    property int random: Constant._RANDOM_CLOSE

    property int mediaMusic: 0
    property bool isShowMusicWidget: false
    property var musicInfo: null
    property var during: []
    property int position: 0
    property int duration: 0
    property bool isCover: Constant._NO_ALBUMS	//是否存在专辑图片	bool
    property int length: 0	//歌曲长度	double
    property string musictitle: ''	//歌曲标题	QString
    property string artist: ''	//艺术家名字	QString
    property string album: ''	//专辑名字	QString
    property string filename: ''	//歌曲名字	QString
    property var _ID	//歌曲编号,所在数据库编号	double
    property string albpic: ''	//专辑图片存放路径	QString

    property bool isFM: true
    property bool openState: false
    property int band
    property real current_freq: 87.5
    property real radioState

    property string lastapp;
    property string lastpage;

    property int menuindex: 0;
    property int selectindex: 0;

    /* BEGIN by Xiong wei, 2016.12.27
     *  Add longpress states
    */
    property int firstIndex : -1
    property bool isBackFlag : false
    //End by xiongwei 2016.12.27

    property real day
    property real month
    property var today
    property var deviceInfo: null

    property real mobileState
    property int mobileTmp

    readonly property var ifModel_0: ({
                                          imageLine: "qrc:/resources/list_line_left 2.png",
                                          sliderColor: "#66f8d4",
                                          btnColor: ["#267284", "#0E5263"],
                                          musicBg: "qrc:/resources-home/home_option_music_Bg.png",
                                          radioBg: "qrc:/resources-home/home_option_radio_Bg.png"
                                      })
    readonly property var ifModel_1: ({
                                          imageLine: "qrc:/resources/list_line_left-2.png",
                                          sliderColor: "#FF2200",
                                          btnColor: ["#9B1702", "#2D0D07"],
                                          musicBg: "qrc:/resources-home/home_option_music_Bg_o.png",
                                          radioBg: "qrc:/resources-home/home_option_radio_Bg_o.png"
                                      })
    readonly property var ifModel_d: ({
                                          imageLine: "qrc:/resources/list_line_left 2_g.png",
                                          sliderColor: "#B87330",
                                          btnColor: ["#ab7c48", "#855033"],
                                          musicBg: "qrc:/resources-home/home_option_music_Bg_g.png",
                                          radioBg: "qrc:/resources-home/home_option_radio_Bg_g.png"
                                      })
    property var ifModel: {
        switch (system.interfacemodel) {
        case 0:  ifModel_0; break
        case 1:  ifModel_1; break
        default: ifModel_d; break
        }
    }

    function prepareDatas() {
        month = Qt.binding(function (){return system.month});
        day = Qt.binding(function (){return system.day});

        deviceInfo = Qt.binding(function (){ return devctl.deviceInfo });
        mobileState = Qt.binding(function(){ return system.mobileState })

        band = Qt.binding(function (){ return radio.radioBand })
        current_freq = Qt.binding(function (){ return radio.frequency })
        radioState = Qt.binding(function (){ return radio.radioState })
        openState = Qt.binding(function (){ return radio.openState })

        playState = Qt.binding(function (){ return musicctl.playState })
        playRangen = Qt.binding(function (){ return musicctl.playRangen })
        random = Qt.binding(function (){ return musicctl.random })

        mediaMusic = Qt.binding(function (){ return (devctl.mediaInfo && devctl.mediaInfo.mediaMusic) ? devctl.mediaInfo.mediaMusic : 0 })
        isShowMusicWidget = Qt.binding(function (){ return (devState === Constant._DEVICE_STATE_INSERT && devType === Constant._DEVICE_TYPE_UDISK && mediaMusic > 0) })
        musicInfo = Qt.binding(function (){ return isShowMusicWidget ? musicctl.musicInfo : null })
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
        albpic = Qt.binding(function (){ return (!isShowMusicWidget || _ID === '') ? 'qrc:/resources-home/home_music_ption.png' : "file:///tmp/albumCover/" + _ID + ".jpg" })
    }

    onItemReadyShow: requireinfo()

    onReadyToShow: {
        radio.getCurFreq(0)

        /* BEGIN by Xiong wei, 2016.12.22
         *  Power off and then turn on WiFi
        */
        if (system.wifisw) {
            startUpdate.start()
        }
        //End by xiongwei 2016.12.22

        prepareDatas()
        switchLoader.active = true
    }

    /* BEGIN by Xiong wei, 2016.12.22
     *  Power off and then turn on WiFi
    */
    Timer {
        id: startUpdate
        interval: 1700
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            wifictl.turnOn(2)
            SoundCommon.getAllAudioParam()
        }
    }
    //End by xiongwei 2016.12.22

    Connections {
        target: HmiCommon
        onKeyEvent: {
            switch (keycode[0]) {
            case HmiCommon.AUDIO_PANEL_HOME:
                if (keycode[1] === HmiCommon.KEY_STA_RELEASED) {
                    firstIndex = -1
                    isBackFlag = false
                    switchLoader.sourceComponent = menucom
                }
                break
            }
        }
    }

    onMonthChanged: {
        today = new Date()
    }

    onDayChanged: {
        today = new Date()
    }

    onDeviceInfoChanged: {
        devType = Qt.binding(function (){return (deviceInfo && deviceInfo.devType !== undefined) ? deviceInfo.devType : Constant._DEVICE_TYPE_UNKNOWN}) //devType	USB device name, type:double	area:0 ~ 4	0： unknown	1：U disk	2：IPOD	3：CarPlay	4：Android device
        devState = Qt.binding(function (){return (deviceInfo && deviceInfo.devState !== undefined) ? deviceInfo.devState : Constant._DEVICE_STATE_UNKNOWN}) //USB state type:double	area:0 ~ 2	0：unknown 	1： instart	2：out pull
    }

    onCurrent_freqChanged: {
        console.debug('onCurrent_freqChanged: ',current_freq);
    }

    onBandChanged: {
        console.debug('onBandChanged: ',band);
        switch(band){
        case 0:
        case 1:
        case 2:
        case 3: isFM = true;break;
        case 4:
        case 5:
        case 6: isFM = false; break;
        }
    }

    readonly property var __menuinfo: [
        {
            icon: 'qrc:/resources-home/home_Icon_radio_nml.png',
            disableIcon :'qrc:/resources-home/home_Icon_radio_null.png',
            iconImageBlue:'qrc:/resources-menu/Radio.png',
            iconImageOrange:'qrc:/resources-menu/Radio1.png',
            iconImageGold:'qrc:/resources-menu/Radio2.png',
            selecticon:'',
            tabTitle: "收音机",
            appid: "radio",
        },
        {
            icon: 'qrc:/resources-home/home_Icon_Media_nml.png',
            disableIcon :'qrc:/resources-home/home_Icon_Media_null.png',
            iconImageBlue:'qrc:/resources-menu/Media.png',
            iconImageOrange:'qrc:/resources-menu/Media1.png',
            iconImageGold:'qrc:/resources-menu/Media2.png',
            selecticon:'',
            tabTitle: "多媒体",
            appid:"menu",
            pageid: 'media',
        },
        {
            icon: 'qrc:/resources-home/home_Icon_phone_nml.png',
            disableIcon :'qrc:/resources-home/home_Icon_phone_null.png',
            iconImageBlue:'qrc:/resources-menu/Phone.png',
            iconImageOrange:'qrc:/resources-menu/Phone1.png',
            iconImageGold:'qrc:/resources-menu/Phone2.png',
            selecticon:'',
            tabTitle: "电话",
            appid: 'hf'
        },
        {
            icon: 'qrc:/resources-home/home_Icon_whole_nml.png',
            disableIcon :'qrc:/resources-home/home_Icon_home.png',
            iconImageBlue:'',
            iconImageOrange:'',
            iconImageGold:'',
            selecticon:'',
            tabTitle: "全部",
            appid: 'menu',
            pageid:'main'
        }
    ]
    property var menuinfo: []

    readonly property var __selectinfo: [
        {
            icon: 'qrc:/resources-home/home_Icon_Calendar_nml.png',
            disableIcon :'qrc:/resources-home/home_Icon_Calendar_null.png',
            iconImageBlue:'qrc:/resources-menu/Calendar.png',
            iconImageOrange:'qrc:/resources-menu/Calendar1.png',
            iconImageGold:'qrc:/resources-menu/Calendar2.png',
            selecticon:'',
            tabTitle: "日历",
            appid: "calendar",
        },
        /*
        {
           icon: 'qrc:/resources-home/home_Icon_baiducarlife_nml.png',
           selecticon:'',
           tabTitle: "carLife",
           appid: 'carlife'
        },
        {
           icon: 'qrc:/resources-home/home_Icon_Ecolink_nml.png',
           selecticon:'',
           tabTitle: "ecoLink",
           appid:"ecolink",
        },*/
        {
            icon: 'qrc:/resources-home/home_Icon_windlink.png',
            disableIcon :'qrc:/resources-home/home_Icon_windLink_null.png',
            iconImageBlue:'qrc:/resources-menu/WindLink.png',
            iconImageOrange:'qrc:/resources-menu/WindLink1.png',
            iconImageGold:'qrc:/resources-menu/WindLink2.png',
            selecticon:'',
            tabTitle: "WindLink",
            appid: 'wndlink'
        },
        /*{
           icon: 'qrc:/resources-home/home_Icon_Ecolink_nml.png',
           selecticon:'',
           tabTitle: "mirrorLink",
           appid: 'mirrorlink'
        },*/
        {
            icon: 'qrc:/resources-home/home_Icon_Setting_nml.png',
            disableIcon :'qrc:/resources-home/home_Icon_Setting_null.png',
            iconImageBlue:'qrc:/resources-menu/Setting.png',
            iconImageOrange:'qrc:/resources-menu/Setting1.png',
            iconImageGold:'qrc:/resources-menu/Setting2.png',
            selecticon:'',
            tabTitle: "设置",
            appid: 'settings'
        },
        {
            icon: 'qrc:/resources-home/home_Icon_Dfsc_nml.png',
            disableIcon :'qrc:/resources-home/home_Icon_Dfsc_null.png',
            iconImageBlue:'qrc:/resources-menu/Manual.png',
            iconImageOrange:'qrc:/resources-menu/Manual1.png',
            iconImageGold:'qrc:/resources-menu/Manual2.png',
            selecticon:'',
            tabTitle: "东风手册",
            appid: 'manual'
        }
    ]
    property var selectinfo: []

    Column{
        id:menuCol;
        anchors.left: root.left;
        anchors.top: root.top;
        //            spacing: 10;
        Repeater{
            id:menure
            model:menuinfo //Homedata.menuinfo;

            Item{
                width: 242;
                height: 158;
                IControls.GradientButtonA {
                    id: conttext
                    themeColor: system.interfacemodel
                    width: 242;
                    height: 154;
                    textPixelSize : system.language === 0 ? 36 : 30
                    /* BEGIN by Xiong wei, 2016.12.27
                     *  Add longpress states
                    */
                    textCenterOffset: system.language === 0 ? -2 : 0
                    //End by xiongwei 2016.12.27
                    onClicked: {
                        if(switchLoader.sourceComponent === selectcom){
                            switchLoader.sourceComponent = menucom;
                        }

                        if(menuinfo[index].appid === 'menu'){
                            if (!isBackFlag) {
                                application.multiApplications.changeApplication(menuinfo[index].appid,{properties: {initialPage: menuinfo[index].pageid}});
                            } else {
                                firstIndex = -1
                                isBackFlag = false
                            }
                        } else {
                            if (menuinfo[index].appid === 'usb') {
                                application.multiApplications.changeApplication('usb', {properties: {initialPage: 'music_playing'}});
                            }
                            else {
                                application.multiApplications.changeApplication(menuinfo[index].appid);
                            }
                        }
                    }
                    onLongPressed: {
                        if (menuinfo[index].pageid === 'main') {
                            if (!isBackFlag) {
                                application.multiApplications.changeApplication(menuinfo[index].appid,{properties: {initialPage: menuinfo[index].pageid}});
                            } else {
                                switchLoader.sourceComponent = menucom;
                                isBackFlag = false
                            }
                        } else {
                            isBackFlag = true
                            menuindex = index
                            switchLoader.sourceComponent = selectcom;
                        }
                        firstIndex = isBackFlag ? index : -1
                    }
                    /* BEGIN by Xiong wei, 2016.12.27
                     *  Add longpress states
                    */
                    longHoldPressed: (firstIndex !== index) ? false : true
                    enabled: (!isBackFlag || index == 3) ? true : false
                    btnName: qsTr((modelData.tabTitle === "WindLink") ? "" : ((index === 3 && isBackFlag) ? '主界面' : modelData.tabTitle)) + ctranslator.monitor //menuinfo[index].tabTitle // modelData.tabTitle
                    iconSource:(firstIndex == index) ? menuinfo[index].icon : (isBackFlag && (!enabled || index ==3)) ? menuinfo[index].disableIcon : menuinfo[index].icon  //modelData.icon
                    //End by xiongwei 2016.12.27
                }

                Image {
                    id: imageline;
                    anchors.top: conttext.bottom;
                    source: ifModel.imageLine
                }
            }
        }
    }

    Loader{
        id: switchLoader
        active: false
        width: 346*3
        height: 628
        anchors.left: menuCol.right
        sourceComponent: menucom
    }

    Component{
        id: menucom;
        Item{
            Timer{
                id:timersoureceid
                property bool isClick:true
                interval: 500
                onTriggered: {
                    isClick = true;
                }
            }

            anchors.fill: parent;
            Item{
                id:musicIt;
                width: 346;
                height: 628;
                Image {
                    anchors.fill: parent;
                    source: ifModel.musicBg
                }
                IControls.MouseArea{
                    anchors.fill: parent;
                    enabled: isShowMusicWidget? true : false;
                    onClicked:{
                        if (isShowMusicWidget){
                            application.multiApplications.changeApplication('usb', {properties: {initialPage: 'music_playing'}});
                        }
                        console.debug(".........PIC is exist: ",albpic)
                    }
                }

                IControls.AnimationText_FontRegular{
                    id:songnameTx;
                    width: 300;
                    height:70;
                    anchors.top: parent.top;
                    anchors.topMargin: 40;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    color: '#00000000';
                    text: isShowMusicWidget ? musictitle : (qsTr('音乐') + ctranslator.monitor)
                    font.pixelSize: 54;
                    textColor: '#FFFFFF';
                    textCenter:true
                    opacity: isShowMusicWidget && playState === Constant._USB_MUSIC_PLAYING ? 1.0 : 0.5
                }

                IControls.AnimationText_FontRegular{
                    id:artistTx;
                    width: 300;
                    height:70;
                    anchors.top:songnameTx.bottom;
                    anchors.topMargin: 20;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: isShowMusicWidget ? artist : ' ';
                    font.pixelSize: 36;
                    color: '#00000000';
                    textColor: '#FFFFFF';
                    textCenter:true
                    opacity: isShowMusicWidget && playState === Constant._USB_MUSIC_PLAYING ? 1.0 : 0.5
                }

                Connections {
                    target: root

                    onAlbpicChanged: {
                        JSLibs.setTimeout(function() {
                            albumIm.source = albpic
                            console.debug("HomePage albpic : " + albpic);
                        }, 200)
                    }
                }

                Image{
                    id: albumIm;
                    width:275;
                    height:254;
                    anchors.top:artistTx.bottom;
                    anchors.bottom:curtimeItem.top
                    anchors.topMargin: 10;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    opacity: (isShowMusicWidget && playState === Constant._USB_MUSIC_PLAYING) ? 1.0 : 0.5
                    fillMode: Image.PreserveAspectFit
                    source: albpic
                    onStatusChanged: {
                        if (status !== Image.Ready) {
                            source = 'qrc:/resources-home/home_music_ption.png'
                            console.debug("..........status:",status)
                            console.debug("..........albpic:",albpic)
                        }
                    }
                }

                Item{
                    id:curtimeItem;
                    width: 300;
                    height: 30;
                    anchors.bottom:progressBar.top;
                    anchors.bottomMargin: 16;
                    anchors.left: progressBar.left;

                    IControls.NonAnimationText_FontLight{
                        id:curtimeTx;
                        anchors.left: parent.left;
                        font.pixelSize: 24;
                        text: isShowMusicWidget ? JSLibs.formatTime(position) : '00:00'
                        color:'#FFFFFF';
                        opacity: isShowMusicWidget && playState === Constant._USB_MUSIC_PLAYING ? 1.0 : 0.5
                    }
                    IControls.NonAnimationText_FontLight{
                        anchors.left: curtimeTx.right;
                        anchors.leftMargin: 136;
                        font.pixelSize: 24;
                        text: isShowMusicWidget ? JSLibs.formatTime(duration) : '00:00';
                        color:'#FFFFFF';
                        opacity: isShowMusicWidget && playState === Constant._USB_MUSIC_PLAYING ? 1.0 : 0.5
                    }
                }

                UControls.Slider{
                    id:progressBar
                    width: 250;
                    height :10;
                    enabled: false;
                    maximumValue: duration;
                    value: isShowMusicWidget ? position : 0;
                    anchors{
                        bottom:musicplay_button.top
                        bottomMargin: 31
                        horizontalCenter: parent.horizontalCenter;
                    }
                    opacity: isShowMusicWidget && playState === Constant._USB_MUSIC_PLAYING ? 1.0 : 0.5
                    style: SliderStyle{
                        groove: Rectangle {
                            id: bg
                            implicitWidth: 868
                            implicitHeight: 10
                            color: "#28282a"
                            Rectangle {
                                height: 10
                                width: styleData.handlePosition
                                color: ifModel.sliderColor
                            }
                        }
                        handle: Rectangle{
                            width:0
                            height: 0
                        }
                    }
                }

                Row{
                    id:musicplay_button
                    anchors.bottom: parent.bottom;
                    clip: true;
                    Repeater{
                        model: [{
                                icon: 'qrc:/resources-home/home_Btn_Last_nml.png',
                            },
                            {
                                icon: 'qrc:/resources-home/home_Btn_stop_nml.png'
                            },
                            {
                                icon: 'qrc:/resources-home/home_Btn_Next_nml.png',
                            },
                        ]

                        Item{
                            width: 115;
                            height:120;
                            IControls.RoundLabButtonA{
                                id:mediaBtn
                                themeColor: system.interfacemodel
                                width: 110;
                                height:115;
                                disabled: isShowMusicWidget ? false : true;
                                Image {
                                    id:icon;
                                    anchors.centerIn: parent;
                                    source: {
                                        if (index === 1) {
                                            if (application.appWindow.modeConfigs['usb'].guard()) {
                                                if (playState === Constant._USB_MUSIC_PLAYING) {
                                                    'qrc:/resources-home/home_Btn_play_nml.png'
                                                }
                                                else {
                                                    'qrc:/resources-home/home_Btn_stop_nml.png'
                                                }
                                            }
                                            else modelData.icon
                                        }
                                        else modelData.icon
                                    }
                                    opacity: isShowMusicWidget ? 1.0 : 0.5
                                }

                                onClicked: {
                                    if(!timersoureceid.isClick){
                                        return
                                    }
                                    timersoureceid.isClick = false
                                    timersoureceid.restart()
                                    if(isShowMusicWidget && HmiCommon.source !== HmiCommon.SourceTTS){
                                        if (HmiCommon.source !== HmiCommon.SourceUSBMP3) {
                                            HmiCommon.requireSourceOn(HmiCommon.SourceUSBMP3)
                                        }
                                        if(index === 0){
                                            musicctl.previous();
                                        } else if(index === 1){
                                            /*1：STOP 2：READY 3：PAUSE 4：PLAYING 5：MEDIAEND*/
                                            if(playState === Constant._USB_MUSIC_PLAYING){
                                                musicctl.pause()
                                            } else {
                                                musicctl.resume()
                                            }
                                        } else if(index === 2) {
                                            musicctl.next();
                                        }
                                    }
                                }
                            }

                            Rectangle{
                                width: 110;
                                height: 5;
                                anchors.top:mediaBtn.bottom;
                                gradient: Gradient{
                                    GradientStop { position: 0.0; color: ifModel.btnColor[0] }
                                    GradientStop { position: 1.0; color: ifModel.btnColor[1] }
                                }
                            }

                            Image {
                                width: 3;
                                anchors.left: mediaBtn.right;
                                anchors.leftMargin: 0
                                source: "qrc:/resources-home/home_Icon_Btn_Bg3.png"
                            }
                        }
                    }
                }
            }

            Item{
                id:radioItem;
                width: 346;
                height: 628;
                anchors.left: musicIt.right;

                Image {
                    z: -1;
                    anchors.fill: parent;
                    source: ifModel.radioBg
                }

                IControls.MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        application.multiApplications.changeApplication('radio');
                    }
                }

                IControls.NonAnimationText_FontLight{
                    id:bandTx;
                    z:999
                    anchors.top: parent.top;
                    anchors.topMargin: 39;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: band2string(band);
                    font.pixelSize: 32;
                    color: '#FFFFFF'
                    opacity: openState? 1.0 : 0.5
                }

                IControls.NonAnimationText_FontRegular{
                    id: frequencyTx
                    z: 999
                    anchors.top: bandTx.bottom;
                    //            anchors.topMargin: 18;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: current_freq == 0 ? (isFM ? 87.5:531):(isFM ? (current_freq/100).toFixed(1) : current_freq)
                    font.pixelSize: 68;
                    color: '#FFFFFF'
                    opacity: openState? 1.0 : 0.5
                }

                IControls.NonAnimationText_FontLight{
                    id: unitTx
                    z: 999
                    anchors.top: frequencyTx.bottom;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: band2unit(band);
                    font.pixelSize: 32;
                    color: '#FFFFFF'
                    opacity: openState? 1.0 : 0.5
                }

                UControls.Slider {
                    id: slidersRadio
                    z: 999;
                    enabled: false
                    anchors.top: unitTx.bottom;
                    anchors.topMargin: 180;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    minimumValue: isFM ? 87.5 : 531
                    maximumValue: isFM ? 108 : 1629
                    value: isFM ? (current_freq/100):current_freq
                    stepSize: 0.1
                    /*<add by chengzhi 20161124 begin*/
                    onPressedChanged: {
                        // 只供显示
                    }
                    /*add by chengzhi 20161124 end>*/

                    style: SliderStyle{
                        groove: BorderImage{
                            source: "qrc:/resources-home/home_Slider_radio_Bg.png"
                            opacity: openState? 1.0 : 0.5
                            IControls.NonAnimationText_FontRegular {
                                id: left
                                anchors.left: parent.left
                                anchors.leftMargin: -10;
                                anchors.top: parent.bottom
                                anchors.topMargin: 18
                                text: slidersRadio.minimumValue //isFM ? 87.5 : 522
                                font.pixelSize: 20
                                color: '#FFFFFF'
                                opacity: openState? 1.0 : 0.5
                            }
                            IControls.NonAnimationText_FontRegular {
                                id: right
                                anchors.right: parent.right
                                anchors.rightMargin: -10;
                                anchors.top: parent.bottom
                                anchors.topMargin: 18
                                text: slidersRadio.maximumValue // "108"
                                font.pixelSize: 20
                                color: '#FFFFFF'
                                opacity: openState? 1.0 : 0.5
                            }
                        }

                        handle: Rectangle {
                            anchors.centerIn: parent
                            opacity: openState? 1.0 : 0.5
                            color: ifModel.sliderColor
                            implicitWidth: 5
                            implicitHeight: 40
                        }
                    }
                }

                Row{
                    anchors.bottom: parent.bottom;
                    anchors.left: parent.left;
                    anchors.leftMargin: 2;
                    z: 999;
                    clip: true;
                    Repeater{
                        model: [{
                                icon: 'qrc:/resources-home/home_Btn_Last_nml.png'
                            },
                            {
                                icon: openState ? 'qrc:/resources-home/home_Btn_play_nml.png' :
                                                  'qrc:/resources-home/home_Btn_stop_nml.png'
                            },
                            {
                                icon: 'qrc:/resources-home/home_Btn_Next_nml.png'
                            },
                        ]

                        Item{
                            width: 115;
                            height:120;
                            IControls.RoundLabButtonA{
                                id:radioBtn
                                themeColor: system.interfacemodel
                                width: 110;
                                height:115;
                                pressingColor: {
                                    var color;

                                    if (openState) {
                                        color = themeColor == 0 ?"#105769":(themeColor == 1? "#ff2200":"#986142");
                                    }
                                    else{
                                        if(index != 1){
                                            color = '#3E3F41'
                                        }
                                        else{
                                            color = themeColor == 0 ?"#105769":(themeColor == 1? "#ff2200":"#986142");
                                        }
                                    }

                                    color;
                                }

                                Image {
                                    id:radioicon;
                                    anchors.centerIn: parent;
                                    source: modelData.icon
                                    opacity: index != 1 ? (openState? 1.0 : 0.5) : 1.0
                                }

                                onClicked: {
                                    if(!timersoureceid.isClick){
                                        return
                                    }
                                    timersoureceid.isClick = false
                                    timersoureceid.restart()
                                    if(index === 0){
                                        /*<"change radio widge left button"   chengzhi/1608003    2016/11/03  begin*/
                                        if (openState) {
                                            if (radioState === 2) {
                                                radio.radioSeekDown(0)
                                            }
                                            else{
                                                radio.radioSeekDown(1)
                                            }
                                        }
                                        /*"change radio widge left button"   chengzhi/1608003    2016/11/03  end>*/
                                    } else if(index === 1){
                                        if (HmiCommon.source !== HmiCommon.SourceRadio) {
                                            HmiCommon.requireSourceOn(HmiCommon.SourceRadio)
                                        }
                                        if (openState) {
                                            radio.radioClose();
                                        } else {
                                            radio.radioOpen();
                                        }
                                    } else if(index === 2){
                                        /*<"change radio widge left button"   chengzhi/1608003    2016/11/03  begin*/
                                        if (openState) {
                                            if (radioState === 1) {
                                                radio.radioSeekUp(0)
                                            }
                                            else{
                                                radio.radioSeekUp(1)
                                            }
                                        }
                                        /*"change radio widge left button"   chengzhi/1608003    2016/11/03  end>*/
                                    }
                                }
                            }

                            Rectangle{
                                width: 110;
                                height: 5;
                                anchors.top:radioBtn.bottom;
                                gradient: Gradient{
                                    GradientStop { position: 0.0; color: system.interfacemodel === 0 ? "#267284" : (system.interfacemodel === 1 ? "#9B1702" : "#ab7c48" ) }
                                    GradientStop { position: 1.0; color: system.interfacemodel === 0 ? "#0E5263" : (system.interfacemodel === 1 ? "#2D0D07" : "#855033" ) }
                                }
                            }

                            Image {
                                width: 3;
                                anchors.left: radioBtn.right;
                                anchors.leftMargin: 0
                                source: "qrc:/resources-home/home_Icon_Btn_Bg3.png"
                            }
                        }
                    }
                }
            }

            Component.onCompleted: {
                JSLibs.async.nextTick(function(){
                    calendar.active = true
                })
            }

            Loader {
                id: calendar
                active: false
                width: 346
                height: 628
                anchors.left: radioItem.right
                sourceComponent: calendarCom;
            }

            Component {
                id :calendarCom
                Item {
                    id: calendarItem
                    anchors.fill: parent
                    IControls.MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            application.multiApplications.changeApplication('calendar');
                        }
                    }
                    IControls.MiniCalendar{
                        id: miniCalender
                        selectedDay: today
                    }
                }
            }
        }
    }

    Component{
        id:selectcom;
        Item{
            width: 346*3;
            height: 628;
            Grid {
                anchors.left:parent.left
                anchors.top:parent.top
                rows: 2
                columns: 5
                rowSpacing: 8
                columnSpacing: 7
                clip:false

                Repeater{
                    model: selectinfo;

                    IControls.BgImageButtonInstance {
                        id:radioBtn
                        clip:false
                        labelText: qsTr(modelData.tabTitle) + ctranslator.monitor
                        bgSource: ((system.interfacemodel === 0) ? modelData.iconImageBlue : ((system.interfacemodel === 1) ? modelData.iconImageOrange : modelData.iconImageGold))
                        themeColor: system.interfacemodel

                        onClicked: {
                            selectindex = index;
                            swapinfo(menuindex,selectindex);
                            switchLoader.sourceComponent = menucom;
                            //Add by zhouyongwu 2016-10-13: Update repeater model
                            menure.model = menuinfo
                            /* BEGIN by Xiong wei, 2016.12.27
                            *  Add longpress states
                           */
                            firstIndex = -1
                            isBackFlag = false
                            //End by xiongwei 2016.12.27
                            console.debug('',menuinfo[index].tabTitle)
                        }
                    }
                }

            }
        }
    }


    function band2string(band){
        switch(band){
        case 0: return 'FM1';
        case 1: return 'FM2';
        case 2: return 'FM3';
        case 3: return 'FM4';
        case 4: return 'AM1';
        case 5: return 'AM2';
        case 6: return 'AM3';
        }
    }

    function band2unit(band){
        switch(band){
        case 0:
        case 1:
        case 2:
        case 3: return 'MHz';
        case 4:
        case 5:
        case 6: return 'KHz';
        }
    }

    function swapinfo(menuindex,selectindex) {
        var tmp = menuinfo[menuindex];
        menuinfo[menuindex] = selectinfo[selectindex];
        selectinfo[selectindex] = tmp;
        console.debug('menuinfo['+ menuindex + ']:' , menuinfo[menuindex].appid);
        saveinfo()
    }

    function saveinfo() {
        HSStore.setData('menuinfo', root.menuinfo)
        HSStore.setData('selectinfo', root.selectinfo)
    }

    function requireinfo() {
        if (HSStore.datas.menuinfo === undefined || HSStore.datas.selectinfo === undefined) {
            root.menuinfo = root.__menuinfo.concat()
            root.selectinfo = root.__selectinfo.concat()
        }
        else {
            root.menuinfo = HSStore.datas.menuinfo
            root.selectinfo = HSStore.datas.selectinfo
        }
        menure.model = root.menuinfo
    }
}
