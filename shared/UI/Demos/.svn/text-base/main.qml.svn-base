import QtQuick 2.3
import QtQuick.Controls 1.2
import 'qrc:/UI/Controls' as UControls
import 'qrc:/UI/Controls/Extra' as UExtra
import 'qrc:/UI/JSLibs/ThreeParts.js' as JSLibs

ApplicationWindow {
    id: root
    visible: true
    width: 400
    height: 640
    title: qsTr("UI Demo")
    Component.onCompleted: {
        JSLibs.initRootItem(root);
    }

    Rectangle {
        id: headerContainer
        width: parent.width
        height: 48
        color: '#337AB7'
        UControls.LabelButton {
            text: 'Back'
            color: "#FFFFFF"
            width: 50
            height: 48
            onClicked: {
                titleLabel.text = 'UI Demo Menu';
                demoStackView.pop();
            }
            visible: demoStackView.depth > 1
        }
        UControls.Label {
            id: titleLabel
            anchors.centerIn: parent
            text: 'UI Demo Menu'
            font.pixelSize: 24
            color: '#FFFFFF'
        }
        z: 2
    }
    StackView {
        id: demoStackView
        width: parent.width
        anchors {
            top: headerContainer.bottom
            bottom: parent.bottom
        }
        initialItem: menuListView

        ListView {
            id: menuListView
            model: ListModel {
                ListElement {
                    title: '流程控制'
                    url: 'ControlFlow.qml'
                }
                ListElement {
                    title: '容器'
                    url: 'Container.qml'
                }
            }
            delegate: UExtra.FadeColorButton {
                width: parent.width
                height: 36
                rectangle {
                    anchors.bottomMargin: 1
                }
                normalColor: '#FF373d47'
                pressingColor: '#DD373d47'
                transDuration: 300
                onClicked: {
                    console.log(state, normalColor, pressingColor);
                    titleLabel.text = model.title;
                    demoStackView.push({item: Qt.resolvedUrl(model.url)});
                }
                Text {
                    anchors.fill: parent
                    anchors.margins: 6
                    text: (index + 1) + '. ' + model.title + ' -> ' + model.url
                    color: '#FFFFFF'
                }
            }
        }
    }
}
