import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

Rectangle {
    id: root
    property int themeColor: 0
    width: 1280
    height: 720
    Image {
        id: bg
        source: themeColor == 0 ?"qrc:/resources/BG.png":"qrc:/resources/BG_o.png"
    }
    property real norMarginS: 6
    property real otherMarginS: 3

    Rectangle{
        id:upRect
        width: parent.width
        height: 125+52+39
        color: "#00000000"

        Rectangle{
            id:textRect
            x:42
            y:39
            width: 1207
            height: 125
            border.width :4
            border.color: "#4a4f53"
            color: "#00000000"
            TextInput{
                id:inputText
                anchors.verticalCenter: parent.verticalCenter
                width: 1207-checkBtn.width - 6
                height: 36
                font.pixelSize: 36
                color: "#FFFFFF"
            }

            UControls.ImageButton{
                id:checkBtn
                anchors.left: inputText.right
                width: 223
                height: 84

                anchors.verticalCenter: parent.verticalCenter
                normalSource: "qrc:/resources/Keypad_btn_nml.png"
                pressingSource: "qrc:/resources/Keypad_btn_exe.png"
                Text {
                    id: queding
                    anchors.centerIn: parent
                    text: qsTr("确定")
                    font.pixelSize: 36
                    color:"#ffffff"
                }
            }
        }

    }

    Rectangle{
        id:downRect
        x:0
        y:39+125+52
        width: parent.width
        height: parent.height-y//504
        color: "#00000000"
        Rectangle{
            id:textSelectRect
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width
            height: 60
            color: "#ffffff"
            opacity: 0.1

            TextInput{
                id:showText
                width: parent.width-110
                height: parent.height
            }
        }
        IControls.IconButton_KeyPad{
            id:hideButton
            anchors.top: textSelectRect.top
            anchors.right: parent.right
            themeColor: root.themeColor
            width: 110
            height: 60
            source: "qrc:/resources/Keypad_icon_hide.png"
        }
        Rectangle{
            id:keysGridRect
            anchors.top:textSelectRect.bottom
            anchors.left: parent.left
            anchors.topMargin: 3
            IControls.TextButton_KeyPad{
                id:q_key

                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: root.themeColor
                text: "q"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"q")
                }
            }
            IControls.TextButton_KeyPad{
                id:w_key

                anchors.left: q_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: root.themeColor
                text: "w"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"w")
                }
            }
            IControls.TextButton_KeyPad{
                id:e_key
                themeColor: root.themeColor
                anchors.left: w_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6

                text: "e"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"e")
                }
            }
            IControls.TextButton_KeyPad{
                id:r_key
                themeColor: root.themeColor
                anchors.left: e_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6

                text: "r"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"r")
                }
            }
            IControls.TextButton_KeyPad{
                id:t_key
                themeColor: root.themeColor
                anchors.left: r_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6

                text: "t"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"t")
                }
            }
            IControls.TextButton_KeyPad{
                id:y_key
                themeColor: root.themeColor
                anchors.left: t_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6

                text: "y"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"y")
                }
            }
            IControls.TextButton_KeyPad{
                id:u_key
                themeColor: root.themeColor
                anchors.left: y_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6

                text: "u"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"u")
                }
            }
            IControls.TextButton_KeyPad{
                id:i_key
                themeColor: root.themeColor
                anchors.left: u_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6

                text: "i"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"i")
                }
            }
            IControls.TextButton_KeyPad{
                id:o_key
                themeColor: root.themeColor
                anchors.left: i_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6

                text: "o"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"o")
                }
            }
            IControls.TextButton_KeyPad{
                id:p_key
                themeColor: root.themeColor
                anchors.left: o_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6

                text: "p"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"p")
                }
            }
            IControls.TextButton_KeyPad{
                id:a_key
                themeColor: root.themeColor
                anchors.left: parent.left
                anchors.leftMargin: 67
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "a"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"a")
                }
            }
            IControls.TextButton_KeyPad{
                id:s_key
                themeColor: root.themeColor
                anchors.left: a_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "s"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"s")
                }
            }
            IControls.TextButton_KeyPad{
                id:d_key
                themeColor: root.themeColor
                anchors.left: s_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "d"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"d")
                }
            }
            IControls.TextButton_KeyPad{
                id:f_key
                themeColor: root.themeColor
                anchors.left: d_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "f"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"f")
                }
            }
            IControls.TextButton_KeyPad{
                id:g_key
                themeColor: root.themeColor
                anchors.left: f_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "g"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"g")
                }
            }
            IControls.TextButton_KeyPad{
                id:h_key
                themeColor: root.themeColor
                anchors.left: g_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "h"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"h")
                }
            }
            IControls.TextButton_KeyPad{
                id:j_key
                themeColor: root.themeColor
                anchors.left: h_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "j"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"j")
                }
            }
            IControls.TextButton_KeyPad{
                id:k_key
                themeColor: root.themeColor
                anchors.left: j_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "k"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"k")
                }
            }
            IControls.TextButton_KeyPad{
                id:l_key
                themeColor: root.themeColor
                anchors.left: k_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6

                text: "l"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"l")
                }
            }
            IControls.IconButton_KeyPad{
                id:up_key
                width: 122
                height: 80
                themeColor: root.themeColor
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                source:"qrc:/resources/Keypad_icon_switch.png"

                onClicked: {
                    inputText.insert(inputText.cursorPosition,"up")
                }
                //                text: "up"
            }
            IControls.TextButton_KeyPad{
                id:z_key
                themeColor: root.themeColor
                anchors.left: up_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6

                text: "z"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"z")
                }
            }
            IControls.TextButton_KeyPad{
                id:x_key
                themeColor: root.themeColor
                anchors.left: z_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6

                text: "x"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"c")
                }
            }
            IControls.TextButton_KeyPad{
                id:c_key
                themeColor: root.themeColor
                anchors.left: x_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6

                text: "c"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"c")
                }
            }
            IControls.TextButton_KeyPad{
                id:v_key
                themeColor: root.themeColor
                anchors.left: c_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6

                text: "v"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"v")
                }
            }
            IControls.TextButton_KeyPad{
                id:b_key
                themeColor: root.themeColor
                anchors.left: v_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6

                text: "b"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"b")
                }
            }
            IControls.TextButton_KeyPad{
                id:n_key
                themeColor: root.themeColor
                anchors.left: b_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6

                text: "n"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"n")
                }
            }
            IControls.TextButton_KeyPad{
                id:m_key
                themeColor: root.themeColor
                anchors.left: n_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6

                text: "m"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"m")
                }
            }
            IControls.IconButton_KeyPad{
                id:del_key
                width: 122*2+6
                height: 80
                anchors.left: m_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                themeColor: root.themeColor
                source:"qrc:/resources/Keypad_icon_del.png"
                onClicked: {
//                    inputText.insert(inputText.cursorPosition,"del")
                    inputText.remove(inputText.cursorPosition-1,inputText.cursorPosition)
                }

            }
            IControls.TextButton_KeyPad{
                id:num_key
                themeColor: root.themeColor
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6

                text: "123"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"q")
                }
            }
            IControls.TextButton_KeyPad{
                id:pinyin_key
                width: 122+61+2
                anchors.left: num_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: root.themeColor
                text: "拼/EN/手"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"拼/EN/手")
                }
            }
            IControls.TextButton_KeyPad{
                id:ask_key
                themeColor: root.themeColor
                anchors.left: pinyin_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6

                text: "?"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"?")
                }
            }
            IControls.IconButton_KeyPad{
                id:space_key
                width: 122*2+6
                height: 80
                anchors.left: ask_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: root.themeColor
                source:"qrc:/resources/Keypad_icon_Space1.png"
                onClicked: {
                    inputText.insert(inputText.cursorPosition," ")
                }

            }
            IControls.TextButton_KeyPad{
                id:duhao_key
                themeColor: root.themeColor
                anchors.left: space_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6

                text: ".."
                onClicked: {
                    inputText.insert(inputText.cursorPosition,",")
                }
            }
            IControls.TextButton_KeyPad{
                id:gantanhao_key
                width: 122+61+2
                anchors.left: duhao_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: root.themeColor
                text: "!#"
                onClicked: {
                    inputText.insert(inputText.cursorPosition,"!")
                }
            }
            IControls.IconButton_KeyPad{
                id:enter_key
                width: 122*2+6
                height: 80
                anchors.left: gantanhao_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: root.themeColor
                source:"qrc:/resources/Keypad_icon_enter.png"

                onClicked: {
                    inputText.insert(inputText.cursorPosition,"<br\>")
                }
            }


        }
    }
}

