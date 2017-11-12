import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import 'qrc:/UI/Core' as UCore
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
            id: repeater
            model: [
                'buttons',
                'labels',
                'dialogs',
                'listView',
                'dataOperations',
                'requirePlugins',
                'calendar',
                'RoundLabButtons',
                'miniCalendar',
                'keyPad'

            ]
            IControls.RectButtonA {
                onClicked: {
                    application.multiApplications.changeApplication(modelData);
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
