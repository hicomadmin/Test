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
    property alias tabs: tabview.tabs;
    property alias tabsModel: tabview.tabsModel;
    property int themeColor
    property url lineImage: themeColor == 0?"qrc:/resources/list_line_left 2.png":(themeColor == 1 ? "qrc:/resources/list_line_left-2.png":"qrc:/resources/list_line_left 2_g.png")
    property bool isCopy: false;

    //Bug #180
    property bool isUsed;
    property string initPage;
    property string currentTab: tabview.currentTab;

    /* BEGIN by Ge Wei, 2016.11.15
     * See: Bug #399.
    */
    function switchTab(to, opts) {
        tabview.switchTab(to, opts)
    }
    /* END by Ge Wei, 2016.11.15 */
    ExclusiveGroup {
        id: tabsExclusiveGroup;
    }

    Rectangle{
        anchors.fill: parent;
        color: '#00000000';
        ICore.TabViewV{
            id: tabview;

            anchors.fill: parent;
            appWindow: application.appWindow
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

//            tabsContainerBgSource: 'qrc:/resources/BG.png';

            tabsContainer {
                anchors.top: tabview.top
                anchors.left: tabview.left
            }

            tabsDelegate: Item {
                id: name
                width: 242;
                height: 154+4;
                IControls.GradientButtonB {
                    id: conttext
                    width: 242;
                    height: 154;
                    disabled: isDisabled(index);
                    checked: tabview.currentTab === modelData.tab
                    exclusiveGroup: tabsExclusiveGroup
                    themeColor: root.themeColor
                    onClicked: {
//                        checked = true;
                        tabview.switchTab(modelData.tab,{needUpdate: true, properties: { isCopy: false}});
                    }
                    btnColor: isDisabled(index) ? "gray" : "#FFFFFF"
                    btnName: modelData.tabTitle
//                    contentcompent: Component{
//                        Text {
//                            text: modelData.tabTitle;
//                            color: "#FFFFFF";
//                            font.pixelSize: 36;
//                        }
//                    }
                    onCheckedChanged: {
                        imageline.source = tabview.currentTab === modelData.tab ? "qrc:/resources/list_line_left 1.png" : lineImage;
                    }
                    onThemeColorChanged: {
                        imageline.source = tabview.currentTab === modelData.tab ? "qrc:/resources/list_line_left 1.png" : lineImage;
                    }
                }
                Image {
                    id: imageline;
                    anchors.top: conttext.bottom;
                    source: tabview.currentTab === modelData.tab ? "qrc:/resources/list_line_left 1.png" : lineImage;
//                    onSourceChanged: {
//                        console.debug(' modelData.index: ', model.index);
//                        source = tabview.index === model.index - 1 ? "qrc:/resources/list_line_left 2.png" : "qrc:/resources/list_line_left 1.png";
//                    }
                }
            }

        }
    }

    function isDisabled(itemIndex) {
        console.debug('initialTab = ', initPage);
        console.debug('isUsed = ', isUsed);
        if(initPage === "btphone" && (itemIndex === 0 || itemIndex === 1) ) {
            return !isUsed;
        }
        return false;
    }
}
