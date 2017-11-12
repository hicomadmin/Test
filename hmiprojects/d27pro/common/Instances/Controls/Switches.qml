import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import 'qrc:/UI/Controls' as UControls

UControls.Switch{
    id: sw
    property int themeColor: 0
    property url switchON: themeColor == 0?"qrc:/resources/Switch_btnr_no.png":(themeColor == 1 ? "qrc:/resources/Switch_btnr_no_o.png":"qrc:/resources/Switch_btnr_no_g.png")
    onCheckedChanged: {
//        console.log(checked)
    }

    style: SwitchStyle{
        groove: BorderImage{
            id: di
            source: control.checked ? switchON : "qrc:/resources/Switch_btnr_off.png"
            Text {
                x: control.checked? (di.x + (system.language === 0 ? 30 : 25)) : (di.x + (system.language === 0 ? 95 : 85)) //Adjust switch text by xiongwei 2016.12.29
                z: 1
                anchors.verticalCenter: parent.verticalCenter
                color: "#ffffff"
                font.pixelSize: system.language === 0 ? 35 : 30
                text: (control.checked? qsTr("开") : qsTr("关")) + ctranslator.monitor
            }
        }
        handle: BorderImage{
            id: hand
            source: control.checked ? "qrc:/resources/Switch_slider_no.png" : "qrc:/resources/Switch_slider_off.png"
        }
    }
}

