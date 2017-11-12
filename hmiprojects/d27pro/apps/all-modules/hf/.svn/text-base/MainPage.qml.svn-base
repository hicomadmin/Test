import QtQuick 2.0
import Bluetooth 1.0
import TheXSettings 1.0
import 'qrc:/UI/Controls' as UControls
import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls

ICore.Page {
    id: root;
    //    anchors.fill: parent;
    property BtCtl btctl: HSPluginsManager.get('btctl')
    property SystemCtl system: HSPluginsManager.get('system')
    property int telStatus
    property int interfacemodel
    
    //Bug #180
    property int connectState;

    onItemAfterCreated:{
        console.debug('root width: ',root.width);
        console.debug('root height: ',root.height);
    }

    onItemBeforeDestroyed: {
        btctl.scanMode(false)
    }

    /* BEGIN by Ge Wei, 2016.11.15
     * See: Bug #399.
    */
    onItemShown: {
        console.debug('onItemShown')
//        switchPage()
        btctl.scanMode(true)
    }
    /* END by Ge Wei, 2016.11.15 */

    onItemHiden: {
        btctl.scanMode(false)
    }

    onBtctlChanged: {
        telStatus = Qt.binding(function (){return btctl.telStatus})

        connectState = Qt.binding(function (){return btctl.connectState});

        console.debug("connectState = ", connectState);
        if(isConnect()){
            tabe.isUsed = true;
        } else {
            tabe.isUsed = false;
        }
    }

    onSystemChanged: {
        interfacemodel = Qt.binding(function(){return system.interfacemodel})
    }

    onConnectStateChanged: {
        console.log('[hf Application] tabe.currentTab=',tabe.currentTab);
        if(isConnect()){
            tabe.isUsed = true;
        } else {
            tabe.isUsed = false
            if(tabe.currentTab === 'calllog' || tabe.currentTab === 'phonebook') {
                tabe.switchTab('btconnected', {needUpdate: true, properties: {isCopy: false}})
            }
        }
    }

    onItemFirstShown: {
        switchPage()
    }

    //切换tab
    function switchPage() {
        var temp
        if(isConnect()){
            temp = 'dianumber'
            tabe.isUsed = true
        } else {
            temp = 'btconnected'
            tabe.isUsed = false
        }
        tabe.switchTab(temp, {needUpdate: true, properties: {isCopy: false}})
    }

    IControls.TabBar{
        id:tabe
        anchors.fill: parent;
        application: root.application
        themeColor: interfacemodel;

        tabs: ({
                   btconnected: {url: Qt.resolvedUrl('Btconnected.qml')},
                   calllog: {url: Qt.resolvedUrl('Calllog.qml')},
                   dianumber: {url: Qt.resolvedUrl('Dialnumber.qml')},
                   phonebook: {url: Qt.resolvedUrl('Phonebook.qml')}
               })
//        initialTab: 'btconnected';
        initPage: 'btphone'
        tabsModel: [
            {
                tab: 'calllog',
                tabTitle: qsTr("通话记录"),
            },
            {
                tab: 'phonebook',
                tabTitle: qsTr("通讯录"),
            },
            {
                tab: 'dianumber',
                tabTitle: qsTr("拨号盘"),
            },
            {
                tab: 'btconnected',
                tabTitle: qsTr("蓝牙连接"),
            }
        ]
    }

    function isConnect() {
        console.log('[Btconnected] isConnect = ', connectState)
        return (connectState&0xf0) === 0x10 || (connectState&0xff) === 0x11
    }
}

