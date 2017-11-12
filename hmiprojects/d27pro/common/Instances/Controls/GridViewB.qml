import QtQuick 2.3
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls
//音乐列表
IControls.GridView{
    id:root;
    cellHeight: 281 + 23;
    cellWidth: 250 + 6;
    useNavBar: false;
}
