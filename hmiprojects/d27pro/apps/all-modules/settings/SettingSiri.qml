import QtQuick 2.0
import QtQuick.Controls 1.2
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import TheXMcan 1.0
import TheXSettings 1.0

ICore.Page {
    id: root
    property McanCtl mcan: HSPluginsManager.get('mcan')
    property SystemCtl system: HSPluginsManager.get('system')
    property real remindSwitch: mcan.remindSwitch
    property int interfacemodel: system.interfacemodel
    property bool isFirst: true
    property bool checkStatus0
    property bool checkStatus1
    property bool checkStatus2
    property bool checkStatus3
    property bool checkStatus4
    property bool checkStatus5
    property bool checkStatus6
    property bool checkStatus7
    //property bool checkStatus8    移除车窗未关开关
    property bool checkStatus9
    //property bool checkStatus10   移除车窗未关开关
    property bool checkStatus11
    property bool checkStatus12
    property bool checkStatus13
    property bool checkStatus14
    property bool checkStatus15

    Component.onCompleted: {
        mcan.getControl(0)
        remindSwitchChanged()
    }

    onRemindSwitchChanged: {
        var switchBuf = []
        for(var i = 8;i <= 15;i++){
            switchBuf[i - 8] = (remindSwitch >> i) & 0x01;
        }
        for(var j = 0;j <= 7;j++){
            switchBuf[j + 8] = (remindSwitch >> j) & 0x01;
        }
        checkStatus0 = switchBuf[0]
        checkStatus1 = switchBuf[1]
        checkStatus2 = switchBuf[2]
        checkStatus3 = switchBuf[3]
        checkStatus4 = switchBuf[4]
        checkStatus5 = switchBuf[5]
        checkStatus6 = switchBuf[6]
        checkStatus7 = switchBuf[7]
        //checkStatus8 = switchBuf[8]
        checkStatus9 = switchBuf[9]
        //checkStatus10 = switchBuf[10]
        checkStatus11 = switchBuf[11]
        checkStatus12 = switchBuf[12]
        checkStatus13 = switchBuf[13]
        checkStatus14 = switchBuf[14]
        checkStatus15 = switchBuf[15]
    }

    Item {
        id: bg
        width: 1280
        height: 628
        IControls.ListDelegateSwitch{
            id:siriSwitch
            anchors.left: bg.left
            anchors.leftMargin: 46
            text: qsTr("语音提醒")
            checked: checkStatus13
            themeColor: interfacemodel
            Rectangle{
                id: line
                width: 1188
                height: 40
                anchors.top: siriSwitch.bottom
                anchors.left: parent.left
                color: "#777c7f"
                opacity: 0.08
            }
            onCheckedChanged: {
                mcan.setRemindSwitch(13, checked ? 1 : 0)
            }
        }

        ListView{
            id: lights
            visible: siriSwitch.checked
            anchors.top: siriSwitch.bottom
            anchors.topMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 46
            width: 1188
            height: 464
            model:[qsTr("车门未关"),qsTr("安全带未系"),qsTr("保养"),qsTr("车灯未熄"),qsTr("水温过高"),qsTr("手刹未释放"),
                   qsTr("电源未关"),qsTr("钥匙未拔"),qsTr("油量不足"),qsTr("低温结冰"),qsTr("机油压力低"),qsTr("发动机故障"),qsTr("ABS报警")]
            delegate: items
            clip: true
            cacheBuffer: 124*10
//            boundsBehavior: Flickable.StopAtBounds
        }
        Component{
            id: items
            IControls.ListDelegateSwitch{
                text: qsTr(modelData)
                themeColor: interfacemodel
                checked: {
                 switch(index){
                 case 0:
                     return checkStatus0

                 case 1:
                     return checkStatus1

                 case 2:
                     return checkStatus2

                 case 3:
                     return checkStatus3

                 case 4:
                     return checkStatus4

                 case 5:
                     return checkStatus5

                 case 6:
                     return checkStatus6

                 case 7:
                     return checkStatus7

                 case 8:
                     return checkStatus9

                 case 9:
                     return checkStatus11

                 case 10:
                     return checkStatus12

                 case 11:
                     return checkStatus14
                 case 12:
                     return checkStatus15

                 default:
                     break;
                }
                }

                onCheckedChanged: {
                    var isOn = checked ? 1 : 0
                    /* BEGIN by Xiong wei, 2016.12.19
                     * add two remaind switch
                    */
                    if (index === 8) {
                        mcan.setRemindSwitch(index+1, isOn)
                    } else if(index >= 9 && index < 11){
                        mcan.setRemindSwitch(index+2, isOn)
                    } else if(index >= 11) {
                        mcan.setRemindSwitch(index+3, isOn)
                    } else {
                        mcan.setRemindSwitch(index, isOn)
                    }
                    // End bu xiongwei 2016.12.19
                    console.log(index, isOn)
                }
            }
        }
        IControls.Fixed_ScrollBar{
            y: 164
            view: lights
            visible: lights.visible
            anchors.right: parent.right
            anchors.rightMargin: 10
        }
    }
}

