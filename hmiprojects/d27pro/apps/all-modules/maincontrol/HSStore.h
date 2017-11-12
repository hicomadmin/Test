#pragma once

#include <QObject>
#include <QJsonObject>
#include <QtQml>

class HSStore : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QJSValue    configs READ getConfigs WRITE setConfigs NOTIFY configsChanged)
    Q_PROPERTY(QJsonObject datas   READ getDatas   WRITE setDatas   NOTIFY datasChanged)

public:
    static HSStore* instance(void);

    explicit HSStore(QObject *parent = Q_NULLPTR);

    const QJsonObject& getDatas(void) const;
    void setDatas(const QJsonObject& var);
    Q_INVOKABLE void loadDatas(void);
    Q_INVOKABLE void setData(QString key, QJsonValue val);

    const QJSValue& getConfigs(void) const;
    void setConfigs(const QJSValue& var);
    Q_INVOKABLE void setConfig(QString key, QJSValue val);

signals:
    void configsChanged(void);
    void datasChanged(void);

private:
    QJSValue    m_settingsVar;
    QJsonObject m_datas;
};
