#ifndef MODELATTRVALUE_H
#define MODELATTRVALUE_H
#include <QMap>
#include <QList>
#include <QObject>
#include <QJsonValue>

/* A attribute value */
class ModelAttrValue
{
public:
    ModelAttrValue(void);
    ~ModelAttrValue(void);

public:
    void set(const QJsonValue &value);
    QJsonValue get(void) const;
    void addWatcher(QObject *watcher);
    void delWatcher(QObject *watcher);
    void clearWatcherList(void);
    QList<QObject *> getWatcherList(void);

private:
    QJsonValue m_value;
    QList <QObject *> m_watchers;
};

#endif // MODELATTRVALUE_H
