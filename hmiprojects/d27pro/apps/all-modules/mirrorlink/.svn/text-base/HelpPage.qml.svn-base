import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Core' as UCore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import TheXMirrorlink 1.0

ICore.Page {
    id: helpPage

    property MirrorlinkCtl mirrorlink: HSPluginsManager.get('mirrorlink')
    property int page
    readonly property int _Help_Main_Page: 1
    readonly property int _Help_Usb_Page: 2
    readonly property int _Help_Support_Page: 3

    property int xPos
    property int mPressed : 0

    onItemShowing: {

    }

    onItemShown: {
        page = _Help_Main_Page
    }

    function showMainPage(cmd){
        if(true === cmd){
            page = _Help_Main_Page
        }

        helpTitle.visible = cmd;
        usbDebugLine.visible = cmd;
        phoneLine.visible = cmd;
        cableLine.visible = cmd;
        restartLine.visible = cmd;
        quit.visible = cmd
        division.visible = cmd
    }

    function showUsbDebugPage(cmd){
        if(true === cmd){
            page = _Help_Usb_Page
        }
        helpTitle.visible = cmd
        usbDebugPage.visible = cmd
    }

    function showSupportPage(cmd){
        if(true === cmd){
            page = _Help_Support_Page
        }
        helpTitle.visible = cmd
        supprtPage.visible = cmd
        quit.visible = cmd
    }

/*--------------------------------------main--------------------------------------*/
    Image {
        id: bg
        source: "qrc:/resource-mirrorlink/bg.png"
        Image {
            id: quit
            visible: true
            source: "qrc:/resource-mirrorlink/Connection help.png"
            x: 96
            y: 85
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.debug("mirrorlink page:", page)
                    if(_Help_Main_Page === page){
                        application.multiApplications.back()
                    }else if(_Help_Usb_Page === page){
                        showUsbDebugPage(false)
                        showMainPage(true)
                    }else if(_Help_Support_Page === page){
                        showSupportPage(false)
                        showMainPage(true)
                    }
                }
            }
        }
    }

    Rectangle{
        x: 140
        y: 80
        id:helpTitle
        width: 998
        height: 32
        color:"#00000000"
        visible: true
        Image {
            visible: true
            id:division
            source: "qrc:/resource-mirrorlink/division.png"
            x: 0
            y: 70
            width: parent.width
        }
        IControls.NonAnimationText_FontRegular{
            anchors.leftMargin: 10
            y: -5
            text: qsTr('连接帮助')
            color: "#FFFFFF"
            font.pixelSize: 45
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(_Help_Main_Page === page){
                        application.changePage('main');
                    }else if(_Help_Usb_Page === page){
                        showUsbDebugPage(false)
                        showMainPage(true)
                    }else if(_Help_Support_Page === page){
                        showSupportPage(false)
                        showMainPage(true)
                    }
                }
            }
        }
    }

    Rectangle{
        x: 140
        y: 80
        id:usbDebugHelpTitle
        width: 998
        height: 32
        color:"#00000000"
        visible: false
        Image {
            visible: true
            source: "qrc:/resource-mirrorlink/division.png"
            x: 0
            y: 70
            width: parent.width
        }
        IControls.NonAnimationText_FontRegular{
            anchors.leftMargin: 10
            text: qsTr('打开USB调试')
            color: "#FFFFFF"
            font.pixelSize: 45
        }
    }

    Rectangle{
        x: 140
        y: 190
        id:usbDebugLine
        width: 998
        height: 32
        color:"#00000000"
        visible: true
        Image {
            source: "qrc:/resource-mirrorlink/select.png"
            x: parent.width-30
            y: 10
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    showMainPage(false)
                    showUsbDebugPage(true)
                    quit.visible = false
                }
            }
        }
        Image {
            source: "qrc:/resource-mirrorlink/division.png"
            x: 0
            y: 90
            width: parent.width
        }
        IControls.NonAnimationText_FontRegular{
            anchors.leftMargin: 10
            text: qsTr('如何开启 “USB调试”')
            color: "#FFFFFF"
            font.pixelSize: 45
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    showMainPage(false)
                    showUsbDebugPage(true)
                    quit.visible = false
                }
            }
        }
    }

    Rectangle{
        x: 140
        y: 310
        id:phoneLine
        width: 998
        height: 32
        color:"#00000000"
        visible: true
        Image {
            visible: true
            source: "qrc:/resource-mirrorlink/select.png"
            x: parent.width-30
            y: 20
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    showMainPage(false)
                    showSupportPage(true)
                }
            }
        }
        Image {
            visible: true
            source: "qrc:/resource-mirrorlink/division.png"
            x: 0
            y: 90
            width: parent.width
        }
        IControls.NonAnimationText_FontRegular{
            anchors.leftMargin: 10
            text: qsTr('请使用支持标准Mirrorlink的手机')
            color: "#FFFFFF"
            font.pixelSize: 45
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    showMainPage(false)
                    showSupportPage(true)
                }
            }
        }
    }

    Rectangle{
        x: 140
        y: 425
        id:cableLine
        width: 998
        height: 32
        color:"#00000000"
        visible: true
        Image {
            visible: true
            source: "qrc:/resource-mirrorlink/division.png"
            x: 0
            y: 90
            width: parent.width
        }
        IControls.NonAnimationText_FontRegular{
            anchors.leftMargin: 10
            text: qsTr('检查数据线并重新连接')
            color: "#FFFFFF"
            font.pixelSize: 45
        }
    }

    Rectangle{
        x: 140
        y: 540
        id:restartLine
        width: 998
        height: 32
        color:"#00000000"
        visible: true
        Image {
            visible: true
            source: "qrc:/resource-mirrorlink/division.png"
            x: 0
            y: 90
            width: parent.width
        }
        IControls.NonAnimationText_FontRegular{
            anchors.leftMargin: 10
            text: qsTr('尝试重启手机再次连接')
            color: "#FFFFFF"
            font.pixelSize: 45
        }
    }
/*--------------------------------------usbDebugPage--------------------------------------*/
    Rectangle{
        x: 0
        y: 0
        id:usbDebugPage
        width: parent.width
        height: parent.height
        color:"#00000000"
        visible: false
        Image {
            id: quitUsbDebug
            visible: true
            source: "qrc:/resource-mirrorlink/Connection help.png"
            x: 96
            y: 85
            IControls.MouseArea{
                anchors.fill: parent
                onClicked: {
                    showUsbDebugPage(false)
                    showMainPage(true)
                }
            }
        }
        IControls.NonAnimationText_FontRegular{
            x: 160
            y: 170
            id:txtTipPage1
            visible: true
            text: qsTr('你可以在手机系统设置，沿以下操作路径，找到该操作项')
            color: "#FFFFFF"
            font.pixelSize: 35
        }
        IControls.NonAnimationText_FontRegular{
            x: 160
            y: 30
            id:txtTipPage2
            visible: false
            text: qsTr('如果设置中找不到“开发者选项”， 操作如下')
            color: "#FFFFFF"
            font.pixelSize: 35
        }
        ExclusiveGroup { id: tabPositionGroup }
        Button{
            id: btn1
            activeFocusOnPress : true
            checkable : true
            checked : true
            exclusiveGroup: tabPositionGroup
            Text { id:btn1txt; x:7; font.pointSize: 15; text: "1"; color:"white"}
            x: 550
            y: 660
            width:30
            height:30
            style: ButtonStyle {
               background: Rectangle {
                   color:"transparent"
               }
            }
            onClicked:{
                androidPage1.visible = true
                androidPage2.visible = false
                checked = true
                txtTipPage1.visible = true
                txtTipPage2.visible = false
                quitUsbDebug.visible = true
                helpTitle.visible = true
                btn1txt.color="white"
                btn2txt.color="#505050"
            }
        }
        Button{
            id:btn2
            activeFocusOnPress : true
            checkable : true
            checked : false
            exclusiveGroup: tabPositionGroup
            Text { id:btn2txt; x:7;  font.pointSize: 15; text: "2"; color:"#505050"}
            x: 700 ; y: 660
            width:30; height:30
            style: ButtonStyle {
               background: Rectangle {
                   color:"transparent"
               }
            }
            onClicked:{
                androidPage2.visible = true
                androidPage1.visible = false
                checked = true
                txtTipPage1.visible = false
                txtTipPage2.visible = true
                quitUsbDebug.visible = false
                helpTitle.visible = false
                btn2txt.color="white"
                btn1txt.color="#505050"
            }
        }
        Rectangle{
            x:82
            y:250
            id:androidPage1
            visible:true
            Image{
                visible : true
                source: "qrc:/resource-mirrorlink/MirrorLink_Android.png"
            }
            IControls.NonAnimationText_FontRegular{
                x: 35
                y: 200
                text: qsTr('点击设置')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 327
                y: 200
                text: qsTr('点击开发者选项')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 620
                y: 200
                text: qsTr('开启开发者选项')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 915
                y: 200
                text: qsTr('勾选USB调试')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
        }

        Rectangle{
            x:340
            y:110
            id:androidPage2
            visible:false
            Image{
                visible : true
                source: "qrc:/resource-mirrorlink/mirrorlink_Android2.png"
            }
            IControls.NonAnimationText_FontRegular{
                x: 40
                y: 195
                text: qsTr('点击关于手机')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 400
                y: 195
                text: qsTr('多次点击版本号')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
            IControls.NonAnimationText_FontRegular{
                x: 40
                y: 465
                text: qsTr('返回设置开启')
                color: "#FFFFFF"
                font.pixelSize: 30
            }
        }
        Rectangle{
            x:0
            y:150
            width: parent.width
            height: 500
            color: "transparent"
            MouseArea{
                anchors.fill: parent
                onPressed: {
                   console.debug("[Mirrorlink] onPressed")
                   mPressed = 1
                   xPos = mouse.x
                }

                onReleased: {
                    console.debug("[Mirrorlink] onReleased")
                    mPressed = 0
                }

                onMouseXChanged: {
                    console.debug("[Mirrorlink] onMouseXChanged, mouseX, xPos", mouse.x, xPos)

                    if(mouse.x - xPos > 50 || xPos - mouse.x > 50){
                        if(mPressed){
                            if(btn1.checked){
                                btn2.checked = true
                                androidPage2.visible = true
                                androidPage1.visible = false
                                txtTipPage1.visible = false
                                txtTipPage2.visible = true
                                quitUsbDebug.visible = false
                                helpTitle.visible = false
                                btn2txt.color="white"
                                btn1txt.color="#505050"
                            }
                            else{
                                btn1.checked = true
                                androidPage1.visible = true
                                androidPage2.visible = false
                                txtTipPage1.visible = true
                                txtTipPage2.visible = false
                                quitUsbDebug.visible = true
                                helpTitle.visible = true
                                btn1txt.color="white"
                                btn2txt.color="#505050"
                            }
                            mPressed = 0
                        }
                    }
                }
            }
        }
    }
/*--------------------------------------ml support--------------------------------------*/
    Rectangle{
        x: 0
        y: 0
        id:supprtPage
        width: parent.width
        height: parent.height
        color:"#00000000"
        visible: false
        IControls.NonAnimationText_FontRegular{
            x: 160
            y: 200
            text: qsTr('请查看如下支持Ｍirrorlink的手机：')
            color: "#FFFFFFFF"
            font.pixelSize: 43
        }
        IControls.NonAnimationText_FontRegular{
            x: 160
            y: 253
            text: qsTr('Samsung Galaxy S7, S7 edge, A9, A9 pro, A8, A7,')
            color: "#FFFFFFFF"
            font.pixelSize: 43
        }
        IControls.NonAnimationText_FontRegular{
            x: 160
            y: 306
            text: qsTr('A5, A3')
            color: "#FFFFFFFF"
            font.pixelSize: 43
        }
        IControls.NonAnimationText_FontRegular{
            x: 160
            y: 359
            text: qsTr('HTC One A9, One M9+, Desire 820, One E9')
            color: "#FFFFFFFF"
            font.pixelSize: 43
        }
        IControls.NonAnimationText_FontRegular{
            x: 160
            y: 412
            text: qsTr('Sony Xperia™ Z5, Z3, Z2, Z1')
            color: "#FFFFFFFF"
            font.pixelSize: 43
        }
        IControls.NonAnimationText_FontRegular{
            x: 160
            y: 465
            text: qsTr('LG G4')
            color: "#FFFFFFFF"
            font.pixelSize: 43
        }
    }
}
