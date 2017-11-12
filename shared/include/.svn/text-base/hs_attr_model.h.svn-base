#ifndef HSATTRMODEL_H
#define HSATTRMODEL_H
#include <QHash>

#include "hs_attr_value.h"

class ModelAttribute
{
public:
    ModelAttribute(void);
    ~ModelAttribute(void);

public:
    void setAttr(const QString &attr,const QJsonValue &value);
    QJsonValue getAttr(const QString &attr) const;
    void clearAttr(void);

    void addPlugin(QObject *plugin);
    void delPlugin(QObject *plugin);
    void clearPluginList(void);
    QList<QObject *> getPluginList(void);

    void addWatcher(const QString &attr, QObject *plugin);
    void delWatcher(const QString &attr, QObject *plugin);
    void clearWatcherList(const QString &attr);
    QList<QObject *> getWatcherList(const QString &attr);

private:
    QList <QObject *> m_plugins;
    QHash <QString, ModelAttrValue> m_attr;
};

#endif // HSATTRMODEL_H
