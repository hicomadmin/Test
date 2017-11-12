import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    id: roundlabbtndemo
    GridLayout {
        anchors.centerIn: parent
        columns: 3
        columnSpacing: 30
        IControls.NumberButtonA {
            id:nemberBtton1
            buttonText: '*'
        }

        IControls.NumberButtonA {
            id:nemberBtton2
            buttonText: '1'
        }

        IControls.RoundLabButtonA {
            width: 100
            height: 50
            UControls.Label{
                 anchors.centerIn: parent
                 text: '1'
                 font.pixelSize:30
                 color: '#FFFFFF'
             }
        }

        IControls.RoundLabButtonC {
            width: 100
            height: 50
            UControls.Label{
                 anchors.centerIn: parent
                 text: '重新搜索'
                 font.pixelSize:16
                 color: '#FFFFFF'
             }
        }

        IControls.RoundLabButtonB {
            width: 200
            height: 80
            UControls.Label{
                 anchors.centerIn: parent
                 text: '同步'
                 font.pixelSize:20
                 color: '#FFFFFF'
             }
        }

        Repeater {
            id: repeater
            model: [
                'DialPad',
                'IconButton',
                'ComboBox',
                'ComboBoxOld'
            ]
            IControls.RectButtonA {
                onClicked: {
                    application.changePage(modelData);
                    console.log(modelData)
                }

                UControls.ButtonStateLabel {
                    anchors.centerIn: parent
                    normalColor: '#FFFFFF'
                    pressingColor: '#AAFFFFFF'
                    font.pixelSize: 20
                    text: modelData
                }
            }

            Component.onCompleted: {
                        console.info("roundlabbtndemo info completed")
                    }
        }
    }
}
