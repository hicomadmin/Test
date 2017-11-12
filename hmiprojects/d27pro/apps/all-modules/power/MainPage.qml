import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Core' as UCore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
import TheXSettings 1.0
import TheXVideo 1.0
import TheXPower 1.0

ICore.Page {
    id: mainPage

    property SystemCtl system: HSPluginsManager.get('system')
    property VideoCtl videoctl: HSPluginsManager.get('videoctl')
    property PowerCtl power: HSPluginsManager.get('power')

    Component.onCompleted: {
        videoctl.tryPause()
    }

    Component.onDestruction: {
        videoctl.tryResume()
    }

    Rectangle {
        width: 1280
        height: 720
        color: 'black'
        IControls.MouseArea {
            anchors.fill: parent
            onClicked: {
                if (power.accState) power.scc = true
            }
        }
    }
}
