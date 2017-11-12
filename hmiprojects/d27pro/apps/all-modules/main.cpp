#include "baseappconfig.h"
#include "hs_plugin_base_controller.h"
#include "../all-modules/calendar/Calendar.h"

#include "maincontrol/HSApps.h"
#include "maincontrol/HSStore.h"
#include "maincontrol/HSPluginsManager.h"
#include "maincontrol/HSStabilizer.h"
#include "maincontrol/HSStackContainer.h"
#include "maincontrol/HSElementContainer.h"
#include "maincontrol/HSControl.h"
#include "maincontrol/HSMultiApplications.h"
#include "maincontrol/HSApplication.h"
#include "maincontrol/HSPage.h"
#include "maincontrol/HSTab.h"

#include "debuglog.h"
#include "signallog.h"

#include <QTextCodec>

#define DEFAULT_LANGUAGE "zh_CN"

#ifndef QMLPLUGINS_PATH
#define QMLPLUGINS_PATH
#endif

int main(int argc, char *argv[])
{
    HSPluginBaseController basecontroller;  // init empty plug-in
//    setenv("QT_QPA_PLATFORM","wayland",1);
//    setenv("QT_WAYLAND_DISABLE_WINDOWDECORATION","1",1);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    HSApps::instance()->registQmlEngine(&engine);
    qInstallMessageHandler(hsDebugOutput);
    register_system_signal();

    // 设置字符编码
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));
    /* BEGIN by Li Peng, 2016.11.18
     * fix #678 the dispaly of week,sunday put first
    */
    QLocale::setDefault(QLocale(QLocale::English, QLocale::UnitedStates));
    /* END by Li Peng*/

    engine.rootContext()->setContextProperty("HSApps" , HSApps::instance());
    engine.rootContext()->setContextProperty("HSStore", HSStore::instance());
    HSPluginsManager pluginsManager;
    engine.rootContext()->setContextProperty("HSPluginsManager", &pluginsManager);
    HSStabilizer stabilizer;
    engine.rootContext()->setContextProperty("HSStabilizer", &stabilizer);

    qmlRegisterType<HSStackContainer   >("Apps", 1, 0, "HSStackContainer");
    qmlRegisterType<HSElementContainer >("Apps", 1, 0, "HSElementContainer");
    qmlRegisterType<HSControl          >("Apps", 1, 0, "HSControl");
    qmlRegisterType<HSPage             >("Apps", 1, 0, "HSPage");
    qmlRegisterType<HSTab              >("Apps", 1, 0, "HSTab");
    qmlRegisterType<HSApplication      >("Apps", 1, 0, "HSApplication");
    qmlRegisterType<HSMultiApplications>("Apps", 1, 0, "HSMultiApplications");
    qmlRegisterType<Calendar           >("Apps", 1, 0, "CalendarCtl");

#ifdef QMLPLUGINS_PATH
    //engine.addImportPath("/usr/app/qmlplugins/");
    engine.addImportPath(app.applicationDirPath() +"/../qmlplugins/");
//    engine.addImportPath(app.applicationDirPath() +"/../qmlplugins/PC/");

#endif
#ifdef USE_DLT
    // 开始注册DLT功能
    startDLT();
#endif

#ifdef USE_TRANSLATION
    // 安装翻译工具
    QStringList empty;
    installTranslator(app, engine, "d27", empty);
#endif

#ifdef UI_BINARY
    // 加载UI/Instances模块rcc文件
    loadBinaryUI();
    loadBinaryInstances();
#endif

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    app.exec();

#ifdef USE_DLT
    // 开始注销DLT功能
    endDLT();
#endif

    return 0;
}
