#ifndef HSHMIDATACENTER_H
#define HSHMIDATACENTER_H
#include <QObject>

#include "hs_socket_app.h"
#include "hs_attr_model.h"

enum HSType {
    HSNull      = 0x00,
    HSBool      = 0x01,
    HSDouble    = 0x02,
    HSString    = 0x03,
    HSArray     = 0x04,
    HSObject    = 0x05,
    HSUndefined = 0x80,
    HSJsonValue = 0x90,
    HSInt       = 0x99,
};

#define HSSOCKETHMIMODULENAME           "HMIAPP"
#define HSSOCKETMODULECONFIGPATH        "HSSOCKETMODULEPATH"
#define HSSOCKETMODULECONFIGPATHDEF     "/usr/app/conf/socket_module_conf.ini"

#define NEW_REGISTER_SIGNAL      "newRegisterPlugin"
#define NEW_DEREGISTER_SIGNAL    "newDeregisterPlugin"
#define NOTIFY_ATTR_CHANGED_HOOK "notifyAttrChangedHook"

class HSHMIDataCenter : public QObject
{
    Q_OBJECT

private: // not allow new a HSHMIDataCenter object
    explicit HSHMIDataCenter(QObject *parent = 0);
    ~HSHMIDataCenter(void);

public:  // the interface offered to plug-ins
    static HSHMIDataCenter *getInstence(void);

    // register plugin -> plugin-list
    int registerPlugin(int pluginID, QObject *pluginSelf, QJsonObject *plugInfo);
    void deregisterPlugin(int pluginID, QObject *pluginSelf);
    void clearPlugin(int pluginID);

    void informNewPluginRegister(int pluginID, QObject *pluginSelf, const QString &dest);
    void informNewPluginDeregister(int pluginID, QObject *pluginSelf, const QString &dest);

    // watcher plugin -> watcher-list
    void addAttrWatcher(int pluginID, const QString &attr, QObject *plugin);
    void delAttrWatcher(int pluginID, const QString &attr, QObject *plugin);
    void clearAttrWatcher(int pluginID, const QString &attr);

    QJsonValue getAttr(int pluginID, const QString &attr) const;
    void setAttr(int pluginID, const QString &attr, const QJsonValue &value = QJsonValue(QJsonValue::Undefined));
    void requestService(const QString &dest, const QJsonObject &obj);

//signals: // the signals offered to plug-in
    //void newRegisterPlugin(int HSPluginID, const QString &dest);
    //void notifyAttrChangedHook(int pluginID, const QString &name, const QJsonValue &value, HSType type);

public:  // the interface offered to data-center module, emit a HSDistributeSignal signal
    void distributeEmit(QJsonObject *object);

private: // the interface offered to data-center module self
    void distributeDataToHMI(QObject *plugin, const QString &attr, const QJsonValue &value);
    void distributeDataToPlugin(int pluginID, const QString &name, const QJsonValue &value);

signals: // the signal offered to data-center module self
    void distributeSignal(QJsonObject *object);

private slots: // the slots connected to HSDistributeSignal
    void distributeData(QJsonObject *object);

private:
    void distributeDataPluginID(int id, QJsonObject *object);
    void distributeDataBusinessID(int id, QJsonObject *object);

private:
    static HSSocket *m_socket;  // socket module
    QList <QObject *> m_objects; // all objects HMI used
    QHash <int, ModelAttribute> m_plugins; // all plugins HMI used
    static HSHMIDataCenter *m_hmi_data_center;
};


#endif // HSHMIDATACENTER_H
