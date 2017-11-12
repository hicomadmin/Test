import QtQuick 2.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

IControls.DialogConfirmBase{
    id: root;
    contentWidth: 732;
    contentHeight: 430;

    property real stringWidth

    property string textinfo: '';
    property int pixelSizeinfo: 36;

    infoComponent: Component{
        Item{
          Rectangle{
              anchors.fill: parent
              color: themeColor == 0 ?"#103c4b":(themeColor == 1? "#480E05":"#3c2513")

              IControls.NonAnimationText_FontLight {
                  id : text
                 anchors {
                     top: parent.top;
                     //modify by jxt 20161115 begin
//                     topMargin: 86; // fixme
                     topMargin: 43; // fixme
                     //modify by jxt 20161115 end
                     /* BEGIN by Xiong wei, 2016.12.28
                      *  Repair of a string of cross-border issues
                     */
                     left: parent.left
                     leftMargin: 20
                     right: parent.right
                     rightMargin: 20
                     bottom: parent.bottom
                     bottomMargin: 20
                     // End by xiongwei 2016.12.28
                 }
                 color: "#FFFFFF";
                 text: qsTr(root.textinfo);
                 font.pixelSize: root.pixelSizeinfo;
                 /* BEGIN by Xiong wei, 2016.12.28
                  *  Repair of a string of cross-border issues
                 */
                 wrapMode: Text.WordWrap
                 horizontalAlignment: (stringWidth < 732) ? Text.AlignHCenter : Text.AlignLeft

                 Component.onCompleted: {
                     stringWidth = text.contentWidth
                 }
                 // End by xiongwei 2016.12.28

             }
          }
        }
    }
}
