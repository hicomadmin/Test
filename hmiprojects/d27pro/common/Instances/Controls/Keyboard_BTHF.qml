import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.2
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

//蓝牙电话数字键盘组件 长按数字0键输入“+”字符
//TextField中用不了NonAnimationText_FontRegular,需要后续自行在组件内修改字体

Item {
    id: root
    anchors.fill: parent

    property  int  posX
    property  bool bChangeZero: false    //是否需要将0改成+
    property  bool zeroLongPress: true    //是否0长按无效

    property alias output: output    //通过output.text获取输入框里的内容
    property alias keybd_posx: root.posX  //整个键盘距离窗口的左边距

    //signal confirm(string number)
    signal send(string character)


    property int themeColor

    //输入外边框
    Rectangle {
        id: inputBg
        width: 778
        height: 90
        border.color: themeColor == 0 ?"#20868b":(themeColor == 1? "#ff2200":"#986142")
        border.width: 3
        radius: 5
        color: "transparent"

        anchors.top: parent.top
        anchors.topMargin: 18   //110-92
        anchors.left: parent.left
        anchors.leftMargin: posX

    }


    //文本输入框
    TextField {
        id: output
        focus: true

        font.pixelSize: 50
       // font.family: "Helvetica"
        textColor: '#FFFFFF'


        //用不了,请修改上面的fontfamily
//        NonAnimationText_FontRegular {
//            font.pixelSize: 55
//            color: "#FFFFFF"
//        }

       maximumLength: 50

        anchors {
            top : inputBg.top
            topMargin: 4
            left: inputBg.left
            leftMargin: 3

        }
        horizontalAlignment: TextInput.AlignHCenter
        style: TextFieldStyle {
            background: Rectangle {
                color: 'transparent'
                implicitWidth: 664
                implicitHeight: 82
            }
        }
    }


    //退格键backSpace button
    UControls.ImageButton {
        id: backSpaceBtn
        width: 73
        height: 39
        anchors {
            top: inputBg.top
            topMargin: 25
            right: inputBg.right
            rightMargin: 35
        }
        normalSource: 'qrc:/resources-hf/Phone_Btn_ delete.png'
        pressingSource: (themeColor === 0)?'qrc:/resources-hf/Phone_Btn_ delete_sel.png' : ((themeColor===1)?'qrc:/resources-hf/Phone_Btn_delete_sel_o.png' : 'qrc:/resources-hf/Phone_Btn_ delete_sel_g.png')
//        focusingSource: 'qrc:/resources/Phone_Btn_ delete.png'
        disabledSource: 'qrc:/resources-hf/Phone_Btn_ delete.png'


        //单击退格键去除末位字符直到清空为止
        onClicked: {
            //add by gaojun -2017-1-13 --<begin> (can not del selected text)
            if ('' !== output.selectedText) {
                output.cut();
                return;
            }
            //--<end>
            if (output.length > 0 && output.cursorPosition-1>= 0) {
                output.select(output.cursorPosition,output.cursorPosition-1)
                output.cut();
            }
        }
        //长按清空文本
        onLongPressed: {
            if(output.length > 0 && output.cursorPosition-1>= 0) {
                output.select(output.cursorPosition,0);
                output.cut();
            }
        }
    }

    //    //"+" button加号按钮
    //    IControls.GradientTextButton_kb {
    //        id: plusBtn
    //        text:"+"
    //        anchors {
    //            top: keyboardbk.bottom
    //            topMargin: 30
    //            left: parent.left
    //            leftMargin: posX
    //        }

    //        onClicked: {
    //            output.insert(output.cursorPosition, "+");
    //        }
    //    }

    //    //confirm button确定按钮
    //    IControls.GradientTextButton_kb {
    //        id: rectBtn
    //        text: "confirm"
    //        anchors {
    //            top: keyboardbk.bottom
    //            topMargin: 30
    //            left: keyboardbk.left
    //            leftMargin: 500
    //        }
    //        onClicked: {
    //            confirm(output.text);
    //        }
    //    }

    //键盘网格背景keyboard background
    Image {
        id: keyboardbk
        source: themeColor == 0 ?"qrc:/resources-hf/Phone_Btn_number_box.png":themeColor == 1 ? "qrc:/resources-hf/Phone_Btn_number_box_o.png":"qrc:/resources-hf/Phone_Btn_number_box_g.png"
        anchors {
            top: inputBg.bottom
            topMargin: 12
            left: inputBg.left
            leftMargin: 3
        }
    }

    //数字键盘布局
    Grid {
        id: keyboardGrid
        anchors {
            top: inputBg.bottom
            topMargin: 16  //数字键盘与输入框的间隔,式样指定16
            left: inputBg.left
            leftMargin: 3
        }
        rows: 4
        rowSpacing: 4
        columns: 3
        columnSpacing: 4
        Repeater {
            id: keyRepeater
            model: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#']

            IControls.NumberButtonA {
                id:numkey
                themeColor: root.themeColor
                buttonText: modelData
                onPressed: {
                    if((modelData === "0")&& (output.length < output.maximumLength))
                        bChangeZero = true;
                    else
                        bChangeZero = false;

                        send(modelData);
                        output.insert(output.cursorPosition, modelData);

                }

                //长按0会先有按下0的事件，随着时间增加变成长按信号，因此需先把单击的0去掉再换成+
                onLongPressed: {
                    if(modelData === '0')
                    {
                        if(bChangeZero === true && zeroLongPress){
                            output.select(output.cursorPosition,output.cursorPosition-1)
                            output.cut();
                            send("+");
                            output.insert(output.cursorPosition,"+");
                        }
                    }

                }
            }

        }

    }
}

