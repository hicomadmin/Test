import QtQuick 2.3
import QtQuick.Layouts 1.1
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    id: iconbtndemo
    ColumnLayout{

        IControls.IconButton_Normal{
            width: 343
            height: 137
            source: "qrc:/resources/radio_ICN_SEEK+.png"
        }
        IControls.IconButton_PhoneDIalCall{

            source: "qrc:/resources/Phone_Btn_ call.png"
        }

        IControls.IconButton_MediaMusicPlayMark{

            source: "qrc:/resources/Media_Icon_Up_nml.png"
        }
    }
}
