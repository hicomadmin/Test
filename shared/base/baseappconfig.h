#include <QGuiApplication>
#include <QQmlApplicationEngine>

#ifdef USE_TRANSLATION
    #include "ctranslator.h"
#endif

#ifdef USE_DLT
    #include <dlt/dlt.h>
#endif

#ifdef USE_DLT
    DLT_DECLARE_CONTEXT(APPQML)
    DLT_DECLARE_CONTEXT(APPQTPLUGIN)
    DLT_DECLARE_CONTEXT(APPIVOSAPI)
#endif

#ifdef USE_TRANSLATION
    void installTranslator(QGuiApplication &app, QQmlApplicationEngine &engine, QString appName, QStringList modules);
#endif

#ifdef USE_DLT
    void startDLT();
    void endDLT();
#endif

#ifdef UI_BINARY
    void loadBinaryUI();
    void loadBinaryInstances();
#endif
