#include "ctranslator.h"
#include <QCoreApplication>
#define TIZEN_PLATFORM

CTranslator::CTranslator(QObject *parent)
    : QTranslator(parent)
    , m_theme(TranslatorEnumDefiner::ThemeNone)
{
    qmlRegisterType<TranslatorEnumDefiner>("Apps", 1, 0, "HSTranslator");
    /* BEGIN by Zhang Yi, 2016.12.02
     * Add this for language switching logic.
    */
    connect(this, SIGNAL(languageChanged(QString)), SIGNAL(monitorStateChanged()));
    /* END - by Zhang Yi, 2016.12.02 */
}

CTranslator *CTranslator::instance()
{
    static CTranslator *instance = 0;

    if (!instance)
    {
        instance = new CTranslator;
    }
    return instance;
}

/* BEGIN by Zhang Yi, 2016.12.02
 * Add this for language switching logic.
*/
QString CTranslator::getMonitorState(void) const
{
    return "";
}

QString CTranslator::trans(QString context, QString sourceText) const
{
    QByteArray c = context.toLocal8Bit(), s = sourceText.toLocal8Bit();
    QString tr = this->translate(c.data(), s.data());
    return tr;
}
/* END - by Zhang Yi, 2016.12.02 */

void CTranslator::load(QString appName, QString language, QStringList modules)
{
    QString directory;
    directory = QCoreApplication::applicationDirPath();

    #if defined(TIZEN_PLATFORM)
       directory = "/usr/app/apps/";
    #endif

    if (appName != NULL && language != NULL) {
        if (modules.empty()) {
            QTranslator::load(appName + "_" + language, directory);
        } else {
            for (int i = 0; i < modules.size(); ++i) {
                QTranslator::load(appName + "_" + language + "_" + modules.at(i), directory);
            }
        }

        if (_rootContext) {
            _rootContext->setContextProperty("_language", language);
        }

        emit languageChanged(language);
    }
}

void CTranslator::setRootContext(QQmlContext *rootContext)
{
    _rootContext = rootContext;
}

int CTranslator::theme(void) const
{
    return m_theme;
}

void CTranslator::setQmlTheme(int theme)
{
    qDebug("[CTranslator] setQmlTheme: %d", theme);
    if (m_theme == theme) return;
    m_theme = theme;
    emit themeChanged(theme);
}
