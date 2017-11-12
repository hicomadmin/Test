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
    property int themeColor: 0
    property bool isCopy: false;

    ExclusiveGroup {
        id: tabsExclusiveGroup;
    }

    function switchTab(to,opts) {
        tabview.switchTab(to, opts)
    }

    Rectangle{
        anchors.fill: parent;
        color: '#00000000';
        ICore.TabView{
            id: tabview;

            anchors.fill: parent;
            appWindow: application.appWindow;
            multiApplications: application.multiApplications;

            tabsContainerImage.anchors {
                fill: null
                left:tabview.left;
                top: tabview.top
            }
//            tabsContainerBgSource: 'qrc:/resources/BG.png';
            tabsContainer {
                anchors.top: tabview.top
                anchors.topMargin: 15;
                anchors.left: tabview.left
                anchors.leftMargin: 72;
            }

            tabsDelegate: Item {
                id: name
                width: 294+2;
                height: 90;
                UControls.ColorButton {
                    id: conttext
                    width: 294;
                    height: 90;
                    normalColor: '#313536';
                    pressingColor: themeColor == 0 ?"#105769":(themeColor == 1? "#ff2200":"#986142");
                    checkedNormalColor: themeColor == 0 ?"#105769":(themeColor == 1? "#ff2200":"#986142");
                    checked: tabview.currentTab === modelData.tab
                    exclusiveGroup: tabsExclusiveGroup
                    onClicked: {
                        tabview.switchTab(modelData.tab,{needUpdate: true, properties: { isCopy: false}});
                    }

                    IControls.NonAnimationText_FontLight{
                        anchors.centerIn: parent;
                        color: '#FFFFFF';
                        font.pixelSize: 36;
                        text: modelData.tabTitle;
                    }
                }
                Rectangle{
                    width: 2;
                    height: 90;
                    anchors.left: conttext.left;
                    color: '#00000000';
                }
            }

        }
    }


}
