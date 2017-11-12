import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import 'qrc:/UI/Controls' as UControls
import Apps 1.0
import 'qrc:/Instances/Controls' as IControls
import TheXSettings 1.0

Style {
    id: calendarStyle

    readonly property Calendar control: __control

    property bool gridVisible: true
    property real enterdX:0
    property real enterdY:0
    property real exitedX:0
    property real exitedY:0

    property real __gridLineWidth: 1

    property real curlanguage: HSPluginsManager.get('system').language
    property int themeColor: HSPluginsManager.get('system').interfacemodel

    /* Begin by Xiongwei, 2016.12.12
     * Modify the Date widget
     */
    property real year: HSPluginsManager.get('system').year
    property real month: HSPluginsManager.get('system').month - 1  //sysctl.month(1~12), calendar(0~11)
    property real day: HSPluginsManager.get('system').day
    /* End by Xiongwei, 2016.12.12
     * Modify the Date widget
     */


    CalendarCtl  {
       id:calendarctl
    }

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
        Image {
            id: bg
            source: (themeColor == 0x00)?"qrc:/resources/BG.png":((themeColor == 0x01)?"qrc:/resources/BG_o.png":"qrc:/resources/BG_g.png")
        }
    }

    function backToToday() {
        var date = new Date()
        date.setFullYear(year, month, day)
        control.selectedDate = date
        control.visibleYear = year
    }

    Component.onCompleted: backToToday()

    property Component navigationBar: Rectangle {
        x:19
        y:60
        height: 397
        width: 277
        color: "#00000000"
        UControls.Icon_Button {
            anchors.left: parent.left
            y:0
            width: 277
            height: 75
            id: previousMonth
            bgGradient:Gradient {
                GradientStop { position: 0.0; color: "#25272b" }
                GradientStop { position: 1.0; color: "#181a1c" }
            }
//            bgPressingGradient:Gradient{
//                GradientStop { position: 0.0; color: "#307e89" }
//                GradientStop { position: 1.0; color: "#0a5362" }
//            }

            bgPressingGradient: Gradient{
                GradientStop { position: 0.0; color: (themeColor === 0)?"#307e89":((themeColor === 1)?"#9B1702":"#ab7c48") }
                GradientStop { position: 1.0; color: (themeColor === 0)?"#0a5362":((themeColor === 1)?"#2D0D07":"#855033") }
            }


            source: "qrc:/resources/RL_ICN_arrow.png"

            onClicked: {

                control.showPreviousMonth()

            }
        }

        Rectangle{
            id:sideLabel
            width: parent.width
            height: parent.height-75*2
            anchors.left: previousMonth.left
            anchors.top:previousMonth.bottom
            color: "#1b1c20"
            Text {
                id:labelYear
                y:80
                color: "white"
                text: (curlanguage ==0 )?(styleData.yearLabel + "年"):styleData.yearLabel
                font.pixelSize: 38
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                id: labelMonth
                //color: "#49b7ac"
                color: (themeColor === 0x00) ? "#49b7ac" : ((themeColor === 0x01) ? "#FF2200" : "#986142")
                anchors.top: labelYear.bottom
                text:{
                    var monthData ="1"
                    if(curlanguage == 0){
                        monthData = styleData.monthLabel + "月"
                    }else{
                        switch(styleData.monthLabel){
                        case "1":{monthData ="January"} break
                        case "2":{monthData ="February"} break
                        case "3":{monthData ="March"} break
                        case "4":{monthData ="April"} break
                        case "5":{monthData ="May"} break
                        case "6":{monthData ="June"} break
                        case "7":{monthData ="July"} break
                        case "8":{monthData ="August"} break
                        case "9":{monthData ="September"} break
                        case "10":{monthData ="October"} break
                        case "11":{monthData ="November"} break
                        case "12":{monthData ="December"} break
                        }
                    }
                    monthData
                }
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize:48
            }
        }
        UControls.Icon_Button {
            anchors.left:sideLabel.left
            anchors.top:sideLabel.bottom
            width: 277
            height: 75
            id: nextMonth
            rotation: 180
            bgGradient:Gradient {
                GradientStop { position: 0.0; color: "#25272b" }
                GradientStop { position: 1.0; color: "#181a1c" }
            }
//            bgPressingGradient:Gradient{
//                GradientStop { position: 0.0; color: "#307e89" }
//                GradientStop { position: 1.0; color: "#0a5362" }
//            }
            bgPressingGradient: Gradient{
                GradientStop { position: 0.0; color: (themeColor === 0)?"#307e89":((themeColor === 1)?"#9B1702":"#ab7c48") }
                GradientStop { position: 1.0; color: (themeColor === 0)?"#0a5362":((themeColor === 1)?"#2D0D07":"#855033") }
            }

            source: "qrc:/resources/RL_ICN_arrow.png"

            onClicked: {

                control.showNextMonth()
            }

        }
    }

    property Component dayDelegate: Item {
        width: 136
        height: 91

        Rectangle{
            width: 136
            height: 91
            opacity: {
                var theOpacity = 0
                if (styleData.valid) {
                    // Date is within the valid range.
                    theOpacity = styleData.visibleMonth ? 0.12 : 0.08;
                    if (styleData.selected)
                        theOpacity = 0.54;
                }
                theOpacity;
            }

            //color: styleData.selected?"#184c57":"white"
            color: styleData.selected?((themeColor === 0x00) ? "#184c57" : ((themeColor === 0x01) ? "#8c4338" : "#986142")):"white"
            Rectangle{
                visible: styleData.selected
                Rectangle{
                    id:topLine
                    anchors.left: parent.left
                    anchors.top:parent.top
                    width: 136
                    height: 2
                    //color: "#00f9ff"
                    color: (themeColor === 0x00) ? "#00f9ff" : ((themeColor === 0x01) ? "#FF2200" : "#986142")
                }
                Rectangle{
                    id:leftLine
                    anchors.left: parent.left
                    anchors.top:parent.top
                    width: 2
                    height: 93
                    //color: "#00f9ff"
                    color: (themeColor === 0x00) ? "#00f9ff" : ((themeColor === 0x01) ? "#FF2200" : "#986142")
                }
                Rectangle{
                    id:bottomLine
                    x:0
                    y:91
                    width: 136
                    height: 2
                    //color: "#00f9ff"
                    color: (themeColor === 0x00) ? "#00f9ff" : ((themeColor === 0x01) ? "#FF2200" : "#986142")
                }
                Rectangle{
                    id:rightLine
                    x:134
                    y:0
                    width: 2
                    height: 93
                    //color: "#00f9ff"
                    color: (themeColor === 0x00) ? "#00f9ff" : ((themeColor === 0x01) ? "#FF2200" : "#986142")
                }
            }
        }
        Text {
            id: dayDelegateText
            opacity: {
                var theOpacity = 0
                if (styleData.valid) {
                    // Date is within the valid range.
                    theOpacity = styleData.visibleMonth ? 1 : 0.08;
                    if (styleData.selected)
                        theOpacity = 1;
                }
                theOpacity;
            }
            text: styleData.date.getDate()
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 38
            color:"white"
        }
        Text {
            id: chinaDayDelegateText
            visible: curlanguage == 0
            opacity: 0.08
            anchors.top: dayDelegateText.bottom          //            text: ChinaDate.calendar.toChinaDay(styleData.date.getDate())
            text:{
//                if(curlanguage ===0){
                    calendarctl.getLunarDate(styleData.date.getFullYear(),styleData.date.getMonth()+1,styleData.date.getDate())
//                }
            }
            Component.onCompleted: {
//                console.log("month:",ChinaDate.calendar.nongliMonth(styleData.date.getFullYear(),styleData.date.getMonth()+1,styleData.date.getDate()),"day:",ChinaDate.calendar.solar2lunar(styleData.date.getFullYear(),styleData.date.getMonth()+1,styleData.date.getDate()))
            }

            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 22
            color: "white"
        }

    }

    property Component dayOfWeekDelegate: Item {
        implicitHeight: 63
        implicitWidth: 138
        Rectangle{
            anchors.fill: parent
            width: parent.width
            height: parent.height
            color: "white"
            opacity: 0.12
        }

        Label {
            color:"white"
            opacity: 0.12
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
                chainaWeekNum
            }
            anchors.centerIn: parent
            font.pixelSize: 34
        }
    }



    property Component panel: Item {
        id: panelItem
        property alias navigationBarItem: navigationBarLoader.item
        property alias dayOfWeekHeaderRow: dayOfWeekHeaderRow
        readonly property int weeksToShow: 6
        readonly property int rows: weeksToShow
        readonly property int columns: CalendarUtils.daysInAWeek

        // The combined available width and height to be shared amongst each cell.
        readonly property real availableWidth: viewContainer.width
        readonly property real availableHeight: viewContainer.height

        property int hoveredCellIndex: -1
        property int pressedCellIndex: -1
        property int pressCellIndex: -1

        Item {
            id: container

            width: 1280
            height: 720-91

            Loader {
                id: backgroundLoader
                anchors.fill: parent
                sourceComponent: background
            }
            Loader {
                id: navigationBarLoader
                sourceComponent: navigationBar
                active: control.navigationBarVisible

                property QtObject styleData: QtObject {//setting date in left label here
                    readonly property string yearLabel:control.visibleYear
                    readonly property string monthLabel:control.visibleMonth + 1//month is 0~11
                }

            }

            UControls.Icon_Button {
                id:backToTodayBtn
                width: 277
                height: 84
                //                anchors.left: parent.left
                //                anchors.left: previousMonth.left\
                x:19
                anchors.leftMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 17
                bgGradient:Gradient {
                    GradientStop { position: 0.0; color: "#2d373d" }
                    GradientStop { position: 1.0; color: "#1e272b" }
                }
//                bgPressingGradient:Gradient{
//                    GradientStop { position: 0.0; color: "#367284" }
//                    GradientStop { position: 1.0; color: "#0e5263" }
//                }
                bgPressingGradient: Gradient{
                    GradientStop { position: 0.0; color: (themeColor === 0)?"#367284":((themeColor === 1)?"#9B1702":"#ab7c48") }
                    GradientStop { position: 1.0; color: (themeColor === 0)?"#0e5263":((themeColor === 1)?"#2D0D07":"#855033") }
                }

                text: qsTr("今天")
                font.pixelSize: 36
                textColor: "white"
                onClicked: {
                    /* Begin by Xiongwei, 2016.12.12
                     * Modify the Date widget
                     */
                    //control.selectedDate =new Date()
                    //control.visibleMonth = new Date().getMonth()
                    //control.visibleYear = new Date().getFullYear()
                    backToToday()
                    control.visibleMonth = month
                    /* End by Xiongwei, 2016.12.12
                     * Modify the Date widget
                     */
                }

            }

            Row {
                id: dayOfWeekHeaderRow
                width: 964
                height: 63
                x:1280-964
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
                width: 964
                height: 628
                y:63
                x:1280-964

                Column {
                    id: weekNumbersItem

                    visible: control.weekNumbersVisible
                    height: viewContainer.height
                    Repeater {
                        id: weekNumberRepeater
                        model: panelItem.weeksToShow
                    }
                }

                // Contains the grid lines and the grid itself.

                Item{
                    id: viewContainer
                    width: 964
                    height: 628 - 63
                    Repeater {
                        id: verticalGridLineRepeater
                        model: panelItem.columns - 1
                        delegate: Rectangle {
                            x: __cellRectAt(index + 1).x - __gridLineWidth
                            y: 0
                            visible: gridVisible
                            Image {
                                id: gridImageVer
                                source: "qrc:/resources/RL_line_vertical.png"
                            }
                        }
                    }

                    Repeater {
                        id: horizontalGridLineRepeater
                        model: panelItem.rows - 1
                        delegate: Rectangle {
                            x: 0
                            y: __cellRectAt((index + 1) * panelItem.columns).y - __gridLineWidth -5
                            Image {
                                id: gridImageHor
                                source: "qrc:/resources/rl_line_horizontal.png"
                            }
                            visible: gridVisible
                        }
                    }

                    IControls.MouseArea {
                        id: mouseArea
                        anchors.fill: parent

                        hoverEnabled: Settings.hoverEnabled

                        function cellIndexAt(mouseX, mouseY) {
                            var viewContainerPos = viewContainer.mapFromItem(mouseArea, mouseX, mouseY);
                            var child = viewContainer.childAt(viewContainerPos.x, viewContainerPos.y);
                            // In the tests, the mouseArea sometimes gets picked instead of the cells,
                            // probably because stuff is still loading. To be safe, we check for that here.
                            return child && child !== mouseArea ? child.__index : -1;
                        }

                        onEntered: {
                            hoveredCellIndex = cellIndexAt(mouseX, mouseY);
                            if (hoveredCellIndex === undefined) {
                                hoveredCellIndex = cellIndexAt(mouseX, mouseY);
                            }

                            var date = view.model.dateAt(hoveredCellIndex);
                            if (__isValidDate(date)) {
                                control.hovered(date);
                            }
                        }

                        onExited: {
                            hoveredCellIndex = -1;
                        }

                        onPositionChanged: {
                            var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                            var previousHoveredCellIndex = hoveredCellIndex;
                            hoveredCellIndex = indexOfCell;
                            if (indexOfCell !== -1) {
                                var date = view.model.dateAt(indexOfCell);
                                if (__isValidDate(date)) {
                                    if (hoveredCellIndex !== previousHoveredCellIndex)
                                        control.hovered(date);

                                    // The date must be different for the pressed signal to be emitted.
                                    if (pressed && date.getTime() !== control.selectedDate.getTime()) {
                                        control.pressed(date);

                                        // You can't select dates in a different month while dragging.
                                        if (date.getMonth() === control.selectedDate.getMonth()) {
                                            control.selectedDate = date;
                                            pressedCellIndex = indexOfCell;
                                        }
                                    }
                                }
                            }
                        }

                        onPressed: {
                            pressCellIndex = cellIndexAt(mouse.x, mouse.y);
                            if (pressCellIndex !== -1) {
                                var date = view.model.dateAt(pressCellIndex);
                                pressedCellIndex = pressCellIndex;
                                if (__isValidDate(date)) {
                                    control.selectedDate = date;
                                    control.pressed(date);
                                }
                            }
                        }

                        onReleased: {
                            var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                            if (indexOfCell !== -1) {
                                // The cell index might be valid, but the date has to be too. We could let the
                                // selected date validation take care of this, but then the selected date would
                                // change to the earliest day if a day before the minimum date is clicked, for example.
                                var date = view.model.dateAt(indexOfCell);
                                if (__isValidDate(date)) {
                                    control.released(date);
                                }
                            }
                            pressedCellIndex = -1;
                        }

                        onClicked: {
                            var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                            if (indexOfCell !== -1 && indexOfCell === pressCellIndex) {
                                var date = view.model.dateAt(indexOfCell);
                                if (__isValidDate(date))
                                    control.clicked(date);
                            }
                        }

                        onDoubleClicked: {
                            var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                            if (indexOfCell !== -1) {
                                var date = view.model.dateAt(indexOfCell);
                                if (__isValidDate(date))
                                    control.doubleClicked(date);
                            }
                        }

                        onPressAndHold: {
                            var indexOfCell = cellIndexAt(mouse.x, mouse.y);
                            if (indexOfCell !== -1 && indexOfCell === pressCellIndex) {
                                var date = view.model.dateAt(indexOfCell);
                                if (__isValidDate(date))
                                    control.pressAndHold(date);
                            }
                        }
                    }

                    Connections {
                        target: control
                        onSelectedDateChanged: view.selectedDateChanged()
                    }

                    Repeater {
                        id: view

                        property int currentIndex: -1

                        model: control.__model

                        Component.onCompleted: selectedDateChanged()

                        function selectedDateChanged() {
                            if (model !== undefined && model.locale !== undefined) {
                                currentIndex = model.indexAt(control.selectedDate);
                            }
                        }

                        delegate: Loader {
                            id: delegateLoader

                            x: __cellRectAt(index).x
                            y: __cellRectAt(index).y
                            sourceComponent: dayDelegate

                            readonly property int __index: index
                            property date __date: date
                            // We rely on the fact that an invalid QDate will be converted to a Date
                            // whose year is -4713, which is always an invalid date since our
                            // earlt minimum date is the year 1.
                            readonly property bool valid: __isValidDate(date)


                            property QtObject styleData: QtObject {
                                //                                readonly property string curYear:control.visibleYear
                                //                                readonly property string curMonth:control.visibleMonth+1
                                //                                readonly property string curDay:control.visibleDay

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

                IControls.MouseArea{
                    anchors.fill: gridRow
                    onEntered: {
                        enterdX= mouseX;
                        enterdY = mouseY

                    }
                    onExited: {
                        exitedX = mouseX
                        exitedY = mouseY
                        if(enterdX - exitedX > 100){
                             control.showPreviousMonth()
                        }else if(exitedX - enterdX > 100){
                            control.showNextMonth()
                        }
                    }
              }
            }
        }
    }
}
