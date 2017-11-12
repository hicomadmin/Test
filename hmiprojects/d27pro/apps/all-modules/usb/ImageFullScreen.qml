import QtQuick 2.5
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import TheXImage 1.0
import TheXSettings 1.0

ICore.Page {
    id: root;
    anchors.fill: parent;

    property PictureCtl picturectl: HSPluginsManager.get('picturectl')

    property int isPause : 0    //control pictrue auto play

    property int imgIndex       //上个页面跳转时当时显示图片的索引
    property var imgModel       //图片资源列表(从上一个页面通过参数进行传递)
//    property int imgModelCnt:imgModel.count       //图片个数

    property real imgRotation1   //图片1的旋转度数
    property real imgRotation2   //图片2的旋转度数

    property real imgScale1:1    //图片1的缩放
    property real imgScale2:1    //图片2的缩放

    property real pressMouseX   //鼠标的x坐标
    property real pressMouseY   //鼠标的y坐标

    property url imgSource1     //滑动元素1的图片路径
    property url imgSource2     //滑动元素2的图片路径

    property real imgHeight1:root.height       //滑动元素1图片的高
    property real imgWidth1:root.width         //滑动元素1图片的宽

    property real imgHeight2:root.height       //滑动元素2图片的高
    property real imgWidth2:root.width         //滑动元素2图片的宽

    property bool compFlag:true      //判断当前是元素1显示还是元素2
    property bool flag_moveleftToright: false //是否从左滑到右即想要显示前一张图片
    property bool flag_moverightToleft: false //是否从右滑到左即想要显示后一张图片
    property bool flag_playleftToright: false
    property bool flag_playrightToleft: false

    property double trackId:0 //The source of the local page index
    property string trackPath //The source of the local page play path
    property var trackPlayRangen:0 //The source of the local page play range


    property SystemCtl system: HSPluginsManager.get('system')
    property int interfacemodel: system ? system.interfacemodel : 0
    property string playingsourcefile: picturectl ? picturectl.imagePath : ''
    property bool isInit:false

    function onCreate() {
        if(isInit) return;
        isInit = true;
        console.log("onCreate imgmodel:trackId:" + trackId + " trackPath:" + trackPath);
        if(trackPath) {
            picturectl.play(trackPath)
        } else {
            picturectl.play(trackId)
        }
        picturectl.setPlayRangen(trackPlayRangen)
        picturectl.setRandom(0,2)
    }
    onItemShown: {
        onCreate()
        _swtichComponentsShow(columnItem.visible)
        if(imgTimer.lastrunning) {
            imgTimer.lastrunning = false
            imgTimer.restart()
        }
    }

    onItemHiden: {
        if(imgTimer.running) {
            imgTimer.lastrunning = true
            imgTimer.stop()
        }
    }

    function swtichFullScreen() {
        _swtichComponentsShow(false)
    }

    function swtichComponentsShow() {
        _swtichComponentsShow(!columnItem.visible)
    }

    function _swtichComponentsShow(visible) {
        columnItem.visible = visible
        rowItem.visible = columnItem.visible
        application.multiApplications.appWindow.hideStatusBar = !columnItem.visible
//        flick1.interactive = visible
//        flick2.interactive = visible
    }

    function timerStop() {
        imgTimer.stop()
    }

    function timerRestart() {
        _timerRestart(5000)
    }

    function _timerRestart(interval) {
        imgTimer.interval = interval
        imgTimer.restart()
    }


    onPlayingsourcefileChanged: {
        //start animation
        if(flag_moveleftToright)
        {
            if(compFlag){
                imgSource2 = "file://" + playingsourcefile
                flick1_right_out.start()
                flick2_left_in.start()
                compFlag = !compFlag
            }
            else{
                imgSource1 = "file://" + playingsourcefile
                flick2_right_out.start()
                flick1_left_in.start()
                compFlag = !compFlag
            }

            flag_moveleftToright = false;

        }
        else if(flag_moverightToleft)
        {
            if(compFlag){
                imgSource2 = "file://" + playingsourcefile
                flick1_left_out.start()
                flick2_right_in.start()
                compFlag = !compFlag
            }
            else{
                imgSource1 = "file://" + playingsourcefile
                flick2_left_out.start()
                flick1_right_in.start()
                compFlag = !compFlag
            }

            flag_moverightToleft = false;

        }
        else if(flag_playleftToright)
        {
            if(compFlag){
                imgSource2 = "file://" + playingsourcefile
                flick1_right_out.start()
                flick2_left_in.start()

                imgWidth2 = root.width
                imgHeight2 = root.height
                imgScale2 = 1
                imgRotation2 = 0

                compFlag = !compFlag
            }
            else{
                imgSource1 = "file://" + playingsourcefile
                flick2_right_out.start()
                flick1_left_in.start()

                imgWidth1 = root.width
                imgHeight1 = root.height
                imgScale1 = 1
                imgRotation1 = 0

                compFlag = !compFlag
            }

            flag_playleftToright = false;

        }
        else if(flag_playrightToleft)
        {
            if(compFlag){
                imgSource2 = "file://" + playingsourcefile
                flick1_left_out.start()
                flick2_right_in.start()

                imgWidth2 = root.width
                imgHeight2 = root.height
                imgScale2 = 1
                imgRotation2 = 0

                compFlag = !compFlag
            }
            else{
                imgSource1 = "file://" + playingsourcefile
                flick2_left_out.start()
                flick1_right_in.start()

                imgWidth1 = root.width
                imgHeight1 = root.height
                imgScale1 = 1
                imgRotation1 = 0

                compFlag = !compFlag
            }

            flag_playrightToleft = false;

        }

    }

    //实现图片滑动元素1
    Flickable {
        id:flick1
        width:root.width
        height:root.height
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: imgWidth1*imgScale1
        contentHeight: imgHeight1*imgScale1

        IControls.MouseArea{
            //            anchors.fill: parent
            width: root.width
            height:root.height
            onPressed: {
                pressMouseX = mouseX
                pressMouseY = mouseY
                console.debug("press mousex:",mouseX,"mouseY:",mouseY)
            }
            onReleased: {
                //click event
                if((mouseX == pressMouseX) && (mouseY == pressMouseY)){
                    swtichComponentsShow()
                    console.debug("flick1 clicked")
                } else {       //slip event
                    if(!columnItem.visible){
                        if(mouseX - pressMouseX >=10){  //slip from left to right
                            flag_moveleftToright = true;
                            picturectl.previous();

                            console.debug("right move event")
                        }
                        else if(mouseX - pressMouseX <= -10){   //slip from right to left
                            flag_moverightToleft = true;
                            picturectl.next();

                            console.debug("left move event")
                        }
                    }
                }
                columnItem.visible ? timerStop() : timerRestart()
            }
        }

        Rectangle{
            width:root.width
            height:root.height
            color:"transparent"
            Image{
                id:img1
                width:imgWidth1
                height:imgHeight1
                fillMode: Image.PreserveAspectFit
                rotation: imgRotation1
                scale:imgScale1
                anchors.centerIn: parent
                source:imgSource1
                sourceSize.width: root.width
                sourceSize.height: root.height
            }
        }
    }


    //实现图片滑动元素2

    Flickable {
        id:flick2
        width:root.width
        height:root.height
        x:-width
        boundsBehavior: Flickable.StopAtBounds
        contentWidth: imgWidth2*imgScale2
        contentHeight: imgHeight2*imgScale2

        IControls.MouseArea{
            //            anchors.fill: parent
            width: root.width
            height:root.height
            onPressed: {
                pressMouseX = mouseX
                pressMouseY = mouseY
                console.debug("press mousex:",mouseX.toFixed(2),"mouseY:",mouseY)
            }
            onReleased: {
                //click event
                if((mouseX == pressMouseX) && (mouseY == pressMouseY)){
                    swtichComponentsShow()
                }
                else{       //slip event
                    if(!columnItem.visible){
                        if(mouseX - pressMouseX >=10){  //slip from left to right
                            flag_moveleftToright = true;
                            picturectl.previous();

                            console.debug("right move event")
                        }
                        else if(mouseX - pressMouseX <= -10){   //slip from right to left
                            flag_moverightToleft = true;
                            picturectl.next();

                            console.debug("left move event")
                        }
                    }
                }
                columnItem.visible ? timerStop() : timerRestart()
            }
        }

        Rectangle{
            width:root.width
            height:root.height
            color:"transparent"
            Image{
                id:img2
                width:imgWidth2
                height:imgHeight2
                fillMode: Image.PreserveAspectFit
                rotation: imgRotation2
                scale:imgScale2
                anchors.centerIn: parent
                source:imgSource2
                sourceSize.width: root.width
                sourceSize.height: root.height
            }
        }
    }
    //zoom and rotate
    Column{
        id:columnItem
        width:120
        height:350
        anchors.right: parent.right
        anchors.rightMargin: 29
        anchors.top: parent.top
        anchors.topMargin: (37 + application.multiApplications.appWindow.statusBar.height)
        spacing: 25
        IControls.IconButtonB{
            id: btn_playRotate
            width:120
            height:100
            themeColor: interfacemodel
            normalSource: "qrc:/resource-usb/Media_Icon_Rotate.png"

            onClicked: {
                //根据图片的宽高判断是否要进行显示时的宽高设置
                if(compFlag){
                    imgRotation1 -= 90
                    if((imgRotation1/90)%2==1){
                        imgWidth1 = root.height
                        imgHeight1 = root.width
                    }
                    else{
                        imgWidth1 = root.width
                        imgHeight1 = root.height
                    }
                }
                else{
                    imgRotation2 -= 90
                    if((imgRotation2/90)%2==1){
                        imgWidth2 = root.height
                        imgHeight2 = root.width
                    }
                    else{
                        imgWidth2 = root.width
                        imgHeight2 = root.height
                    }
                }
            }
        }

        IControls.IconButtonB{
            id: btn_playZoomIn
            themeColor: interfacemodel
            width:120
            height:100
            normalSource: (compFlag ? (imgScale1<1.9) : (imgScale2<1.9)) ? "qrc:/resource-usb/Media_Icon_Zoom+.png" : "qrc:/resource-usb/Media_Icon_Zoom+_null.png"

            onClicked: {
                if(compFlag){
                    if(imgScale1<1.9){
                        imgScale1 += 0.2
                    }
                }
                else{
                    if(imgScale2<1.9){
                        imgScale2 += 0.2
                    }
                }
            }
        }

        IControls.IconButtonB{
            id: btn_playZoomOut
            themeColor: interfacemodel
            width:120
            height:100
            normalSource: (compFlag ? (imgScale1 > 1) : (imgScale2 > 1)) ? "qrc:/resource-usb/Media_Icon_Zoom-.png" : "qrc:/resource-usb/Media_Icon_Zoom-_null.png"

            onClicked: {

                if(compFlag){
                    if(imgScale1 > 1){
                        imgScale1 -= 0.2
                    }
                }
                else{
                    if(imgScale2 > 1){
                        imgScale2 -= 0.2
                    }
                }
            }
        }
    }

    //previous and next and play
    Row{
        id:rowItem
        width: 1280
        height:147
        anchors.bottom: parent.bottom
        IControls.IconButtonB{
            id: btn_previous
            themeColor: interfacemodel
            width:424
            height:147
            normalSource: "qrc:/resource-usb/Media_Icon_Up_nml.png"

            onClicked: {
                flag_playleftToright = true;
                picturectl.previous();
            }
        }
        Image{
            width:8
            height:147
            source:"qrc:/resource-usb/Media_Button_Line.png"
        }

        IControls.IconButtonB{
            id: btn_playPause
            themeColor: interfacemodel
            width:416
            height:147
            normalSource: "qrc:/resource-usb/Media_Icon_Play_nml.png"

            onClicked: {
                switch(isPause)
                {
                case 0:
                    isPause = 1;
                    swtichFullScreen();
                    timerRestart();
                    _timerRestart(2000);
                    //console.debug("isPause:",isPause,"  picture start.........................");
                    break;
                case 1:
                    isPause = 0;
                    swtichFullScreen();
                    flag_playrightToleft = false;
                    timerStop();
                    //console.debug("isPause:",isPause,"  picture stop..........................");
                    break;
                }
            }
        }
        Image{
            width:8
            height:147
            source:"qrc:/resource-usb/Media_Button_Line.png"
        }
        IControls.IconButtonB{
            id: btn_next
            themeColor: interfacemodel
            width:424
            height:147
            normalSource: "qrc:/resource-usb/Media_Icon_Down_nml.png"

            onClicked: {
                flag_playrightToleft = true;
                picturectl.next();
            }
        }
    }

    //图片自动播放时用的定时器
    Timer {
        id:imgTimer
        interval: 5000
        repeat: true
        property bool lastrunning:false
        onTriggered: {
            if(interval==5000){
                interval = 2000
            }
            flag_playrightToleft = true;
            picturectl.next();

        }
    }

    //flick1的四种动画效果
    //从左进
    NumberAnimation{
        id:flick1_left_in
        target: flick1
        property:"x"
        from:-flick1.width
        to:0
    }

    //右进
    NumberAnimation{
        id:flick1_right_in
        target: flick1
        property:"x"
        from:flick1.width
        to:0
    }

    //左出
    NumberAnimation{
        id:flick1_left_out
        target: flick1
        property:"x"
        from:0
        to:-flick1.width
    }

    //右出
    NumberAnimation{
        id:flick1_right_out
        target: flick1
        property:"x"
        from:0
        to:flick1.width
    }

    //flick2的四种动画效果
    //从左进
    NumberAnimation{
        id:flick2_left_in
        target: flick2
        property:"x"
        from:-flick2.width
        to:0
    }

    //右进
    NumberAnimation{
        id:flick2_right_in
        target: flick2
        property:"x"
        from:flick2.width
        to:0
    }

    //左出
    NumberAnimation{
        id:flick2_left_out
        target: flick2
        property:"x"
        from:0
        to:-flick2.width
    }

    //右出
    NumberAnimation{
        id:flick2_right_out
        target: flick2
        property:"x"
        from:0
        to:flick2.width
    }

}

