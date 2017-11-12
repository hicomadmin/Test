import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import  'qrc:/UI/Controls' as UControls

IControls.Dialog {
    id: stateDialog

    property string text:''

    contentWidth: 592
    contentHeight: 232
    shadowComponent: Component {
        Rectangle {
            color: "#60000000"
        }
    }
    bgComponent: Component {
        Rectangle {
            id: contentBg
            color: "#0a0a0F"
            border {
                width: 5
                color: "#777799"
            }
            radius: 8
            Text {
                anchors.centerIn: parent
                color:'#FFFFFF'
                font.pixelSize: 36
                text: stateDialog.text
            }
        }
    }
}
