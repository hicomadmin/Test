import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/UI/Core' as UICore

Rectangle {
    Row {
        id: row
        Button {
            text: 'aaa'
            onClicked: {
                container.changeTo('aaa', {properties: {color: 'red'}});
            }
        }
        Button {
            text: 'bbb'
            onClicked: {
                container.changeTo('bbb', {properties: {color: 'green'}});
            }
        }
        Button {
            text: 'push one'
            onClicked: {
                container.changeTo(null, {
                                       settings: {com: com},
                                       properties: {color: 'blue'}
                                   });
            }
        }
        Button {
            text: 'push many'
            onClicked: {
                container.changeTo(null, [{
                                              settings: {com: com},
                                              properties: {color: 'blue'}
                                          }, {
                                              settings: {com: com},
                                              properties: {color: 'lightblue'}
                                          }]);
            }
        }
    }
    Component {
        id: com
        Rectangle {}
    }
    UICore.StackContainer {
        id: container
        anchors.fill: parent
        anchors.topMargin: 30

        elSettings: ({
                           aaa: {com: com},
                           bbb: {com: com}
                       })
    }
}
