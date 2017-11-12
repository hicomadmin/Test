import QtQuick 2.3
import 'qrc:/UI/Private' as Private

Private.Control {
     property alias valueLabel: valueLabel
     property alias unitLabel: unitLabel
     property string valueText: ""
     property int valueFontSize
     property color valueColor
     property string unitText: ""
     property int unitFontSize
     property color unitColor:valueColor
     property real spacing: 0            //数值标签与单位标签之间的间隔

      //数值文本
      Text {
          id: valueLabel
          text: valText
          font.pixelSize: valueFontSize
          color: valueColor
          anchors.left: parent.left
          anchors.bottom: parent.bottom
      }

      //单位文本
      Text {
          id: unitLabel
          text: unitText
          font.pixelSize: unitFontSize
          color: unitColor
          anchors.left: valueLabel.right
          anchors.bottom: parent.bottom
          anchors.leftMargin: spacing
      }
}
