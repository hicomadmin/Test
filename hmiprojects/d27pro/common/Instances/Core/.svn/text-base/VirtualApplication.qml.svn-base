import QtQuick 2.3
import Apps 1.0
import 'qrc:/UI/Core' as UCore
import TheXPresenter 1.0

HSApplication {
    id: root

    visible: false

    /* BEGIN by Zhang Yi, 2016.11.14
     * We can use 'application.appWindow' & 'application.statusBar' to access StatusBar.
    */
    property var statusBar: appWindow ? appWindow.statusBar : null
    /* END - by Zhang Yi, 2016.11.14 */

    readonly property var trySwitch: appWindow ? appWindow.trySwitch : (function(){})
    readonly property var hasSource: appWindow ? appWindow.hasSource : (function(){})

    property int lastAudioSource

    onItemAfterCreated: {
        console.debug("@@@@ onItemAfterCreated lastAudioSource <<<<", HmiCommon.source)
        lastAudioSource = HmiCommon.source
        appWindow.__pageChanged.connect(function handle() {
            console.debug("@@@@ __pageChanged lastAudioSource <<<<", HmiCommon.source)
            appWindow.__pageChanged.disconnect(handle)
            lastAudioSource = HmiCommon.source
        })
    }

    onItemShown: { focus = true; }
    onItemHiden: { focus = false; }

    // 更新显示相关的信息
    function updateDisplayInfo(id) {
        console.debug("VirtualApplication.updateDisplayInfo", id)

        var pageSettings = pages[id];
        var pageInfo = pageStack.findById(id);
        var appWindow = multiApplications.appWindow;

        if (pageSettings) {
            // 判断是否隐藏状态栏
            appWindow.hideStatusBar = !!pageSettings.hideStatusBar;
            appWindow.useStatusAnimation = !!pageSettings.useStatusAnimation;
            appWindow.supportFullScreen = !!pageSettings.supportFullScreen;

            // 更新状态栏标题，优先级：pageItem.title（页面实例title） > pageSetting.title（页面配置title） > application.title（应用title） > '状态栏'
            if (appWindow.statusBar)
                appWindow.statusBar.setTitle(
                            (pageInfo ? pageInfo.item.title : undefined) || multiApplications.appTitle || '状态栏');

            // 判断是否隐藏状态栏返回键
            if (appWindow.statusBar) appWindow.statusBar.hideBackBtn = !!pageSettings.hideBackBtn;

            // 重新设置应用大小
            if (pageInfo) {
//            pageInfo.item.width = xxx; // 目前没有涉及到有修改宽度的情况
                pageInfo.item.height = !pageSettings.showNavBar ? pageStack.height : pageStack.height - multiApplications.navBar.height;
            }
        }
    }

    function mainControl() {
        var main = multiApplications.getInfo('home')
        if (main) main = main.item
        return main
    }

    function createTipDialogAsync(url,properties, cb) {
        appWindow.createDialogAsync(url, properties, cb);
    }

    function createConfirmDialogAsync(url,properties, cb) {
        appWindow.createDialogAsync(url, properties, cb);
    }

    function createProgressDialogAsync(url,properties, cb) {
        appWindow.createDialogAsync(url, properties, cb);
    }
}
