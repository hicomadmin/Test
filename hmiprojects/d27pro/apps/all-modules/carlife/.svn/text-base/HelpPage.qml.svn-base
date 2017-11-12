import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Core' as UCore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import TheXCarlife 1.0
import TheXDevice 1.0
import Bluetooth 1.0
import TheXSettings 1.0

ICore.Page {
    id: helpPage

    //property carlifeCtl carlife
    property int page
    readonly property int _Help_Main_Page: 1
    readonly property int _Help_Android_Main_Page: 2
    readonly property int _Help_Ios_Main_Page: 3
    readonly property int _Help_UsbDebug_Page: 4
    readonly property int _Help_UsbDebug_Page2: 5
    readonly property int _Help_UsbDebug_Page3: 6

    property int xPos
    property int mPressed : 0

    onItemShowing: {

    }

    onItemShown: {
        showMainPage(true)
        iosMainPage.visible = false
        androidMainPage.visible = false
    }

    function showMainPage(cmd){
        if(true === cmd){
            page = _Help_Main_Page
            helptitle.text = qsTr('连接帮助')
        }
        maincontent.visible = cmd
    }

    function showAndroidPage(cmd){
        if(true === cmd){
            page = _Help_Android_Main_Page
            helptitle.text = qsTr('安卓手机')
        }
        androidMainPage.visible = cmd
    }

    function showIosMainPage(cmd){
        if(true === cmd){
            page = _Help_Ios_Main_Page
            helptitle.text = qsTr('苹果手机')
        }
        iosMainPage.visible = cmd
    }

    function showUsbDebug1Page(cmd){
        if(true === cmd){
            page = _Help_UsbDebug_Page
            helptitle.text = qsTr('打开USB调试')
        }
        usbDebugPage1.visible = cmd
        ctrlPage.visible = cmd
    }
/*-------------------help main page-----------------------*/
    Image {
        id: bg
        source: "qrc:/resource-carlife/bg.png"
        Rectangle{
            id: quit
            Image {
                x: 96
                y: 85
                source: "qrc:/resource-carlife/Connection help.png"
                IControls.MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.debug("carlife page:", page)
                        if(_Help_Main_Page === page){
                            application.changePage('main');
                        }else if(_Help_Android_Main_Page === page){
                            showAndroidPage(false)
                            showMainPage(true)
                        }else if(_Help_Ios_Main_Page === page){
                            showIosMainPage(false)
                            showMainPage(true)
                        }else if(_Help_UsbDebug_Page === page){
                            showUsbDebug1Page(false)
                            showAndroidPage(true)
                        }
                    }
                }
            }
            IControls.NonAnimationText_FontRegular{
                x: 150
                y: 75
                id: helptitle
                text: qsTr('连接帮助')
                color: "#FFFFFF"
                font.pixelSize: 45
                IControls.MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.debug("carlife page:", page)
                        if(_Help_Main_Page === page){
                            application.changePage('main');
                        }else if(_Help_Android_Main_Page === page){
                            showAndroidPage(false)
                            showMainPage(true)
                        }else if(_Help_Ios_Main_Page === page){
                            showIosMainPage(false)
                            showMainPage(true)
                        }else if(_Help_UsbDebug_Page === page){
                            showUsbDebug1Page(false)
                            showAndroidPage(true)
                        }
                    }
                }
            }
        }
        Rectangle{
            x: 140
            y: 80
            id:maincontent
            width: 998
            height: 600
            color:"#00000000"
            visible: true
            IControls.NonAnimationText_FontRegular{
                x: 96
                y: 105
                text: qsTr('请选择您使用的手机系统')
                color: "#FFFFFF"
                font.pixelSize: 45
            }
            Image {
                source: "qrc:/resource-carlife/division.png"
                y: 200
            }
            Rectangle{
                y:200
                Image {
                    source: "qrc:/resource-carlife/carlife_Android_logo.png"
                    x: 150
                    y: 30
                }
                IControls.NonAnimationText_FontRegular{
                    x: 230
                    y: 30
                    text: qsTr('安卓手机')
                    color: "#FFFFFF"
                    font.pixelSize: 45
                    IControls.MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            showAndroidPage(true)
                            showMainPage(false)
                        }
                    }
                }
            }
            Image {
                source: "qrc:/resource-carlife/division.png"
                y: 330
            }
            Rectangle{
                y:350
                Image {
                    source: "qrc:/resource-carlife/carlife_phone_logo.png"
                    x: 150
                    y: 30
                }
                IControls.NonAnimationText_FontRegular{
                    x: 230
                    y: 30
                    text: qsTr('苹果手机')
                    color: "#FFFFFF"
                    font.pixelSize: 45
                    IControls.MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            showIosMainPage(true)
                            showMainPage(false)
                        }
                    }
                }
            }
            Image {
                source: "qrc:/resource-carlife/division.png"
                y: 480
            }
        }
    }
/*-------------------android main page-----------------------*/
   Rectangle{
        x: 140
        y: 120
        id:androidMainPage
        width: 998
        height: 450
        color:"#00000000"
        visible: false
        Rectangle{
            Image {
                source: "qrc:/resource-carlife/Connection help_currency.png"
                x: 960
                y: 60
                IControls.MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        showUsbDebug1Page(true)
                        showAndroidPage(false)
                    }
                }
            }
            IControls.NonAnimationText_FontRegular{
                x: 10
                y: 40
                text: qsTr('如何开启 “USB调试”')
                color: "#FFFFFF"
                font.pixelSize: 42
                IControls.MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        showUsbDebug1Page(true)
                        showAndroidPage(false)
                    }
                }
            }
            Image {
                source: "qrc:/resource-carlife/division.png"
                x: 0
                y: 120
            }
        }
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 140
            text: qsTr('检查数据线并重新连接')
            color: "#FFFFFF"
            font.pixelSize: 42
        }
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 220
            text: qsTr('连接后手机处于连接状态，但无法建立连接，可能是您的USB线\n仅支持充电，不支持数据传输，您可以换根数据线后尝试重连。')
            color: "#707070"
            font.pixelSize: 38
        }
        Image {
            source: "qrc:/resource-carlife/division.png"
            x: 0
            y: 340
        }
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 360
            text: qsTr('尝试重启手机再次连接')
            color: "#FFFFFF"
            font.pixelSize: 42
        }
        Image {
            source: "qrc:/resource-carlife/division.png"
            x: 0
            y: 440
        }
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 460
            text: qsTr('若需要使用蓝牙电话功能，请将设备蓝牙连接至车机')
            color: "#FFFFFF"
            font.pixelSize: 42
        }
        Image {
            source: "qrc:/resource-carlife/division.png"
            x: 0
            y: 540
        }
    }
/*-------------------ios main page-----------------------*/
    Rectangle{
        x: 140
        y: 120
        id:iosMainPage
        width: 998
        height: 32
        color:"#00000000"
        visible: false
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 40
            text: qsTr('请在车载设备设置菜单中，进入“连接设置”确认“USB苹\n果设备”选项已选择了“百度Carlife”')
            color: "#FFFFFF"
            font.pixelSize: 38
        }
        Image {
            source: "qrc:/resource-carlife/division.png"
            y: 170
        }
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 190
            text: qsTr('确认手机已安装Carlife')
            color: "#FFFFFF"
            font.pixelSize: 40
        }
        Image {
            source: "qrc:/resource-carlife/division.png"
            y: 260
        }
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 280
            text: qsTr('检查数据线并重新连接')
            color: "#FFFFFF"
            font.pixelSize: 40
        }
        Image {
            source: "qrc:/resource-carlife/division.png"
            y: 350
        }
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 370
            text: qsTr('尝试重启手机再次连接')
            color: "#FFFFFF"
            font.pixelSize: 40
        }
        Image {
            source: "qrc:/resource-carlife/division.png"
            x:10
            y:450
        }
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 470
            text: qsTr('若需要使用蓝牙电话功能，请将设备蓝牙连接至车机')
            color: "#FFFFFF"
            font.pixelSize: 40
        }
        Image {
            source: "qrc:/resource-carlife/division.png"
            x:10
            y:550
        }
    }
 /*-------------------usbdebug page ----------------------*/
   function btn1Checked(){
       btn1.checked = true
       quit.visible = true
       helptitle.visible = true
       page3Txt.visible = false
       page2Txt.visible = false
       usbDebugTxt.y = 150
       usbDebugImg.x = 185
       usbDebugImg.y = 280
       usbDebugTxt.text = qsTr('在手机端Carlife, 沿以下操作路径， “首页》我的》设置”，\n找到“USB调试设置”， 点击前往设置')
       usbDebugImg.source = "qrc:/resource-carlife/carlife_Android00.png"
       btn1txt.color = "white"
       btn2txt.color="#505050"
       btn3txt.color="#505050"
   }
   function btn2Checked(){
       btn2.checked = true
       quit.visible = false
       helptitle.visible = false
       usbDebugTxt.y = 30
       usbDebugImg.x = 200
       usbDebugImg.y = 120
       page3Txt.visible = false
       page2Txt.visible = true
       usbDebugTxt.text = qsTr('你可以在手机系统设置，沿以下操作路径，找到该操作项')
       usbDebugImg.source = "qrc:/resource-carlife/carlife_Android01.png"
       btn2txt.color = "white"
       btn1txt.color="#505050"
       btn3txt.color="#505050"
   }
   function btn3Checked(){
       btn3.checked = true
       quit.visible = false
       helptitle.visible = false
       usbDebugTxt.y = 30
       usbDebugImg.x = 200
       usbDebugImg.y = 120
       page3Txt.visible = true
       page2Txt.visible = false
       usbDebugTxt.text = qsTr('如果设置中找不到“开发者选项”， 操作如下')
       usbDebugImg.source = "qrc:/resource-carlife/carlife_Android02.png"
       btn3txt.color = "white"
       btn2txt.color="#505050"
       btn1txt.color="#505050"
   }

   Rectangle{
        x: 140
        y: 0
        id:usbDebugPage1
        color:"#00000000"
        visible: false
        IControls.NonAnimationText_FontRegular{
            x: 10
            y: 150
            id: usbDebugTxt
            text: qsTr('在手机端Carlife, 沿以下操作路径， “首页》我的》设置”， 找\n到“USB调试设置”， 点击前往设置')
            color: "#FFFFFF"
            font.pixelSize: 38
        }
        Image {
            visible: true
            id: usbDebugImg
            x: 185
            y: 280
            source: "qrc:/resource-carlife/carlife_Android00.png"
        }
        Rectangle{
            id:page2Txt
            visible:false
            IControls.NonAnimationText_FontRegular{
                x: 240
                y: 312
                text: qsTr('点击设置')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 600
                y: 312
                text: qsTr('点击开发者选项')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 240
                y: 580
                text: qsTr('开启开发者选项')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 600
                y: 583
                text: qsTr('勾选USB调试')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
        }
        Rectangle{
            id:page3Txt
            visible:false
            IControls.NonAnimationText_FontRegular{
                x: 240
                y: 312
                text: qsTr('点击关于手机')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 600
                y: 312
                text: qsTr('多次点击版本号')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 240
                y: 582
                text: qsTr('返回设置开启')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
        }
        ExclusiveGroup { id: tabPositionGroup }
        Button{
            id: btn1
            activeFocusOnPress : true
            checkable : true
            checked : true
            exclusiveGroup: tabPositionGroup
            x: 320 ; y: 665
            width:30 ; height:30
            Text { id:btn1txt; x:7;  font.pointSize: 15; text: "1"; color:"white"}
            style: ButtonStyle {
               background: Rectangle {
                   color:"transparent"
               }
            }
            onClicked:{
                btn1Checked()
            }
        }
        Button{
            id:btn2
            activeFocusOnPress : true
            checkable : true
            checked : false
            exclusiveGroup: tabPositionGroup
            x: 485 ; y: 665
            width:30; height:30
            Text { id:btn2txt; x:7;  font.pointSize: 15; text: "2"; color:"#505050"}
            style: ButtonStyle {
               background: Rectangle {
                   color:"transparent"
               }
            }
            onClicked:{
                btn2Checked()
            }
        }
        Button {
            id:btn3
            activeFocusOnPress : true
            checkable : true
            checked : false
            exclusiveGroup: tabPositionGroup
            x: 650 ; y: 665
            width:30; height:30
            Text { id:btn3txt; x:7;  font.pointSize: 15; text: "3"; color:"#505050"}
            style: ButtonStyle {
               background: Rectangle {
                   color:"transparent"
               }
            }
            onClicked:{
                btn3Checked()
            }
        }
        Rectangle {
            x:0
            y:140
            width: 1000
            height: 500
            visible: true
            color: "transparent"
            id:ctrlPage
            MouseArea{
                anchors.fill: parent
                onPressed: {
                   mPressed = 1
                   xPos = mouse.x
                }

                onReleased: {
                    console.debug("[carlife] onReleased")
                    mPressed = 0
                }

                onMouseXChanged: {
                    console.debug("[carlife] onMouseXChanged, mouseX, xPos", mouse.x, xPos)

                    if(mouse.x - xPos > 50){
                        if(mPressed){
                            if(btn1.checked){
                                btn2Checked();
                            }
                            else if(btn2.checked){
                                btn3Checked()
                            }
                            else if(btn3.checked){
                                btn1Checked()
                            }
                            mPressed = 0
                        }
                    }
                    else if(xPos - mouse.x > 50){
                        if(mPressed){
                            if(btn1.checked){
                                btn3Checked();
                            }
                            else if(btn2.checked){
                                btn1Checked()
                            }
                            else if(btn3.checked){
                                btn2Checked()
                            }
                            mPressed = 0
                        }
                    }
                }
            }
        }
    }
}

