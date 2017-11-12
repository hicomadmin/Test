#include "baseappconfig.h"
#include <QList>

#ifdef UI_BINARY
    #include <QResource>
#endif

#ifdef USE_TRANSLATION

#define DEFAULT_LANGUAGE "zh_CN"

void installTranslator(QGuiApplication &app, QQmlApplicationEngine &engine, QString appName, QStringList modules)
{
    QQmlContext *rootContext = engine.rootContext();
    CTranslator *translator = CTranslator::instance();
    QString languageName;

    translator->setRootContext(rootContext);
    app.installTranslator(translator);
    rootContext->setContextProperty("ctranslator", translator);

    #ifdef DEFAULT_LANGUAGE
        languageName = DEFAULT_LANGUAGE;
     #else
        languageName = "en_US";
    #endif

    rootContext->setContextProperty("_language", languageName);
    translator->load(appName, languageName, modules);
}
#endif

#ifdef USE_DLT
void startDLT()
{
    DLT_REGISTER_APP("APME", APP_NAME);

    /* register all contexts */
    DLT_REGISTER_CONTEXT(APPQML,"QMLL","app QML Layer Context");
    DLT_REGISTER_CONTEXT(APPQTPLUGIN,"PLGI","app QTPLUGIN Layer Context");
    DLT_REGISTER_CONTEXT(APPIVOSAPI,"IAPI","app IVOSAPI Layer Context");
}

void endDLT()
{
    /* unregister all contexts */
    DLT_UNREGISTER_CONTEXT(APPQML);
    DLT_UNREGISTER_CONTEXT(APPQTPLUGIN);
    DLT_UNREGISTER_CONTEXT(APPIVOSAPI);

    /* unregister your application */
    DLT_UNREGISTER_APP();
}
#endif

#ifdef UI_BINARY
void loadBinaryUI()
{
    // 参数为目标板的rcc文件的存放路径，需要确保已放正确
    QResource::registerResource("/usr/local/qt5/rcc/UI.rcc");
}

void loadBinaryInstances()
{
    // 参数为目标板的rcc文件的存放路径，需要确保已放正确
    QResource::registerResource("/usr/local/qt5/rcc/Instances.rcc");
}
#endif
