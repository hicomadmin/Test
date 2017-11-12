import QtQuick 2.0
import Bluetooth 1.0
import TheXSettings 1.0
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/Instances/Core' as ICore

ICore.Page  {
    id: root
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')

    property int interfacemodel

    property var match

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    onBtctlChanged: {
        match = Qt.binding(function(){return btctl.match})
    }

    Rectangle{
        id:textRect
        width: parent.width
        height: 180
        color: "#1c272b"

        Rectangle{
            id: showRect
            width: 960
            height: 100
            anchors.centerIn: parent
            border.width : 5
            border.color: "#73bab2"
            color: '#000000'
            radius: 4
            Image {
                id: search
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: showRect.left
                anchors.leftMargin: 15
                source: "qrc:/resources-hf/Phone_search.png"
            }

            TextInput{
                id:inputText
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: search.right
                anchors.leftMargin: 10
                width: 990
                height: 36
                font.pixelSize: 36
                color: "#FFFFFF"
                onFocusChanged: {
//                    inputText.text = ""
                    load.source = "qrc:/hf/VirtualKeyboard.qml"
                    load.item.visible = true
                    textRect.visible = false
                    listView.visible = false
                    noneData.visible = false
                }
            }
        }
    }

    Rectangle{
        anchors.top: textRect.bottom
        width: parent.width
        height: parent.height-textRect.height
        Image {
            anchors.fill: parent
            id: bg
            source: interfacemodel == 0?"qrc:/resources/BG.png":(interfacemodel == 1 ? "qrc:/resources/BG_o.png":"qrc:/resources/BG_g.png")
        }
        Rectangle{
            id: noneData
            anchors.centerIn: parent
            Image {
                id: noneImage
                anchors.centerIn: parent
                source: "qrc:/resources-hf/Phone_Icon_No record.png"
            }
            TextInput{
                anchors.top: noneImage.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 15
                font.pixelSize: 36
                text: qsTr("无相关搜索信息，请重新查询")
                color: "#FFFFFF"
            }
        }

        IControls.ListViewA {
            id:listView
            height: 400
            visible: false
            anchors.centerIn: parent
            model: ListModel {
                id: findModel
            }

            delegate: IControls.ListItemDelegateB {
                id: listDelegate
                width: 1000
                iconurl: interfacemodel == 0 ? "qrc:/resources-hf/Phone_Icon_ character.png":
                                               (interfacemodel == 1 ? "qrc:/resources-hf/Phone_Icon_-character.png":"qrc:/resources-hf/Phone_Icon_ character_g.png")
                contactname: findModel.get(index).name
                contactnum: findModel.get(index).number

                onClicked: {
                    btctl.phoneCallTask(findModel.get(index).number)
                }
            }
            listView.usePaginationLoader: true
            //add by gaojun -2017-2-13 (load search data by once, so have no more data)
            listView.paginationLoaderDelegate.noMore: true
        }
    }

//    IControls.KeyPad {
//        themeColor: interfacemodel
//    }

    Loader{
        id: load
        anchors.top: parent.top
        anchors.topMargin: 5
        source: "qrc:/hf/VirtualKeyboard.qml"
        //source: ""
        onLoaded: {
            load.item.complete.connect(function confirmed(txt){
                findContacts(txt)
            })
        }
        Component.onCompleted: {
            load.item.visible = true
            textRect.visible = false
            listView.visible = false
            noneData.visible = false
        }
    }

    onMatchChanged:{
        console.debug("[KeyBoardPage] KeyPad match = ", btctl.match)
        console.debug("[KeyBoardPage] btctl.match.length  = ", btctl.match.length)
        findModel.clear()

        if(!load.item) {
            if(btctl.match.length > 0) {
                findModel.append(btctl.match)
                listView.visible = true
                noneData.visible = false
            } else {
                listView.visible = false
                noneData.visible = true
            }
        }
        else{
            textRect.visible = false
            listView.visible = false
            noneData.visible = false
        }

//        if(load.item) {
//            load.item.visible = false
//            load.source = ""
//        }
    }

    function findContacts(strText) {
        console.debug("[KeyBoardPage] load.source  = ", load.source)
        console.debug("[KeyBoardPage] load.item.visible  = ", load.item.visible)
        console.debug("[KeyBoardPage] KeyPad input = ", strText)
        btctl.matchPb(strText)
        inputText.text = strText
        inputText.focus = false
        textRect.visible = true

        load.item.visible = false
        load.source = ""
    }
}

