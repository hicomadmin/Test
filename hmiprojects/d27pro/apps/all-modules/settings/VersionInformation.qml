import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/Controls' as UControls

//add by jxt 20161102 begin
import TheXSettings 1.0
//add by jxt 20161102 end

ICore.Page {
    id: root

    property SystemCtl system: HSPluginsManager.get('system')

    property string sfVer: "ET V1.1.00"
    property string mcuVer: "V1.1.00"
    property string mcuVersion: "V1.1.00"

    property var contentModel: [
        {
            name: qsTr('软件版本: '),
            info: sfVer
        },
        {
            name: qsTr('MCU版本: '),
            info: mcuVer
        }
    ]
    readonly property int textPixelSize: 32

    Column {
        anchors.centerIn: parent
        spacing: 34
        Repeater {
            model: contentModel
            IControls.NonAnimationText_FontRegular {
                id: textVer
                text: modelData.name + modelData.info
                color: "#FFFFFF"
                font.pixelSize: textPixelSize
            }
        }
    }

    //add by jxt 20161102 begin
    Connections {
        target: system
        onError: console.log(msg)
    }

    onSystemChanged: {
        sfVer =  "ET " + system.read("/usr/app/version")
        mcuVersion = system.version
        mcuVer = (mcuVersion.substring(0, 2) === "54") ? "T" : "V"
        mcuVer += mcuVersion.substring(2, 6)
    }
    //add by jxt 20161102 end

}

