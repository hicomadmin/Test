import QtQuick 2.0
import QtQuick.Layouts 1.1
import 'qrc:/UI/Controls' as UIControls
import 'qrc:/Instances/Controls' as IControls

Flickable {
    contentHeight: mainColumnLayout.height
    contentWidth: width
    ColumnLayout {
         id: mainColumnLayout
            UIControls.Label {
                text: "RectButtonA: "
            }
            IControls.RectButtonA {}

            UIControls.Label {
                text: "RectButtonB: "
            }
            IControls.RectButtonB {}

            UIControls.Label {
                text: "RectButtonC: "
            }
            IControls.RectButtonC {}

            UIControls.Label{
                 text:"CircleButtonA:"
             }
             IControls.CircleButtonA{}

             UIControls.Label{
                 text:"CircleButtonB:"
             }
             IControls.CircleButtonB{}

             UIControls.Label{
                 text:"CircleButtonC:"
             }
             IControls.CircleButtonC {}

             UIControls.Label{
                 text:"CircleButtonD:"
             }
             IControls.CircleButtonD{}

             UIControls.Label {
                 text: "RoundButtonA:"
             }
             IControls.RoundButtonA{}

             UIControls.Label {
                 text: "RoundButtonB:"
             }
             IControls.RoundButtonB{}

             UIControls.Label {
                 text: "RoundButtonC:"
             }
             IControls.RoundButtonC {}
    }
}
