import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import 'qrc:/UI/Controls' as UControls
import TheXSettings 1.0
import 'qrc:/Instances/Controls' as IControls
Style {
    id: calendarStyle
    readonly property Calendar control: __control

    property bool gridVisible: true

    property real __gridLineWidth: 1
    ////////////////////////////////////
    property real dayWidth: 45
    property real dayHeight: 42

    property real weekRowWidth: dayWidth*7
    /* Begin by Xiongwei, 2016.12.12
     * Modify the Date widget
     */
    property real years: HSPluginsManager.get('system').year
    property real month: HSPluginsManager.get('system').month - 1
    property real days: HSPluginsManager.get('system').day
    /* End by Xiongwei, 2016.12.12
     * Modify the Date widget
     */
    property int interfacemodel : HSPluginsManager.get('system').interfacemodel

    property real totalWidth:346
    property real totalHeight: 628
    property real gridWidth: dayWidth*7
    property real gridHeight: dayHeight*5

    property real hour
    property real minute
    property real curlanguage: HSPluginsManager.get('system').language
    property bool isAM: false

    property var currentDates


    function __cellRectAt(index) {
        return CalendarUtils.cellRectAt(index, control.__panel.columns, control.__panel.rows,
                                        control.__panel.availableWidth, control.__panel.availableHeight, gridVisible ? __gridLineWidth : 0);
    }

    function __isValidDate(date) {
        return date !== undefined
                && date.getTime() >= control.minimumDate.getTime()
                && date.getTime() <= control.maximumDate.getTime();
    }

    property Component background: Rectangle {
        color: "#00000000"
        Image {
            id: bg
            source: (themeColor === 0x00)?"qrc:/resources/home_option_Calendar_Bg.png":((themeColor ===0x01)?"qrc:/resources/home_option_Calendar_Bg_o.png":"qrc:/resources/home_option_Calendar_Bg_g.png")
        }
    }

    /* Begin by Xiongwei, 2017.2.8
     * Modify the Date widget not change after Reboot
     */
    function displayCurrentDate() {
        currentDates = new Date()
        currentDates.setFullYear(years,month,days)
        control.selectedDate = currentDates
    }

    onDaysChanged: displayCurrentDate()

    onYearsChanged: displayCurrentDate()

    onMonthChanged: displayCurrentDate()
    /* End by Xiongwei, 2017.2.8
     * Modify the Date widget not change after Reboot
     */


    property QtObject curDate: QtObject
    {
    property var locale: Qt.locale()
    property date currentDate: new Date()
    property string dateString
    Component.onCompleted: {
        dateString = currentDate.toLocaleDateString();
        //        print(Date.fromLocaleDateString(dateString));
        //        print(dateString)
    }
    function getHMData(){
        var hours = 0
        currentDate= new Date()
        if(curDate.currentDate.getHours()<=12){
            hours = add_zero(curDate.currentDate.getHours())
        }else{
            hours=add_zero(curDate.currentDate.getHours() - 12)
        }
//        hour = hours
        var minutes = add_zero(curDate.currentDate.getMinutes())
//        minute = minutes
        var HMData = hours+":"+minutes
        return HMData
    }


    function getYMDData()
    {
        /* Begin by Xiongwei, 2016.12.12
         * Modify the Date widget
         */

        /*currentDate= new Date()
        var years = curDate.currentDate.getFullYear();
        var month = add_zero(curDate.currentDate.getMonth()+1);
        var days = add_zero(curDate.currentDate.getDate());*/

        /* End by Xiongwei, 2016.12.12
         * Modify the Date widget
         */
        var currentMonth = month+1

        var YMDData =years+"年"+currentMonth+"月"+days+"日"
        if(curlanguage === 1)
        {
            YMDData =years+"/"+currentMonth+"/"+days
        }
        return YMDData
        //年月日
    }
    function getWeekData()
    {
        var week;
        switch (currentDates.getDay()){
        case 1: week=qsTr("星期一"); break;
        case 2: week=qsTr("星期二"); break;
        case 3: week=qsTr("星期三"); break;
        case 4: week=qsTr("星期四"); break;
        case 5: week=qsTr("星期五"); break;
        case 6: week=qsTr("星期六"); break;
        default: week=qsTr("星期天");
        }
        return week
    }

    function getAPData(){
        var ap = "AMPM"
        currentDate= new Date()
        if(curDate.currentDate.getHours()>=12){
            ap = "PM"
        }
        else{
            ap = "AM"
        }
        return ap
    }
    function add_zero(temp)
    {
        if(temp<10) return "0"+temp;
        else return temp;
    }

}

    property bool timeformt: HSPluginsManager.get('system').hours24state
    property int themeColor: interfacemodel

    property Component navigationBar: Label {
        id:timeBar
        width: 346
        height: 250

        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: timeBar.setAllTimeInfo()
            Component.onCompleted: timeBar.setAllTimeInfo()
        }

        function setAllTimeInfo() {
            timeText.text = currentDateTime()
            pmamText.text = curDate.getAPData()
            weekText.text = curDate.getWeekData()
            dateText.text = curDate.getYMDData()
            hour = parseInt(currentDateTime().substring(0,2))
            minute = parseInt(currentDateTime().substring(3,5))
        }

        /* Begin by Zhou Yongwu, 2016.11.29
         * Modify the time for 12 hours format
        */
        function currentDateTime() {
            var wholeTime = Qt.formatDateTime(new Date(), "hh:mm")
            if (timeformt) {
                return wholeTime
            } else {
                if (wholeTime.substring(0,2) > 12) {
                    isAM = false
                    return (wholeTime.substring(0,2) - 12) + wholeTime.substring(2, 5)
                } else if (wholeTime.substring(0,2) == 12) {
                    isAM = false
                    return wholeTime
                } else if (wholeTime.substring(0,2) == 00){
                    isAM = true
                    return 12 + wholeTime.substring(2, 5)
                } else {
                    isAM = true
                    return wholeTime
                }
            }
        }
        /* End by Zhou Yongwu, 2016.11.29 */

        Item {
            id: calendarRectangle
            width:parent.width
            height:190
            /* BEGIN by Li Peng, 2016.11.16
             * The widget logic.
             * See: <HS-M1164 D27-V1.5.xlsx>,  0.1.4
            */
            Text {
                id:pmamText
                height: 24
                y:20
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 24
                color: "#a5a6a8"
            }
            Text {
                id:timeText
                height: 72
                anchors.top: pmamText.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 72
                //color: "#8fece2"
                color: (themeColor === 0x00) ? "#8fece2" : ((themeColor === 0x01) ? "#FF2200" : "#986142")
            }
            Text {
                id:weekText
                height:24
                anchors.top: timeText.bottom
                anchors.topMargin: 30
                color: "#a5a6a8"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 24
            }
            IControls.MouseArea {
                width:parent.width
                height:190
                anchors.top:parent.top
                onClicked: {
                    if(timeformt){
                        application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmTime24Hours.qml',{themeColor: interfacemodel,texttitle:qsTr('设置时间'),currentHour: hour, currentMinutes: minute}, dialogConfirmSetTime24);
                    }
                    else {
                        application.createConfirmDialogAsync('qrc:/Instances/Controls/DialogConfirmTime.qml',{themeColor: interfacemodel,texttitle:qsTr('设置时间'), currentHour: hour, currentMinutes: minute, isAM: isAM}, dialogConfirmSetTime12);
                    }
                }
            }
        }
        //------------settime24--begin--------------------------
        function dialogConfirmSetTime24(dialog){
            dialog.confirmed_info.connect(function confirmed(info){
                console.debug("dialogConfirmselected cb confirmed:", info);
                system.setTime(info[0], info[1]);
            });
        }
        //------------settime2--end-----------------------------

        //------------settime12--begin--------------------------
        function dialogConfirmSetTime12(dialog){
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
        /* END by Li Peng, 2016.11.16 */
        Rectangle{
            id:dateRectangle
            anchors.top: calendarRectangle.bottom
            width: 296
            anchors.topMargin: 37
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            Image {
                source: "qrc:/resources/home_option_Calendar.png"
                anchors.verticalCenter: dateRectangle.verticalCenter
            }
            Text {
                id:dateText
                height:30
                anchors.centerIn: parent
                font.pixelSize: 30
                color: "#a5a6a8"
            }
        }

    }

    property Component dayDelegate: Item {
        height: dayHeight
        width: dayWidth
        Image {
            id: selectedBg
            visible: styleData.selected
            anchors.centerIn: parent
            source: (themeColor ===0x00)? "qrc:/resources/home_dec_Calendar.png":((themeColor ===0x01)?"qrc:/resources/home_dec_Calendar_o.png":"qrc:/resources/home_dec_Calendar_g.png")
        }
        Text {
            id: dayDelegateText
            text: styleData.date.getDate()
            anchors.centerIn: parent
            font.pixelSize: 20
            color: {
                var theColor =  "#a5a6a8"
                if((styleData.index%7 === 0)||(styleData.index%7 === 6)){
                    if (styleData.selected)
                        theColor = "black";
                    else{
                        //theColor ="#8fece2"
                        theColor = (themeColor === 0x00) ? "#8fece2" : ((themeColor === 0x01) ? "#FF2200" : "#986142")
                    }
                }else{
                    if (styleData.selected)
                        theColor = "black";
                    else{
                        theColor ="#a5a6a8"
                    }
                }
                theColor;
            }
        }
    }

    property Component dayOfWeekDelegate: Item {
        height: dayHeight
        width: dayWidth
        Text {
            anchors.centerIn: parent
            font.pixelSize: 20
            width: 20
            height: 20
            color: {
                var weekColor ="#a5a6a8"
                if((styleData.index%7 === 0)||(styleData.index%7 === 6)){
                    //theColor ="#8fece2"
                    weekColor = (themeColor === 0x00) ? "#8fece2" : ((themeColor === 0x01) ? "#FF2200" : "#986142")
                }
                else{
                    weekColor ="#a5a6a8"
                }
                weekColor

            }
            text: {
                var chainaWeekNum ="ss"
                switch(control.__locale.dayName(styleData.dayOfWeek, control.dayOfWeekFormat))
                {
                case 'Sun':{chainaWeekNum =qsTr("日")}break
                case "Mon":{chainaWeekNum =qsTr("一")}break
                case "Tue":{chainaWeekNum =qsTr("二")}break
                case "Wed":{chainaWeekNum =qsTr("三")}break
                case "Thu":{chainaWeekNum =qsTr("四")}break
                case "Fri":{chainaWeekNum =qsTr("五")}break
                case "Sat":{chainaWeekNum =qsTr("六")}break
                }
                chainaWeekNum + ctranslator.monitor
            }

        }
    }

    property Component panel: Item {
        id: panelItem
        property alias navigationBarItem: navigationBarLoader.item

        property alias dayOfWeekHeaderRow: dayOfWeekHeaderRow

        readonly property int weeksToShow: 6
        readonly property int rows: 4
        readonly property int columns: CalendarUtils.daysInAWeek

        // The combined available width and height to be shared amongst each cell.
        readonly property real availableWidth: viewContainer.width
        readonly property real availableHeight: viewContainer.height

        property int hoveredCellIndex: -1
        property int pressedCellIndex: -1
        property int pressCellIndex: -1

        Item {
            id: container
            width: totalWidth
            height: totalHeight

            Loader {
                id: backgroundLoader
                anchors.fill: parent
                sourceComponent: background
            }
            Loader {
                id: navigationBarLoader
                sourceComponent: navigationBar

                property QtObject styleData: QtObject {//setting date in left label here
                    readonly property string yearLabel:control.visibleYear + "年"
                    readonly property string monthLabel:control.visibleMonth+1 + "月" //month is 0~11
                }
            }

            Row {
                id: dayOfWeekHeaderRow
                width: weekRowWidth
                height: dayHeight
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: navigationBarLoader.bottom
                Repeater {
                    id: repeater
                    model: CalendarHeaderModel {
                        locale: control.__locale
                    }
                    Loader {
                        id: dayOfWeekDelegateLoader
                        sourceComponent: dayOfWeekDelegate

                        readonly property int __index: index
                        readonly property var __dayOfWeek: dayOfWeek

                        property QtObject styleData: QtObject {
                            readonly property alias index: dayOfWeekDelegateLoader.__index
                            readonly property alias dayOfWeek: dayOfWeekDelegateLoader.__dayOfWeek
                        }
                    }
                }
            }

            Row {
                id: gridRow
                anchors.top: dayOfWeekHeaderRow.bottom
                width: gridWidth
                height: gridHeight
                anchors.horizontalCenter:parent.horizontalCenter
                Item {
                    id: viewContainer
                    width: gridWidth
                    height: gridHeight

                    Connections {
                        target: control
                        onSelectedDateChanged: view.selectedDateChanged()
                    }

                    Repeater {
                        id: view
                        property int currentIndex: -1

                        model: control.__model

                        Component.onCompleted: {
                            selectedDateChanged()
                        }
                        function selectedDateChanged() {
                            if (model !== undefined && model.locale !== undefined) {
                                currentIndex = model.indexAt(control.selectedDate);
                            }
                        }

                        delegate: Loader {
                            id: delegateLoader

                            x: __cellRectAt(index).x
                            y: __cellRectAt(index).y
                            /* BEGIN by Li Peng, 2016.11.18
                         * fix #678 the day display the whole month
                        */
                            sourceComponent: dayDelegate
                            /* END by Li Peng*/
                            readonly property int __index: index
                            readonly property date __date: date
                            // We rely on the fact that an invalid QDate will be converted to a Date
                            // whose year is -4713, which is always an invalid date since our
                            // earliest minimum date is the year 1.

                            readonly property bool valid: __isValidDate(date)
                            property QtObject styleData: QtObject {
                                readonly property alias index: delegateLoader.__index
                                readonly property bool selected: control.selectedDate.getTime() === date.getTime()
                                readonly property alias date: delegateLoader.__date
                                readonly property bool valid: delegateLoader.valid
                                // TODO: this will not be correct if the app is running when a new day begins.
                                readonly property bool today: date.getTime() === new Date().setHours(0, 0, 0, 0)
                                readonly property bool visibleMonth: date.getMonth() === control.visibleMonth
                                readonly property bool hovered: panelItem.hoveredCellIndex == index
                                readonly property bool pressed: panelItem.pressedCellIndex == index
                                // todo: pressed property here, clicked and doubleClicked in the control itself
                            }
                        }
                    }
                }
            }
        }
    }
}
