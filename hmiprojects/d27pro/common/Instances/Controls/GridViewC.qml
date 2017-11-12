import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//图片列表
IControls.GridView{
    id:root;
    cellHeight: 240 + 5;
    cellWidth: 240 + 5;
    useNavBar: true
}
