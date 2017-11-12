import QtQuick 2.3
import QtQuick.Layouts 1.1
import 'qrc:/UI/Core' as UCore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls

ICore.Page {

    GridLayout {
        anchors.centerIn: parent
        rows: 2
        columns: 4
        Repeater {
            id: repeater
            model: [
                'ListViewA',
                'ListViewB',
                'ListViewC',
                'ListViewD',
                'FlickableA',
                'FlickableB',
                'FlickableC',
                'FlickableD',
                'ListUseLoader',
                'ListUseRefresher'
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
