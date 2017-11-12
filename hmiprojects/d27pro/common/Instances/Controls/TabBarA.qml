import QtQuick 2.0
import QtQuick.Controls 1.4
import 'qrc:/UI/Private' as Private
import 'qrc:/Instances/Core' as ICore
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Controls' as IControls

Private.Control{
    id:root;
    anchors.fill: parent;
    property alias tabview: tabview
    property alias application: tabview.application
    property alias initialTab: tabview.initialTab;
    property alias initialOpts: tabview.initialOpts
    property alias tabs: tabview.tabs;
    property alias tabsModel: tabview.tabsModel;
    property int themeColor
    property bool isCopy: false;
    ExclusiveGroup {
        id: tabsExclusiveGroup;
    }

    Rectangle{
        anchors.fill: parent;

        ICore.TabViewV{
            id: tabview;

            anchors.fill: parent;
            appWindow: application.appWindow;
            multiApplications: application.multiApplications;
//            Component.onCompleted: {//tabView.switchTab("inComing",{needUpdate: true, properties: { isCopy: isCopy }});
//                tabview.switchTab(root.initialTab,{needUpdate: true, properties: { isCopy: false }});
//            }

            tabsContainerImage.anchors {
                fill: null
                left:tabview.left;
                top: tabview.top
                //topMargin: 20
//                horizontalCenter: tabview.horizontalCenter
            }

            tabsContainerBgSource:  themeColor == 0 ? 'qrc:/resources/BG.png' :(themeColor == 1 ? "qrc:/resources/BG_o.png" :"qrc:/resources/BG_g.png");

            tabsContainer {
                anchors.top: tabview.top
                anchors.left: tabview.left
            }

            tabsDelegate: Item {
                id: name
                width: 242;
                height: 154+4;
                IControls.GradientButtonA {
                    id: conttext
                    width: 242;
                    height: 154;
                    textPixelSize : system.language === 0 ? 36 : 30
                    themeColor: root.themeColor
                    checked: tabview.currentTab === modelData.tab
                    exclusiveGroup: tabsExclusiveGroup
                    onClicked: {
//                        checked = true;
                        tabview.switchTab(modelData.tab,{needUpdate: true, properties: { isCopy: false}});
                    }
                    btnName: modelData.tabTitle
                    iconSource: modelData.tabImage
//                    contentcompent: Component{
//                        Text {
//                            text: modelData.tabTitle;
//                            color: "#FFFFFF";
//                            font.pixelSize: 36;
//                        }
//                    }
                    onCheckedChanged: {
                        imageline.source = tabview.currentTab === modelData.tab ? "qrc:/resources/list_line_left 1.png" :
                                                                                  (themeColor == 0 ? "qrc:/resources/list_line_left 2.png" : (themeColor == 1 ? "qrc:/resources/list_line_left-2.png":" "));
                    }
                }
                Image {
                    id: imageline;
                    anchors.top: conttext.bottom;
                    source: tabview.currentTab === modelData.tab ? "qrc:/resources/list_line_left 1.png" :
                                                                   (themeColor == 0 ? "qrc:/resources/list_line_left 2.png" : (themeColor == 1 ? "qrc:/resources/list_line_left-2.png":"qrc:/resources/list_line_left 2_g.png"));
//                    onSourceChanged: {
//                        console.debug(' modelData.index: ', model.index);
//                        source = tabview.index === model.index - 1 ? "qrc:/resources/list_line_left 2.png" : "qrc:/resources/list_line_left 1.png";
//                    }
                }
            }

        }
    }


}
