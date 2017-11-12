import QtQuick 2.3
import QtQuick.Layouts 1.1
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    id: rectbtndemo
    GridLayout {
        anchors.centerIn: parent
        columns: 3
        columnSpacing: 60

        IControls.IconButtonA{
            id:inputdelete
        }

        IControls.IconButtonB{
            id:vedioplay
            height: 100
            width:200
            pressingSource:"qrc:/resources/Media_Icon_Down_nml.png"
            normalSource:"qrc:/resources/Media_Icon_Down_nml.png"
        }

        IControls.IconButtonC{
            id:numberclock
        }

    }

}
