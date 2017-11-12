import QtQuick 2.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls

import TheXSettings 1.0
import Apps 1.0

HSTab {
    id: root

    property bool isCopy: true
    property string currentLanguage: (language == 0) ? "中文" : "English"
    property bool isAM

    property SystemCtl system: HSPluginsManager.get('system')
    property real year: system.year
    property real month: system.month
    property real day: system.day
    property real hour: system.hour
    property real minutes: system.minutes
    //property int second: 16
    property bool hours24state: system.hours24state
    property real brightness: system.brightness
    property real language: system.language
    property real brightValue
    property real brightLevel
    property string showHour
    property string showMinute
    property string showYear
    property string showMonth
    property string showDay
    property string showAM
    property string showTime
    property string showDate
    property int interfacemodel: system.interfacemodel

    /* BEGIN by Xiong wei, 2016.12.13
     * Press the Power button to remove the dialog
    */
    property var currentDialog

    onVisibleChanged: {
        console.log("[SettingCommon] onVisibleChanged visible ")
        if(currentDialog) {
            if (!visible) {
                currentDialog.close()
            }
        }

    }

    function commonDialog(dialog){
        currentDialog = dialog;
        console.debug("[SettingCommon] currentDialog[text]" , currentDialog['text']);
    }


    // End by xiongwei 2016.12.13

    Component.onCompleted: {
        system.getAllInfo()
        brightValue = brightness
        isAM = (hour >= 12) ? false:true
    }

    onBrightnessChanged: {
        getBrightLevel()
    }

    //    onIsAMChanged: {
    //        showAM = isAM ? "AM":"PM"
    //        if(hours24state){
    //            showTime = Qt.formatDateTime(new Date(),"hh:mm")
    //        }
    //        else{
    //            showTime = Qt.formatDateTime(new Date(),"hh:mm AP")
    //        }
    //    }

    onHourChanged: {
//        isAM = (hour >= 12)? false:true
//        if(hours24state){
//            showTime = Qt.formatDateTime(new Date(),"hh:mm")
//        }
//        else
//            showTime = Qt.formatDateTime(new Date(),"hh:mm AP")
        showTime = currentDateTime()
    }
    onMinutesChanged: {
//        if(hours24state){
//            showTime = Qt.formatDateTime(new Date(),"hh:mm")
//        }
//        else
//            showTime = Qt.formatDateTime(new Date(),"hh:mm AP")
        showTime = currentDateTime()
    }

    onHours24stateChanged: {
//        if(hours24state){
//            showTime = Qt.formatDateTime(new Date(),"hh:mm")
//        }
//        else
//            showTime = Qt.formatDateTime(new Date(),"hh:mm AP")
        showTime = currentDateTime()
    }

    function currentDateTime(){
        var wholeTime = Qt.formatDateTime(new Date(), "hh:mm")
        if (hours24state) {
            return wholeTime
        } else {
            if (wholeTime.substring(0,2) > 12) {
                isAM = false
                return (wholeTime.substring(0,2) - 12) + wholeTime.substring(2, 5) + " PM"
            } else if (wholeTime.substring(0,2) == 12) {
                isAM = false
                return wholeTime + "PM"
            } else if (wholeTime.substring(0,2) == 00){
                isAM = true
                return 12 + wholeTime.substring(2, 5) + " AM"
            } else {
                isAM = true
                return wholeTime + " AM"
            }
        }
    }

    function currentDate() {
        if (month < 10) {
            if (day < 10) {
                showDate = (year + "-" + "0" + month + "-"+ "0" + day)
            } else {
                showDate = (year + "-" + "0" + month + "-"+ day)
            }
        } else if(day < 10) {
            showDate = (year + "-" + month + "-"+ "0" + day)
        } else {
            showDate = (year + "-" + month + "-"+ day)
        }
        return showDate
    }

    Item {
        id: bg
        width: 1040
        height: 628

        ListView{
            id: setting
            width: 994
            height: 628
            model: ListModel{
                ListElement{caption:"日期";}
                ListElement{caption:"时间";}
                ListElement{caption:"使用24小时格式" }
                ListElement{caption:"屏幕亮度"; widLine: "1"}
                ListElement{caption:"主题"; widLine: "2"}
                ListElement{caption:"屏保待机"; widLine: "2"}
                ListElement{caption:"语言"; widLine: "2";}
            }
            section.property: "widLine"
            //        section.criteria: ViewSection.FullString
            section.delegate: wideLine
            delegate: item
            clip: true
            //        snapMode: ListView.SnapToItem
            boundsBehavior: Flickable.StopAtBounds
            cacheBuffer: 124*10
        }
        Component{
            id: item
            Item {
                id: name
                width: 1040
                height: 124
                Loader{
                    id: txt
                    active: index != 2 && index != 3
                    sourceComponent: Component{
                        IControls.ListItemDelegateF{
                            themeColor: interfacemodel
                            textL: qsTr(caption) + ctranslator.monitor
                            textR: {
                                if(index === 0){
                                    return currentDate()
                                }
                                else if(index === 1){
                                    return showTime
                                    //                                    return (hours24state ? qsTr(showHour + ":" + showMinute):qsTr(showHour + ":" + showMinute + " " + showAM))
                                }
                                else if(index === 6)
                                    return currentLanguage
                                else
                                    return ""
                            }
                            onClicked: {
                                if(index == 1){
                                    if(hours24state){
                                        application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmTime24Hours.qml',{themeColor: interfacemodel,texttitle:qsTr('设置时间'),currentHour: hour, currentMinutes: minutes}, dialogConfirmSetTime24);
                                    }
                                    else {
                                        application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmTime.qml',{themeColor: interfacemodel,texttitle:qsTr('设置时间'), currentHour: hour, currentMinutes: minutes, isAM: isAM}, dialogConfirmSetTime12);
                                    }
                                }
                                if(index == 0){
                                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmDate.qml',{themeColor: interfacemodel,texttitle:qsTr('设置日期'),currentYear: year, currentMonth: month, currentDay: day}, dialogConfirmSetDate );
                                }
                                if(index == 4){
                                    application.changePage('settingTheme')
                                }
                                if(index == 5){
                                    application.changePage('lockScreenSelect')
                                }
                                if(index == 6){
                                    application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmLanguage.qml',{themeColor: interfacemodel,texttitle:qsTr('设置语言'),index:language},dialogLanguageselected)
                                }
                            }

                        }
                    }
                }
                Loader{
                    id: switches
                    active: index == 2
                    sourceComponent: Component{
                        IControls.ListItemDelegateH{
                            text: qsTr(caption) + ctranslator.monitor
                            themeColor: interfacemodel
                            checked: hours24state
                            onCheckedChanged: {
                                system.setHours24state(checked);
                                console.log("24Hours Switch = ",checked)
                            }
                        }
                    }
                }
                Loader{
                    id: slider
                    active: index == 3
                    sourceComponent: Component{
                        IControls.ListItemDelegateG{
                            text: qsTr(caption) + ctranslator.monitor
                            numFlag: false
                            soundFlag: false
                            value: brightLevel
                            maximunValue: 9
                            themeColor: interfacemodel
                            onValueChanged: {
                                switch(value) {
                                case 0: brightValue = 10
                                    break;
                                case 1: brightValue = 14
                                    break;
                                case 2: brightValue = 20
                                    break;
                                case 3: brightValue = 23
                                    break;
                                case 4: brightValue = 26
                                    break;
                                case 5: brightValue = 29
                                    break;
                                case 6: brightValue = 37
                                    break;
                                case 7: brightValue = 52
                                    break;
                                case 8: brightValue = 78
                                    break;
                                case 9: brightValue = 100
                                    break;
                                default:
                                    break;
                                }

                                if (brightValue != brightness)
                                    system.setBrightness(brightValue)
                            }
                        }
                    }
                }

            }
        }
        Component{
            id: wideLine
            Item{
                width: 1040
                height: 40
                Rectangle{
                    id: rect
                    width: 1040
                    height: 40
                    color: "#ffffff"
                    opacity: 0.06

                }
                Image {
                    id: bottomLine
                    anchors.bottom: rect.bottom
                    source: "qrc:/resources/list_lineA2.png"
                }
            }
        }
        IControls.Fixed_ScrollBar{
            anchors.right: parent.right
            anchors.rightMargin: 10
            view: setting
        }
    }
    //------------setdate--begin----------------------------
    function dialogConfirmSetDate(dialog){
        //modify begin by xiongwei 2016.12.13
        commonDialog(dialog)
        //modify end by xiongwei 2016.12.13
        dialog.confirmed_info.connect(function confirmed(info){
            console.debug("dialogConfirmselected cb confirmed:", info);

            //            year  = info[0];
            //            month = info[1];
            //            day   = info[2];
            system.setDate(info[0], info[1], info[2]);
        });
    }
    //------------setdat--end-------------------------------


    //------------settime24--begin--------------------------
    function dialogConfirmSetTime24(dialog){
        //modify begin by xiongwei 2016.12.13
        commonDialog(dialog)
        //modify end by xiongwei 2016.12.13
        dialog.confirmed_info.connect(function confirmed(info){
            console.debug("dialogConfirmselected cb confirmed:", info);
            system.setTime(info[0], info[1]);
        });
    }
    //------------settime2--end-----------------------------

    //------------settime12--begin--------------------------
    function dialogConfirmSetTime12(dialog){
        //modify begin by xiongwei 2016.12.13
        commonDialog(dialog)
        //modify end by xiongwei 2016.12.13
        dialog.confirmed_info.connect(function confirmed(info){
            console.debug("dialogConfirmselected cb confirmed:", info);

            var hourTemp    = info[0];
            var minutesTemp = info[1];
            var isAMTemp    = info[2];
            if(isAMTemp && hourTemp < 12)
                system.setTime(hourTemp, minutesTemp);
            else if(isAMTemp && hourTemp === 12)
                system.setTime(0, minutesTemp);
            else if((!isAMTemp) && hourTemp === 12)
                system.setTime(12, minutesTemp);
            else
                system.setTime(hourTemp + 12, minutesTemp);

        });
    }
    //------------settime1--end------------------------------

    //------------setLanguage--start-------------------------
    function dialogLanguageselected(dialog){
         //modify begin by xiongwei 2016.12.13
        commonDialog(dialog)
        //modify end by xiongwei 2016.12.13
        dialog.confirmed_info.connect(function confirmed(info){
            console.debug("dialogConfirmselected cb confirmed:", info);
            system.setLanguage(info)
        });
    }
    //------------setLanguage--end---------------------------

    //------------getBrightLevel--start----------------------
    function getBrightLevel(){
        switch(brightness){
        case 10: brightLevel = 0
            break;
        case 14: brightLevel = 1
            break;
        case 20: brightLevel = 2
            break;
        case 23: brightLevel = 3
            break;
        case 26: brightLevel = 4
            break;
        case 29: brightLevel = 5
            break;
        case 37: brightLevel = 6
            break;
        case 52: brightLevel = 7
            break;
        case 78: brightLevel = 8
            break;
        case 100: brightLevel = 9
            break;
        default:
            break;
        }
        console.log("getBrightness = ",brightness)
        console.log("getBrightLevel = ",brightLevel)
    }
    //------------getBrightLevel--end-----------------------
}

