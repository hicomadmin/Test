import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    id: root
    property Video video
    onVideoChanged: {
        console.log(video.muted);
    }

    property Radio radio
    onRadioChanged: {
        console.log(radio.frequency);
    }

    property Item test
    onTestChanged: {
        if (!test) return console.log('test has been destroyed.');
        console.log(test.x);
        test.x++;
    }

    GridLayout {
        anchors.centerIn: parent
        rows: 2
        columns: 4

        Repeater {
            id: repeater
            model: [
                'multi',
                'creator1',
                'creator2',
                'recreate',
                'destroyWhen'
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
