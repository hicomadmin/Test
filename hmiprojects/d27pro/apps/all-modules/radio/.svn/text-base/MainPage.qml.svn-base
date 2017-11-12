import QtQuick 2.3
import QtQuick.Controls 1.2
import TheXRadio 1.0
import TheXSettings 1.0
import TheXPresenter 1.0

import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls

ICore.Page {
    id: root
    property bool isFM: true
    property RadioCtl radio: HSPluginsManager.get('radio')
    property SystemCtl system: HSPluginsManager.get('system')
    property bool openState
    property bool stereo
    property int band
    property var current_freq
    property var preList /*: ListModel{id: preModel}*/
    property real presetID
    property real radioState
    property bool isOpen: true
    property var apsDialog
    property real freqValue
    property int interfacemodel
    property int radioListPressLock : 0
    property int radioListCurItemIdx : 0
    property int freqChangByItemClick : 0


    property url pressLeft: interfacemodel == 0 ? "qrc:/resources-radio/left_tiny_press.png"
                                                :(interfacemodel == 1 ? "qrc:/resources-radio/left_tiny_press.2.png"
                                                                     : "qrc:/resources-radio/left_tiny_press.3.png")
    property url pressRight:interfacemodel == 0 ? "qrc:/resources-radio/right_tiny_press.png"
                                                :(interfacemodel == 1 ? "qrc:/resources-radio/right_tiny_press.2.png"
                                                                     : "qrc:/resources-radio/right_tiny_press.3.png")

    onRadioChanged: {
        console.debug("[CZ-Radio] - onRadioChanged########1")
        /* BEGIN by Zhang Yi, 2016.11.14
         * The display of preset list should keep one decimal place in FM.
        */
        preList = Qt.binding(function () {
            var list = []

            for (var i = 0; i < 6; ++i){
                if(i < radio.presetList.length){
                    list[i] = radio.presetList[i]
                }
                else{
                    list[i] = 0
                }
            }

            return list
        })
        /* END - by Zhang Yi, 2016.11.14 */
        band = Qt.binding(function (){return radio.radioBand})
        presetID = Qt.binding(function (){return radio.presetID})               /*当前预置台索引号*/
        current_freq = Qt.binding(function (){return radio.frequency})
        openState = Qt.binding(function (){return radio.openState})             /*收音打开/关闭状态*/
        radioState = Qt.binding(function (){return radio.radioState})           /*收音状态,value: {0：正常;1:SEEKUP;2:SEEKDOWN;3:SCAN;4:APS(自动搜台)}*/
        stereo = Qt.binding(function (){return radio.stereo})
        if (application.lastAudioSource !== HmiCommon.SourceRadio) {
            radio.radioOpen()
        }
        radio.getPresetList(band)
    }

    onOpenStateChanged: {
        console.debug("[CZ-Radio] - onOpenStateChanged: openState = ",openState)
    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    onBandChanged: {

        console.debug("!!!!!!!!!!!!!!!!!!onBandChanged:", band);
        if((band == 0) || (band == 1) || (band == 2)){
            isFM = true
            combox.selectedIndex = band
        }
        else if((band == 4) || (band == 5)){
            isFM = false
            combox.selectedIndex = band - 1
        }

        radioListPressLock = 0;
    }

    onPresetIDChanged: {
        console.debug("[CZ-Radio] onPresetIDChanged: presetID = ",presetID)
//        if(isFM){
//            listmodel.setProperty(presetID-1,"title",(current_freq/100).toFixed(1).toString());
//        }
//        else{
//            listmodel.setProperty(presetID-1,"title",current_freq.toString());
//        }
        scan.isAllEmpty = false
    }

    function updatePreList() {
        /* BEGIN by Zhang Yi, 2016.11.14
         * The display of preset list should keep one decimal place in FM.
        */
        var i
        var radioPreList = []

        console.debug("[CZ-Radio] onRadioPreListChanged:  presetID =", presetID, "band =", isFM)

        if (preList[0] === undefined) return

        for (i = radio.presetList.length; i < 6; ++i) {
            radioPreList[i] = "--"
        }

        for (i = 0; i < radio.presetList.length; ++i) {
            if (isFM) {
                radioPreList[i] = preList[i].toFixed(1).toString()
                var freq = parseFloat(radioPreList[i]) / 100.0
                radioPreList[i] = (freq <= 0.01) ? "--" : freq.toFixed(1).toString()
            }
            else {
                radioPreList[i] = preList[i].toFixed(0).toString()
                if (radioPreList[i] === "0") radioPreList[i] = "--"
            }
        }

        listmodel.clear()
        for(i = 0; i < 6; ++i) {
            console.debug("[CZ-Radio]====", radioPreList[i])
            listmodel.append({"title": radioPreList[i]})
        }
        /* END - by Zhang Yi, 2016.11.14 */
        combox.comboboxRecState = ""
    }

    onPreListChanged: {
        updatePreList()
    }

    onStereoChanged: {
        stereoTxt.visible = stereo
    }

    onCurrent_freqChanged: {
        console.debug("[CZ-Radio] onCurrent_freqChanged:  current freq = ",current_freq)
        //radioSlider.value = isFM ? (current_freq/100):current_freq
        freqValue = isFM ? (current_freq/100):current_freq
    }

    onFreqValueChanged: {
        if(!freqChangByItemClick){
            radioListPressLock = 0;
        }
        freqChangByItemClick = 0;
    }

    onRadioStateChanged: {
        if(radioState != 4)
            dialogClose()
    }

    Image {
        id: bg
        source: interfacemodel == 0 ? "qrc:/resources-radio/radio-bg.png"
                                    :(interfacemodel == 1 ? "qrc:/resources-radio/radio-bg-orange.png"
                                                          :"qrc:/resources-radio/radio-bg-gold.png")
    }

    /*
     *ComboBoxButton: "FM1","FM2","FM3","AM1","AM2","--","--"
    */
    IControls.ComboBoxButton{
        id: combox
        z: 1
        comboboxRecWidth: 241
        comboboxRecHeight: 90
        dropdownRecWid: 241
        listViewHeight: 90
        themeColor: interfacemodel
        items: ["FM1","FM2","FM3","AM1","AM2","--","--"]
        enabled: openState ? true : false

        onComboClicked: {
        }

        onSelectedItemChanged: {
            console.debug("@@@@@@ combox.onSelectedItemChanged", selectedItem)
            updatePreList()
        }

        onSelectedIndexChanged: {
            if(selectedIndex < 5){ // judge valid band
                selectedItem = items[selectedIndex]
                if(selectedIndex < 3){ // FM
                    if(radioState != 4){   // 自动存台时调用此方法会有问题
                        radio.setFrequency(selectedIndex,0)
                    }
                    radio.getPresetList(selectedIndex)
                }
                else{ // AM band is 4, 5, index is 3, 4
                    if(radioState != 4){   // 自动存台时调用此方法会有问题
                        radio.setFrequency(selectedIndex + 1,0)
                    }
                    radio.getPresetList(selectedIndex + 1)
                }
            }
        }
    }

    /*
     *ListView: radioList
    */
    ListView{
        id: radioList
        y: 90
        width: 241
        height: 540
        delegate: item
        model:listmodel
        ListModel{
            id:listmodel        //动态加载
//            ListElement {
//                title: '--'
//            }
        }
        boundsBehavior: Flickable.StopAtBounds
    }

    /*
     *Delegate of ListView(radioList)
    */
    Component{
        id: item
        Item{
            width: 241
            height: 90
            UControls.ColorButton{
                id: itemFreq
                width: 241
                height: 86
                normalColor: {
                    var retValue;

                    if(openState){
                        if(radioListPressLock){
                            if(radioListCurItemIdx == index){
                                retValue = (interfacemodel == 0 ? '#105769' : (interfacemodel == 1 ? '#ff2200' : '#986142'));
                            }
                            else{
                                retValue = '#181a1c';
                            }
                        }
                        else{
                            if(Number(modelData) == freqValue)
                            {
                                retValue = (interfacemodel == 0 ? '#105769' : (interfacemodel == 1 ? '#ff2200' : '#986142'));
                            }
                            else{
                                retValue = '#181a1c';
                            }
                        }
                    }
                    else{
                        retValue = '#1a1c1d';
                    }

                    retValue;
                }

                pressingColor: interfacemodel == 0 ?'#105769' : (interfacemodel == 1?'#ff2200':'#986142')
                enabled: openState ? true : false
                onClicked: {
                    if(title === "--"){
                        application.createTipDialogAsync('qrc:/Instances/Controls/DialogTip.qml',
                                                         {themeColor: interfacemodel,contentWidth: 692,contentHeight: 180,
                                                          pixelSize: 34,text: qsTr("无电台，您可长按该区域将当前电台存储下来")})
                    }
                    else{
                        radio.recallPreset(0,index + 1)         /*radio.recallPreset: 播放预置台*/
                        radioListPressLock = 1;
                        radioListCurItemIdx = index;
                        if(Number(listmodel.get(index).title) != freqValue){ // 只有当频率发生改变时才能设置freqChangByItemClick
                            freqChangByItemClick = 1;
                        }
                    }
                }
                onLongPressed: {
                    radio.savePreset(index + 1);
                    radioListPressLock = 1;
                    radioListCurItemIdx = index;
                    if(Number(listmodel.get(index).title) != freqValue){
                        radio.getPresetList(band)  // update preset list
                    }
                }
            }
            IControls.NonAnimationText_FontRegular{
                anchors.centerIn: itemFreq
                font.pixelSize: 38
                color: openState ?  ('#ffffff') :('#313236')
                text: title
            }
            Image {
                id: line
                anchors.top: itemFreq.bottom
                source: "qrc:/resources/list_line_left 1.png"
            }
        }
    }

    /*
     *Slider: RadioSlider
    */
    IControls.SlidersRadio{
        id: radioSlider
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 180
        anchors.left: parent.left
        anchors.leftMargin: 291
        minimumValue: isFM ? 87.5 : 531
        maximumValue: isFM ? 108.0 : 1629
        stepSize: isFM ? 0.1 : 9
        value: isFM ? (current_freq / 100) : current_freq
        isToFixed: isFM
        themeColor: interfacemodel
        enabled: openState ? true : false

        onPressedChanged: {
            if(isFM)
                radio.setFrequency(band,value*100)
            else
                radio.setFrequency(band,value)
        }

        IControls.NonAnimationText_FontRegular {
            id: leftTxt
            z: -1
            anchors.left: parent.left
            anchors.bottom: parent.top
            anchors.bottomMargin: 5
            text: isFM ? "87.5":"531"
            font.pixelSize: 35
            color: "#ffffff"
        }
        IControls.NonAnimationText_FontRegular {
            id: rightTxt
            z: -1
            anchors.right: parent.right
            anchors.bottom: parent.top
            anchors.bottomMargin: 5
            text: isFM ? "108":"1629"
            font.pixelSize: 35
            color: "#ffffff"
        }
    }

    /*
     *Button: SEEK-
    */
    IControls.IconButton_Normal{
        id: seekLeft
        height: 137
        width: 343
        anchors.left: parent.left
        anchors.leftMargin: 241
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        source: openState ? "qrc:/resources/radio_ICN_SEEK-.png"
                          : "qrc:/resources/radio_ICN_gray_SEEK-.png"
        themeColor: interfacemodel
        enabled: openState ? true : false
        onClicked: {
            if(radioState == 2)
                radio.radioSeekDown(0)
            else
                radio.radioSeekDown(1)
        }

        UControls.GradientBar{
            anchors.top: parent.bottom
            anchors.left: parent.left
            gradient_width: 343
            underBtnGradient:Gradient{
                GradientStop{
                    position: 0.0
                    color:"#a2a4a3"
                }
                GradientStop{
                    position: 1.0
                    color: "#828585"
                }
            }
        }
    }

    /*
     *Button: Start/Pause
    */
    IControls.IconButton_Normal{
        id: pause
        height: 137
        width: 343
        anchors.left: parent.left
        anchors.leftMargin: 241+343+4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        themeColor: interfacemodel
        source: openState ? "qrc:/resource-usb/Media_Icon_Stop_nml.png"
                          : "qrc:/resource-usb/Media_Icon_Play_nml.png"
        onClicked: {
            if(openState){
                radio.radioClose()
            }
            else
                radio.radioOpen()
        }

        UControls.GradientBar{
            anchors.top: parent.bottom
            anchors.left: parent.left
            gradient_width: 343
            underBtnGradient:Gradient{
                GradientStop{
                    position: 0.0
                    color:"#a2a4a3"
                }
                GradientStop{
                    position: 1.0
                    color: "#828585"
                }
            }
        }
    }

    /*
     *Button: SEEK+
    */
    IControls.IconButton_Normal{
        id: seekRight
        height: 137
        width: 343
        anchors.left: parent.left
        anchors.leftMargin: 241+343+343+4+4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        source: openState ? "qrc:/resources/radio_ICN_SEEK+.png"
                          : "qrc:/resources/radio_ICN_gray_SEEK+.png"
        themeColor: interfacemodel
        enabled: openState ? true : false
        onClicked: {
            if(radioState == 1)
                radio.radioSeekUp(0)
            else
                radio.radioSeekUp(1)
        }
        UControls.GradientBar{
            anchors.top: parent.bottom
            anchors.left: parent.left
            gradient_width: 343
            underBtnGradient:Gradient{
                GradientStop{
                    position: 0.0
                    color:"#a2a4a3"
                }
                GradientStop{
                    position: 1.0
                    color: "#828585"
                }
            }
        }

    }

    /*
     *Text: 87.5/531
    */
    IControls.NonAnimationText_FontRegular{
        id: frequency
        height: 120
        width: 240
        anchors.top:parent.top
        anchors.topMargin: 83
        anchors.left: parent.left
        anchors.leftMargin: 580
        font.pixelSize: 124
        color: "#ffffff"
        text: current_freq == 0 ? (isFM ? 87.5:531)
                                : (isFM ? (current_freq/100).toFixed(1) : current_freq)

    }

    /*
     *Text: MHZ/KHz
    */
    IControls.NonAnimationText_FontRegular{
        id: unit
        anchors.top:frequency.bottom
        anchors.topMargin: 61
        //        anchors.horizontalCenter: frequency.horizontalCenter
        anchors.left: frequency.left
        anchors.leftMargin: 100
        font.pixelSize: 38
        color: "#ffffff"
        text: isFM ? qsTr("MHz"):qsTr("KHz")
    }

    /*
     *Image: 左微调
    */
    Image {
        id: leftArrow
        source: isPressed ? pressLeft : (openState ? "qrc:/resources-radio/radio_left_tinymove.png"
                                                    : "qrc:/resources-radio/radio_left_tinymove_disable.png")
        anchors.right: unit.left
        anchors.rightMargin: 70
        anchors.top: frequency.bottom
        anchors.topMargin: 54
        enabled: openState ? true : false
        property bool isPressed: false
        IControls.MouseArea{
            anchors.fill: parent
            /*<Bug #118     chengzhi/1608003    2016/11/04  begin*/
            onPressed: leftArrow.isPressed = true
            onReleased: leftArrow.isPressed = false

            /*Bug #118     chengzhi/1608003    2016/11/04  end>*/
            onClicked: {
                /*<Bug #128     chengzhi/1608003    20161025    begin*/
                if(radioState === 1)
                {
                    radio.radioSeekUp(0);
                }
                else if(radioState === 2)
                {
                    radio.radioSeekDown(0);
                }
                else if(radioState === 3)
                {
                    radio.radioScan(0)
                }
                isFM ? radio.setTuneDown(2):radio.setTuneDown(1)
                /*Bug #128     chengzhi/1608003    20161025    end>*/
            }
        }
    }

    /*
     *Image: 右微调
    */
    Image {
        id: rightArrow
        source: isPressed ? pressRight : (openState ? "qrc:/resources-radio/radio_right_tinymove.png"
                                                    : "qrc:/resources-radio/radio_right_tinymove_disable.png")
        anchors.left: unit.right
        anchors.leftMargin: 67
        anchors.top: frequency.bottom
        anchors.topMargin: 54
        enabled: openState ? true : false
        property bool isPressed: false
        IControls.MouseArea{
            anchors.fill: parent
            /*<Bug #118     chengzhi/1608003    2016/11/04  begin*/
            onPressed: rightArrow.isPressed = true
            onReleased: rightArrow.isPressed = false

            /*Bug #118     chengzhi/1608003    2016/11/04  end>*/
            onClicked: {
                /*<Bug #128     chengzhi/1608003    20161025    begin*/
                if(radioState === 1)
                {
                    radio.radioSeekUp(0);
                }
                else if(radioState === 2)
                {
                    radio.radioSeekDown(0);
                }
                else if(radioState === 3)
                {
                    radio.radioScan(0)
                }
                isFM ? radio.setTuneUp(2):radio.setTuneUp(1)
                /*Bug #128     chengzhi/1608003    20161025    end>*/
            }
        }
    }

    /*
     *Button: Station Scan (电台浏览)
    */
    UControls.ColorButton {
        id: scan
        width: 210
        height: 78
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 40

        property bool isAllEmpty: (radio.presetList.length === 0)
        /*<add new requirement "radio_2.3.9.3"      chengzhi/1608003    2016/10/31  begin*/
//        normalColor: (isAllEmpty | !openState) ? ('#2b3033') : ('#313236')
        normalColor: openState ? '#1a1c1d' : '#1a1c1d'
        enabled: (isAllEmpty | !openState) ? false : true
        /*add new requirement "radio_2.3.9.3"      chengzhi/1608003    2016/10/31  end>*/
        pressingColor: interfacemodel == 0?'#105769':(interfacemodel == 1?'#ff2200':'#986142')
        radius: 4
        onClicked: {
            if(radioState == 3)
                radio.radioScan(0)
            else
                radio.radioScan(1)
        }

        IControls.NonAnimationText_FontRegular{
            id: scanTxt
            anchors.centerIn: parent
            font.pixelSize: 38
            /*<add new requirement "radio_2.3.9.3"      chengzhi/1608003    2016/10/31  begin*/
            color: (scan.isAllEmpty | !openState) ? ('#313236') : ('#ffffff')
            /*add new requirement "radio_2.3.9.3"      chengzhi/1608003    2016/10/31  end>*/
            text: qsTr("电台浏览")
        }
    }

    /*
     *Button: Auto Store Station (自动存台)
    */
    UControls.ColorButton{
        id: auto
        width: 210
        height: 78
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.top: scan.bottom
        anchors.topMargin: 13
//        normalColor: openState ? ('#313236') : ('#2b3033')
        normalColor: '#1a1c1d'
        pressingColor: interfacemodel == 0?'#105769':(interfacemodel == 1?'#ff2200':'#986142')
        radius: 4
        enabled: openState ? true : false
        onClicked: {
            application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogCancelTip.qml',
                                                 {themeColor: interfacemodel,text:qsTr('正在搜索并保存电台......'),
                                                  autoCloseTimeout:30000},dialogCancelled);
            radio.autoSaveStation(6,1)
            radioListPressLock = 0; // 自动存台直接点击取消，频率未变化

        }
        IControls.NonAnimationText_FontRegular{
            anchors.centerIn: parent
            font.pixelSize: 38
            color: openState ? ('#ffffff') :('#313236')
            text: qsTr("自动存台")
        }
    }

    /*
     *Text: Stereo
    */
    IControls.NonAnimationText_FontRegular {
        id: stereoTxt
        visible: stereo
        anchors.left: radioList.right
        anchors.leftMargin: 69
        anchors.top: parent.top
        anchors.topMargin: 40
        text: qsTr("立体声")
        font.pixelSize: 24
        color: "#ffffff"
    }

    /*
     *Function: dialogCancelled()
     */
    function dialogCancelled(dialog){
        apsDialog = dialog;
        dialog.canceled.connect(function canceled(){
//            radio.autoSaveStation(0,false)
//            console.debug("cancell clicked");
        });
        dialog.closed.connect(function close(){
            radio.autoSaveStation(0,false)
            radio.setFrequency(0,0)     // 自动存台后，自动跳到FM1第一个频道
            radio.getPresetList(0)
            console.debug("Cancelled dialog close");
        });
    }

    onItemHiden: {
//        console.debug("MainPage onItemHiden apsDialog:" + apsDialog)
        dialogClose()
    }

    function dialogClose() {
//        console.debug("MainPage dialogClose apsDialog:" + apsDialog)
        if(apsDialog) {
            apsDialog.close()
        }
    }

    onItemShown: {
        //application.itemHiden.connect(dialogClose)
    }
}
