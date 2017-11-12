import QtQuick 2.3
import QtQuick.Layouts 1.1
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    id: root
    GridLayout {
        anchors.centerIn: parent
        rows: 2
        columns: 4

        Repeater {
            model: [
                'circleButtons',
                'roundButtons',
                'rectButtons',
                'iconButtons'
            ]
            IControls.RectButtonA {
                onClicked: {
                    application.changePage(modelData);
                }

                UControls.ButtonStateLabel {
                    anchors.centerIn: parent
                    normalColor: '#FFFFFF'
                    pressingColor: '#AAFFFFFF'
                    font.pixelSize: 20
                    text: modelData
                }
            }
        }
    }
}
