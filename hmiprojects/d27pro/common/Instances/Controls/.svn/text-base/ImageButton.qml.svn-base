import QtQuick 2.3
import QtGraphicalEffects 1.0
import 'qrc:/UI/Controls' as UControls

UControls.ImageButton{
    id:root

    property int themeColor

    property alias iconnormalSource:icon.normalSource;
    property alias icondisabledSource: icon.disabledSource;

    normalSource: (themeColor === 0)?'qrc:/resources/Media_Btn3_nml.png':((themeColor === 1)?'qrc:/resources/Media_Btn31_nml.png' :'qrc:/resources/Media_Btn32_nml.png');
    disabledSource: 'qrc:/resources/Media_Btn3_dis.png';

    UControls.ButtonStateImage {
        id: icon;
        anchors.centerIn: parent;
    }
}
