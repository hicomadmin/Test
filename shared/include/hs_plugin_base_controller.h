#ifndef HS_PLUGIN_BASE_CONTROLLER_H
#define HS_PLUGIN_BASE_CONTROLLER_H

#include "hs_data_center.h"
#include "hs_plugin_base_controller_global.h"


class HSPLUGINBASECONTROLLERSHARED_EXPORT HSPluginBaseController : public QObject
{
    Q_OBJECT

public:
    explicit HSPluginBaseController(QObject *parent = 0, QJsonObject *obj = 0);
    ~HSPluginBaseController(void);

    int HSGetPluginID(void);
    void HSSetDestination(const QString &dest);
    QString HSGetDestination(void) const;

    int HSRegisterPlugin(int pluginID, QObject *pluginSelf, QJsonObject *plugInfo);
    void HSDeregisterPlugin(int pluginID, QObject *pluginSelf);

    void HSAddAttrWatcher(int pluginID, const QString &attr, QObject *plugin);
    void HSDelAttrWatcher(int pluginID, const QString &attr, QObject *plugin);
    void HSClearAttrWatcher(int pluginID, const QString &attr);

    QJsonValue HSGetPluginData(const QString &attr) const;
    void HSRequestData(const QString &attr, const QJsonValue &value);
    void HSRequestData(int pluginID, const QString &dest, const QString &attr, const QJsonValue &value);

signals:
    void newRegisterPlugin(int HSPluginID,const QString &dest);
    void newDeregisterPlugin(int HSPluginID,const QString &dest);
    void notifyAttrChangedHook(int pluginID, const QString &name, const QJsonValue &value, HSType type);

public slots:
    QJsonValue getValue(const QString &attr) const;
    void setValue(const QString &attr, const QJsonValue &value);

private:
    int m_plugin_ID;
    QString m_destination;
    QJsonObject *m_object;
    HSHMIDataCenter *m_data_center;
};

#endif // HS_PLUGIN_BASE_CONTROLLER_H
