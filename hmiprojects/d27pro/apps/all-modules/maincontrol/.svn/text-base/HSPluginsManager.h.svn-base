#pragma once

#include <QObject>
#include <QVariant>
#include <QHash>
#include <QString>
#include <QtQml>

class HSPluginsManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariant pluginsCreators READ getPluginsCreators WRITE setPluginsCreators NOTIFY pluginsCreatorsChanged)
    Q_PROPERTY(QVariant pluginsSequence READ getPluginsSequence WRITE setPluginsSequence NOTIFY pluginsSequenceChanged)

public:
    explicit HSPluginsManager(QObject *parent = Q_NULLPTR);

    const QVariant& getPluginsCreators(void) const;
    void setPluginsCreators(const QVariant& var);

    const QVariant& getPluginsSequence(void) const;
    void setPluginsSequence(const QVariant& var);

    Q_INVOKABLE QObject* get(const QString& name);
    Q_INVOKABLE void foreachPlugin(QJSValue cb);

signals:
    void pluginsCreatorsChanged(void);
    void pluginsSequenceChanged(void);

private slots:
    void onPluginsSequenceChanged(void);

private:
    QObject* __createPlugin(const QString& name, const QJSValue& creator);

private:
    QVariant m_pluginsCreatorsVar;
    QHash<QString, QJSValue> m_pluginsCreators;
    QVariant m_pluginsSequenceVar;

    QHash<QString, QObject*> m_plugins;
};

QML_DECLARE_TYPE(HSPluginsManager)
