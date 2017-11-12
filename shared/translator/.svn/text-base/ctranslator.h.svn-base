#ifndef CTRANSLATOR_H
#define CTRANSLATOR_H
#include <QtQml>
#include <QQmlApplicationEngine>
#include <QList>

class TranslatorEnumDefiner : public QObject
{
    Q_OBJECT

public:
    enum EnTheme
    {
        ThemeNone   = 0,
        ThemeBlue   = 1,
        ThemeOrange = 2,
        ThemeGold   = 3
    };
    Q_ENUMS(EnTheme)
};

class CTranslator : public QTranslator
{
    Q_OBJECT

    /* This property is for dynamic translation in QML.
     * See: http://wiki.qt.io/How_to_do_dynamic_translation_in_QML
    */
    Q_PROPERTY(QString monitor READ getMonitorState NOTIFY monitorStateChanged)
    Q_PROPERTY(int theme READ theme WRITE setQmlTheme NOTIFY themeChanged)

private:
    CTranslator(QObject *parent = 0);

public:
    /* BEGIN by Zhang Yi, 2016.12.02
     * Add this for language switching logic.
    */
    QString getMonitorState(void) const;
    Q_INVOKABLE QString trans(QString context, QString sourceText) const;
    /* END - by Zhang Yi, 2016.12.02 */

    int theme(void) const;
    Q_INVOKABLE void setQmlTheme(int theme);

public slots:
    void load(QString appName, QString language, QStringList modules);
    void setRootContext(QQmlContext *rootContext);

signals:
    void languageChanged(QString language);
    void themeChanged(int theme);

    /* BEGIN by Zhang Yi, 2016.12.02
     * Add this for language switching logic.
    */
    void monitorStateChanged(void);
    /* END - by Zhang Yi, 2016.12.02 */

public:
    static CTranslator *instance();

private:
    QQmlContext *_rootContext;
    int m_theme;
};

#endif // CTRANSLATOR_H
