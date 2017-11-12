import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/Core' as UCore
import TheXSettings 1.0
import TheXInputMethod 1.0

ICore.Page {
    id: virtualKBPage
    property real norMarginS: 6
    property real otherMarginS: 3
    property bool symbolKBZhEn:false      //false 表示中文
    property bool pinyinKBZhEn:false      //false 表示中文
    property bool letterCase:true        //true 表示小写
    property bool hideKeyBoardFlag:false  //false 表示不隐藏
    property bool pinyinDelFlag:false    //false 表示非中文时的删除
    /* BEGIN by Xiong wei, 2017.2.8
     * hide keyboard save showText text and restore text
    */
    property bool isSave:false
    property var saveText
    /* End by Xiong wei, 2017.2.8
     * hide keyboard save showText text and restore text
    */
    property alias txt: inputText.text
    property int themeColor: HSPluginsManager.get('system').interfacemodel
    property color txtColor: themeColor == 0 ? "#3699B0":(themeColor == 1?"#2d0d07":"#ffeaa2")

    signal complete(var txt)

    ListModel{
        id:phraseModel
    }

    InputMethodCtl{
        id:inputMethodPlugin
        onContextListChanged:{
            phraseModel.clear()
            for(var conIndex = 0;conIndex < contextList.length;++conIndex){
                phraseModel.append({"phrase":contextList[conIndex]})
            }
        }
    }

    Rectangle {
        width: 1280
        height: 720
        Image {
            id: bg
            source: themeColor == 0?"qrc:/resources/BG.png":(themeColor == 1?"qrc:/resources/BG_o.png":"qrc:/resources/BG_g.png")
        }




        //文本编辑框开始
        Rectangle{
            id:textRect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent
            anchors.topMargin: 23
            width: 1207
            height: 122
            border.width :4
            border.color: themeColor == 0?"#4a4f53":(themeColor == 1?"#bf5646":"#130802")
            color: "#00000000"
            TextInput{
                id:inputText
                anchors.left:parent.left
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width-checkBtn.width - 10
                height: 36
                font.pixelSize: 36
                focus: ((showText.text.length >0) && (downRect.visible) && (!pinyinKBZhEn))? false:true
                cursorVisible: focus
                color: "#FFFFFF"
                maximumLength: 32
                onTextChanged: {
                       console.debug("onTextChanged txt:",txt)
                       var limitcount = 0;
                       var limitlength = 0;
                       for(var i=0;i<txt.length;i++){
                           if(/^[\u4e00-\u9fa5]+$/i.test(txt.charAt(i))){
                               limitcount = limitcount+2;
                           }
                           else{
                               limitcount++;
                           }
                           limitlength++;
                           console.debug("onTextChanged limitlength:",limitlength)
                           console.debug("onTextChanged limitcount:",limitcount)
                           if(limitcount>=32){
                               inputText.remove(limitlength,inputText.cursorPosition)
                               break;
                           }
                       }
                }
            }

            UControls.ImageButton{
                id:checkBtn
                anchors.left: inputText.right
                anchors.right: parent.right
                anchors.rightMargin: 10
                width: 207
                height: 78

                anchors.verticalCenter: parent.verticalCenter
                normalSource: themeColor ==0 ?"qrc:/resources/Keypad_Completed_nml.png":(themeColor == 1?"qrc:/resources/Keypad_Completed_nml_o.png":"qrc:/resources/Keypad_Completed_nml.png")
                pressingSource: themeColor ==0 ?"qrc:/resources/Keypad_Completed_exe.png":(themeColor == 1?"qrc:/resources/Keypad_Completed_exe_o.png":"qrc:/resources/Keypad_Completed_exe_g.png")
                Text {
                    id: finish
                    anchors.centerIn: parent
                    text: qsTr("完成")
                    font.pixelSize: 36
                    color:"#ffffff"
                }
                /* BEGIN by Xiong wei, 2016.12.14
                 * Set Bluetooth default name input cannot be empty
                */
                enabled: (inputText.text == "") ? false : true
                //End by xiongwei 2016.12.14
                onClicked: {
                    complete(txt)
                }
            }
        }//文本编辑框结束

        //中文时显示字词部分开始
        Rectangle{
            id:textSelectRect
            anchors.left: parent.left
            anchors.top: textRect.bottom
            anchors.topMargin: 50
            width: parent.width
            height: 95
            
            visible:true

            Rectangle{
                id:inputShowRect
                width:parent.width -110
                height:parent.height
                visible: true
//                gradient:Gradient {
//                    GradientStop { position: 0.0; color: themeColor == 0 ? "#2b353b":(themeColor == 1? "#bf5646" :" ") }
//                    GradientStop { position: 1.0; color: themeColor == 0 ? "#1e282d":(themeColor == 1? "#59241c" :" ") }
//                }
                color:themeColor == 0?"#1c2327":(themeColor == 1?"#bf5646":"#986142")
//                color: "#1c2327"
                TextInput{
                    id:showText
                    visible: downRect.visible && !pinyinKBZhEn
                    anchors.left: parent.left
                    anchors.leftMargin: 62 + prePageBtn.width
                    width: parent.width
                    height: (parent.height-4)/2 + 5
                    font.pointSize: 30
                    color:"#ffffff"
                    readOnly: true

                    onCursorPositionChanged: {
                        if(cursorPosition != length){
                            cursorPosition = length
                        }
                    }

                    onTextChanged: {
                        console.debug("text change test")
                        if(pinyinDelFlag){
                            // del one key
                            inputMethodPlugin.backOneKey()
                        }
                        else{
                            // input one key
                            if(text.length > 0 && !isSave){
                               inputMethodPlugin.inputOneKey(text.charAt(text.length-1))
                               console.debug("input one key ",text.charAt(text.length-1))
                                                          }
                        }
                        pinyinDelFlag = false
                    }
                }

                IControls.IconButton_KeyPad{
                    id:prePageBtn
                    visible: downRect.visible && !pinyinKBZhEn
                    anchors.left: parent.left
                    anchors.leftMargin: 27
                    width:parent.height
                    height:parent.height
                    themeColor: virtualKBPage.themeColor
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/resources/prevpage_left.png"
//                    bgGradient:Gradient {
//                          GradientStop { position: 0.0; color: "#1c2327" }
//                          GradientStop { position: 1.0; color: "#1c2327" }
//                          }
                    onClicked: {
                        inputMethodPlugin.getPrevPhrases()
                    }
                }

                Rectangle{
                    id:line
                    anchors.left:prePageBtn.right
                    anchors.leftMargin: 35
                    anchors.verticalCenter: parent.verticalCenter
                    width:parent.width - 150 - 45
                    height:1
                    color:"#ffffff"
                }

                IControls.IconButton_KeyPad{
                    id:nextPageBtn
                    visible: downRect.visible && !pinyinKBZhEn
                    width:parent.height
                    height:parent.height
                    anchors.right: parent.right
                    anchors.rightMargin: 28
                    themeColor: virtualKBPage.themeColor
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/resources/nextpage_right.png"
//                    bgGradient:Gradient {
//                          GradientStop { position: 0.0; color: "#1c2327" }
//                          GradientStop { position: 1.0; color: "#1c2327" }
//                          }
                    onClicked: {
                        inputMethodPlugin.getNextPhrases()
                    }
                }

                Rectangle{
                    id:phraseRect
                    visible: downRect.visible && !pinyinKBZhEn
                    height:(parent.height-4)/2
                    width:parent.width - 250
                    anchors.left: parent.left
                    anchors.leftMargin: 62 + prePageBtn.width
                    anchors.top: line.bottom
                    anchors.topMargin: 2
                    color:"#00000000"
                    Row{
                        anchors.fill: parent
                        spacing: 20
                        Repeater{
                            model:phraseModel
                            Rectangle{
                                height:parent.height
                                width:/*parent.height/5*/phraseText.contentWidth+10
                                color:"#00000000"
                                Text{
                                    id:phraseText
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    width:contentWidth
                                    height:parent.height
                                    color:"#ffffff"
                                    font.pointSize: 28
                                    verticalAlignment: Text.AlignVCenter
                                    text:phrase

                                    IControls.MouseArea{
                                        anchors.fill:parent
                                        onPressed: {
                                            phraseText.color = "#3699B0"
                                        }

                                        onReleased: {
                                            phraseText.color = "#ffffff"
                                            inputText.insert(inputText.cursorPosition,phraseText.text)
                                            inputMethodPlugin.commitPhrase(index)
                                            showText.text = ""
                                            //call plugin to update data
                                        }
                                    } // end of MouseArea
                                }

                            }
                        } //end of Repeater
                    } //end of RowLayout
                }  //end of phraseRect
            }  //end of inputShowRect

            
            IControls.IconButton_KeyPad{
                height:95
                width:110
                bgRadius:0
                anchors.top: parent.top
                anchors.left: phraseRect.right
                anchors.right: parent.right
                themeColor: virtualKBPage.themeColor
                source: "qrc:/resources/Keypad_icon_hide.png"
//                bgGradient:Gradient {
//                    GradientStop { position: 0.0; color: themeColor == 0 ? "#303c41":(themeColor == 1? "#924336" :"#986142") }
//                    GradientStop { position: 1.0; color: themeColor == 0 ? "#303c41":(themeColor == 1? "#924336" :"#986142") }
//                }

                onClicked: {
                    /* BEGIN by Xiong wei, 2017.2.8
                     * hide keyboard save showText text and restore text
                    */
                    if(!isSave) saveText = showText.text.toString()
                    console.debug("keypad hide save the text "+saveText)
                    /* End by Xiong wei, 2017.2.8
                     * hide keyboard save showText text and restore text
                    */
                    if(!hideKeyBoardFlag){
                        downRect.visible = false
                        numKeyBoard.visible = false
                        symbolKeyBoard.visible = false
                        isSave = true
                    }
                    else{
                        numKeyBoard.visible = false
                        symbolKeyBoard.visible = false
                        downRect.visible = true
                        showText.text = saveText
                        isSave = false
                    }
                    hideKeyBoardFlag = !hideKeyBoardFlag
                }
            }


        }  //中文时显示字词部分结束

    //拼/EN 部分  开始
    Rectangle{
        id:downRect
        anchors.top: textSelectRect.bottom
        anchors.topMargin: 9
        anchors.bottom: parent.bottom
        width: parent.width
        color: "#00000000"
        visible:true


            Rectangle{
                id:keysGridRect
                anchors.top:textSelectRect.bottom
                anchors.left: parent.left
                anchors.topMargin: 3
                IControls.TextButton_KeyPad{
                    id:q_key
                    width:122
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.top:parent.top
                    anchors.topMargin: 6
                    themeColor: virtualKBPage.themeColor

                text: letterCase ? "q" : "Q"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:w_key
                width:122
                anchors.left: q_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor

                text: letterCase ? "w" : "W"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:e_key
                width:122
                anchors.left: w_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "e" : "E"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:r_key
                width:122
                anchors.left: e_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "r" : "R"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:t_key
                width:122
                anchors.left: r_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "t" : "T"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:y_key
                width:122
                anchors.left: t_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "y" : "Y"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:u_key
                width:122
                anchors.left: y_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "u" : "U"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:i_key
                width:122
                anchors.left: u_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "i" : "I"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:o_key
                width:122
                anchors.left: i_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "o" : "O"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:p_key
                width:122
                anchors.left: o_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "p" : "P"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:a_key
                width:122
                anchors.left: parent.left
                anchors.leftMargin: 67
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "a" : "A"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:s_key
                width:122
                anchors.left: a_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "s" : "S"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:d_key
                width:122
                anchors.left: s_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "d" : "D"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:f_key
                width:122
                anchors.left: d_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "f" : "F"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:g_key
                width:122
                anchors.left: f_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "g" : "G"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:h_key
                width:122
                anchors.left: g_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "h" : "H"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:j_key
                width:122
                anchors.left: h_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "j" : "J"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:k_key
                width:122
                anchors.left: j_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "k" : "K"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:l_key
                width:122
                anchors.left: k_key.right
                anchors.leftMargin: 6
                anchors.top:q_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "l" : "L"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.IconButton_KeyPad{
                id:up_key
                width: 122
                height: 80
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                source:"qrc:/resources/Keypad_icon_switch.png"
                themeColor: virtualKBPage.themeColor
                onReleased: {
                    letterCase = !letterCase
                }
            }
            IControls.TextButton_KeyPad{
                id:z_key
                width:122
                anchors.left: up_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "z" : "Z"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:x_key
                width:122
                anchors.left: z_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "x" : "X"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:c_key
                width:122
                anchors.left: x_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "c" : "C"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:v_key
                width:122
                anchors.left: c_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "v" : "V"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:b_key
                width:122
                anchors.left: v_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "b" : "B"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:n_key
                width:122
                anchors.left: b_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "n" : "N"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
                }
            }
            IControls.TextButton_KeyPad{
                id:m_key
                width:122
                anchors.left: n_key.right
                anchors.leftMargin: 6
                anchors.top:a_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: letterCase ? "m" : "M"
                onReleased: {
                    if(pinyinKBZhEn){
                        inputText.insert(inputText.cursorPosition,text)
                    }
                    else{
                        showText.insert(showText.cursorPosition,text)
                    }
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
                themeColor: virtualKBPage.themeColor
                    source:"qrc:/resources/Keypad_icon_del.png"
                    onReleased: {
                        if(pinyinKBZhEn){
                            inputText.remove(inputText.cursorPosition-1,inputText.cursorPosition)
                        }
                        else{
                            if(inputText.focus){
                                pinyinDelFlag = false
                                inputText.remove(inputText.cursorPosition-1,inputText.cursorPosition)
                            }
                            else{
                                pinyinDelFlag = true
                                showText.remove(showText.cursorPosition-1,showText.cursorPosition)
                            }
                        }
                    }
                    onLongPressed: {
                        if(!pinyinKBZhEn) {
                            inputMethodPlugin.commitPhrase(0)
                            showText.remove(0,showText.cursorPosition)
                        }
                        inputText.remove(0,inputText.cursorPosition)
                    }

            }
            IControls.TextButton_KeyPad{
                id:num_key
                width:122
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "123"
                onReleased: {
                    downRect.visible = false
                    numKeyBoard.visible = true
                    symbolKeyBoard.visible = false
                }
            }
            IControls.TextButton_KeyPad{
                id:pinyin_key
                width: 122+61+2
                anchors.left: num_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                Text{
                    id:pinyin_color_text1
                    anchors.right: pinyin_color_text2.left
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 36
                    color: !pinyinKBZhEn ? txtColor:"#ffffff"
                    text:qsTr("拼")
                }
                Text{
                    id:pinyin_color_text2
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 36
                    color:"#ffffff"
                    text:"/"
                }

                Text{
                    id:pinyin_color_text3
                    anchors.left: pinyin_color_text2.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 36
                    color: pinyinKBZhEn ? txtColor:"#ffffff"
                    text:"EN"
                }
                onReleased: {
                    pinyinKBZhEn = !pinyinKBZhEn
                }
            }
            IControls.TextButton_KeyPad{
                id:ask_key
                width:122
                anchors.left: pinyin_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: pinyinKBZhEn ? "," : "，"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
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
                themeColor: virtualKBPage.themeColor
                source:"qrc:/resources/Keypad_icon_Space1.png"
                onReleased: {
                    inputText.insert(inputText.cursorPosition," ")
                }

            }
            IControls.TextButton_KeyPad{
                id:duhao_key
                width:122
                anchors.left: space_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: pinyinKBZhEn ? "." : "。"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:gantanhao_key
                width: 122+61+2
                anchors.left: duhao_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: '?!#'
                onReleased: {
                    downRect.visible = false
                    numKeyBoard.visible = false
                    symbolKeyBoard.visible = true
                }
            }
                IControls.TextButton_KeyPad{
                id:enter_key
                width: 122*2+6
                height: 80
                anchors.left: gantanhao_key.right
                anchors.leftMargin: 6
                anchors.top:z_key.bottom
                anchors.topMargin: 6
                text:qsTr("确定")
                themeColor: virtualKBPage.themeColor
                onReleased: {
					if(pinyinKBZhEn){
                       complete(txt)
                    }
                        else{
                            if(phraseModel.count > 0){
                                inputText.insert(inputText.cursorPosition,phraseModel.get(0).phrase)
                                showText.text = ""
                                inputMethodPlugin.commitPhrase(0)
                            }
                        }
                    }
                }
//                IControls.IconButton_KeyPad{
//                    id:enter_key
//                    width: 122*2+6
//                    height: 80
//                    anchors.left: gantanhao_key.right
//                    anchors.leftMargin: 6
//                    anchors.top:z_key.bottom
//                    anchors.topMargin: 6
//                    source:"qrc:/resources/Keypad_icon_enter.png"

//                    onClicked: {
//                        if(pinyinKBZhEn){
//                            complete(txt)
//                        }
//                    }
//                }


            }
            onVisibleChanged: {
                showText.text = ""
            }
        }
        //拼/EN 部分  结束


    //数字键盘开始
    Rectangle{
        id:numKeyBoard
        anchors.top: textSelectRect.bottom
        anchors.topMargin: 9
        anchors.bottom: parent.bottom
        width: parent.width
        color: "#00000000"
        visible:false


        Rectangle{
            id:numKeyGridRect
            anchors.top:textSelectRect.bottom
            anchors.left: parent.left
            anchors.topMargin: 3
            IControls.TextButton_KeyPad{
                id:slash_key
                width:250
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "/"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:one_key
                width:250
                anchors.left: slash_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "1"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:two_key
                width:250
                anchors.left: one_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "2"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:three_key
                width:250
                anchors.left: two_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "3"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.IconButton_KeyPad{
                id:num_del_key
                width: 250
                height: 80
                anchors.left: three_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                source:"qrc:/resources/Keypad_icon_del.png"
                onReleased: {
                    inputText.remove(inputText.cursorPosition-1,inputText.cursorPosition)
                }

            }

            IControls.TextButton_KeyPad{
                id:add_key
                width:250
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top:slash_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "+"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:four_key
                width:250
                anchors.left: add_key.right
                anchors.leftMargin: 6
                anchors.top:one_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "4"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:five_key
                width:250
                anchors.left: four_key.right
                anchors.leftMargin: 6
                anchors.top:two_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "5"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:six_key
                width:250
                anchors.left: five_key.right
                anchors.leftMargin: 6
                anchors.top:three_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "6"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:dot_key
                width:250
                anchors.left: six_key.right
                anchors.leftMargin: 6
                anchors.top:num_del_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "."
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:minus_key
                width:250
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top:add_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "-"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:seven_key
                width:250
                anchors.left: minus_key.right
                anchors.leftMargin: 6
                anchors.top:four_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "7"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:eight_key
                width:250
                anchors.left: seven_key.right
                anchors.leftMargin: 6
                anchors.top:five_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "8"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:nine_key
                width:250
                anchors.left: eight_key.right
                anchors.leftMargin: 6
                anchors.top:six_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "9"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:percent_key
                width:250
                anchors.left: nine_key.right
                anchors.leftMargin: 6
                anchors.top:dot_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "%"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:fuhao_key
                width:250
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.top:minus_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "?!#"
                onReleased: {
                    downRect.visible = false
                    numKeyBoard.visible = false
                    symbolKeyBoard.visible = true
                }
            }
            IControls.TextButton_KeyPad{
                id:num_return_key
                width:250
                anchors.left: fuhao_key.right
                anchors.leftMargin: 6
                anchors.top:seven_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: qsTr("返回")
                onReleased: {
                    numKeyBoard.visible = false
                    symbolKeyBoard.visible = false
                    downRect.visible = true
                }
            }
            IControls.TextButton_KeyPad{
                id:zero_key
                width:250
                anchors.left: num_return_key.right
                anchors.leftMargin: 6
                anchors.top:eight_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "0"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.IconButton_KeyPad{
                id:num_space_key
                width: 250
                height: 80
                anchors.left: zero_key.right
                anchors.leftMargin: 6
                anchors.top:nine_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                source:"qrc:/resources/Keypad_icon_Space1.png"
                onReleased: {
                    inputText.insert(inputText.cursorPosition," ")
                }

            }
            IControls.TextButton_KeyPad{
                id:num_confirm_key
                width:250
                anchors.left: num_space_key.right
                anchors.leftMargin: 6
                anchors.top:percent_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: qsTr("确定")
                onReleased: {
                    complete(txt)
                }
            }
        }
    }
    //数字键盘结束

    //符号键盘开始
    Rectangle{
        id:symbolKeyBoard
        anchors.top: textSelectRect.bottom
        anchors.topMargin: 9
        anchors.bottom: parent.bottom
        width: parent.width
        color: "#00000000"
        visible:false


        Rectangle{
            id:symbolKeyGridRect
            anchors.top:textSelectRect.bottom
            anchors.left: parent.left
            anchors.topMargin: 3
            IControls.TextButton_KeyPad{
                id:symbol_one_key
                width:122
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "1"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_two_key
                width:122
                anchors.left: symbol_one_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "2"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_three_key
                width:122
                anchors.left: symbol_two_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "3"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_four_key
                width:122
                anchors.left: symbol_three_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "4"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_five_key
                width:122
                anchors.left: symbol_four_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "5"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_six_key
                width:122
                anchors.left: symbol_five_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "6"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_seven_key
                width:122
                anchors.left: symbol_six_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "7"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_eight_key
                width:122
                anchors.left: symbol_seven_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "8"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_nine_key
                width:122
                anchors.left: symbol_eight_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "9"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_zero_key
                width:122
                anchors.left: symbol_nine_key.right
                anchors.leftMargin: 6
                anchors.top:parent.top
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "0"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:wave_key
                width:122
                anchors.left: parent.left
                anchors.leftMargin: 67
                anchors.top:symbol_one_key.bottom
                anchors.topMargin: 6
                themeColor: virtualKBPage.themeColor
                text: "~"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_slash_key
                width:122
                anchors.left: wave_key.right
                anchors.leftMargin: 6
                anchors.top:wave_key.top
                themeColor: virtualKBPage.themeColor
                text: "/"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:colon_key
                width:122
                anchors.left: symbol_slash_key.right
                anchors.leftMargin: 6
                anchors.top:wave_key.top
                themeColor: virtualKBPage.themeColor
                text: symbolKBZhEn ? ":" : "："
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:semicolon_key
                width:122
                anchors.left: colon_key.right
                anchors.leftMargin: 6
                anchors.top:wave_key.top
                themeColor: virtualKBPage.themeColor
                text: symbolKBZhEn ? ";":"；"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:left_bracket_key
                width:122
                anchors.left: semicolon_key.right
                anchors.leftMargin: 6
                anchors.top:wave_key.top
                themeColor: virtualKBPage.themeColor
                text: symbolKBZhEn ? "(" : "（"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:right_bracket_key
                width:122
                anchors.left: left_bracket_key.right
                anchors.leftMargin: 6
                anchors.top:wave_key.top
                themeColor: virtualKBPage.themeColor
                text:symbolKBZhEn ? ")" : "）"
                onReleased: {
                    inputText.insert(inputText.cursorPosition,text)
                }
            }
            IControls.TextButton_KeyPad{
                id:symbol_at_key
                width:122
                anchors.left: right_bracket_key.right
                anchors.leftMargin: 6
                anchors.top:wave_key.top
                themeColor: virtualKBPage.themeColor
                    text: "@"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:left_quotation_key
                    width:122
                    anchors.left: symbol_at_key.right
                    anchors.leftMargin: 6
                    anchors.top:wave_key.top
                    themeColor: virtualKBPage.themeColor
                    text: symbolKBZhEn ? "\"" : "\“"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:right_quotation_key
                    width:122
                    anchors.left: left_quotation_key.right
                    anchors.leftMargin: 6
                    anchors.top:wave_key.top
                    themeColor: virtualKBPage.themeColor
                    text: symbolKBZhEn ? "\"" : "\”"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:more_key
                    width:122
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    anchors.top:wave_key.bottom
                    anchors.topMargin: 6
                    themeColor: virtualKBPage.themeColor
                    text: symbolKBZhEn ? "..." : "……"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:middle_line_key
                    width:122
                    anchors.left: more_key.right
                    anchors.leftMargin: 6
                    anchors.top:more_key.top
                    themeColor: virtualKBPage.themeColor
                    text: "-"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:bottom_line_key
                    width:122
                    anchors.left: middle_line_key.right
                    anchors.leftMargin: 6
                    anchors.top:more_key.top
                    themeColor: virtualKBPage.themeColor
                    text: "_"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:jin_key
                    width:122
                    anchors.left: bottom_line_key.right
                    anchors.leftMargin: 6
                    anchors.top:more_key.top
                    themeColor: virtualKBPage.themeColor
                    text: "#"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:question_key
                    width:122
                    anchors.left: jin_key.right
                    anchors.leftMargin: 6
                    anchors.top:more_key.top
                    themeColor: virtualKBPage.themeColor
                    text: symbolKBZhEn ? "?" : "？"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:sigh_key
                    width:122
                    anchors.left: question_key.right
                    anchors.leftMargin: 6
                    anchors.top:more_key.top
                    themeColor: virtualKBPage.themeColor
                    text: symbolKBZhEn ? "!" : "！"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:comma_key
                    width:122
                    anchors.left: sigh_key.right
                    anchors.leftMargin: 6
                    anchors.top:more_key.top
                    themeColor: virtualKBPage.themeColor
                    text: symbolKBZhEn ? "," : "，"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:period_key
                    width:122
                    anchors.left: comma_key.right
                    anchors.leftMargin: 6
                    anchors.top:more_key.top
                    themeColor: virtualKBPage.themeColor
                    text: symbolKBZhEn ? "." : "。"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.IconButton_KeyPad{
                    id:symbol_del_key
                    width: 122*2+6
                    height: 80
                    anchors.left: period_key.right
                    anchors.leftMargin: 6
                    anchors.top:more_key.top
                    themeColor: virtualKBPage.themeColor
                    source:"qrc:/resources/Keypad_icon_del.png"
                    onReleased: {
                        inputText.remove(inputText.cursorPosition-1,inputText.cursorPosition)
                    }
                }
                IControls.TextButton_KeyPad{
                    id:symbol_number_key
                    width:122
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    anchors.top:more_key.bottom
                    anchors.topMargin: 6
                    themeColor: virtualKBPage.themeColor
                    text: "123"
                    onReleased: {
                        downRect.visible = false
                        numKeyBoard.visible = true
                        symbolKeyBoard.visible = false
                    }
                }
                IControls.TextButton_KeyPad{
                    id:symbol_return_key
                    width:122
                    anchors.left: symbol_number_key.right
                    anchors.leftMargin: 6
                    anchors.top:symbol_number_key.top
                    themeColor: virtualKBPage.themeColor
                    text: qsTr("返回")
                    onReleased: {
						numKeyBoard.visible = false
						symbolKeyBoard.visible = false
						downRect.visible = true

					}
                }
                IControls.TextButton_KeyPad{
                    id:middle_dot_key
                    width:122
                    anchors.left: symbol_return_key.right
                    anchors.leftMargin: 6
                    anchors.top:symbol_number_key.top
                    themeColor: virtualKBPage.themeColor
                    text: "·"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition,text)
                    }
                }
                IControls.IconButton_KeyPad{
                    id:symbol_space_key
                    width: 340
                    height: 80
                    anchors.left: middle_dot_key.right
                    anchors.leftMargin: 6
                    anchors.top:symbol_number_key.top
                    themeColor: virtualKBPage.themeColor
                    source:"qrc:/resources/Keypad_icon_Space1.png"
                    onReleased: {
                        inputText.insert(inputText.cursorPosition," ")
                    }

                }
                IControls.TextButton_KeyPad{
                    id:symbol_zh_en_key
                    width:222
                    anchors.left: symbol_space_key.right
                    anchors.leftMargin: 6
                    anchors.top:symbol_number_key.top
                    themeColor: virtualKBPage.themeColor
                    Text{
                        id:symbol_color_text1
                        anchors.right: symbol_color_text2.left
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 36
                        color: !symbolKBZhEn ? txtColor:"#ffffff"
                        text:"中"
                    }
                    Text{
                        id:symbol_color_text2
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 36
                        color:"#ffffff"
                        text:"/"
                    }

                    Text{
                        id:symbol_color_text3
                        anchors.left: symbol_color_text2.right
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 36
                        color: symbolKBZhEn ? txtColor:"#ffffff"
                        text:"EN"
                    }
                    onReleased: {
                        symbolKBZhEn = !symbolKBZhEn
                    }
                }
                IControls.TextButton_KeyPad{
                    id:symbol_confirm_key
                    width:250
                    anchors.left: symbol_zh_en_key.right
                    anchors.leftMargin: 6
                    anchors.top:symbol_number_key.top
                    themeColor: virtualKBPage.themeColor
                    text: qsTr("确定")
                    onReleased: {
                        complete(txt)
                    }
                }
            }
        }
        //符号键盘结束

        Component.onCompleted:{
            console.debug("init input method")
            inputMethodPlugin.initInputMethod(5)
        }

    }
    onPinyinKBZhEnChanged: {
        showText.text = ""
        phraseModel.clear()
        if(!pinyinKBZhEn){
            inputMethodPlugin.initInputMethod(5)
        }
    }


}
