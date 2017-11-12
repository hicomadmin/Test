#pragma once

#include <QObject>
#include <QHash>

class HSStabUnit;
class HSStabilizer : public QObject
{
    Q_OBJECT

public:
    explicit HSStabilizer(QObject *parent = Q_NULLPTR);
    ~HSStabilizer(void);

signals:
    void dispatch(QString id, bool status);

public slots:
    void receive(QString id, bool status, int tm);

private:
    QHash<QString, HSStabUnit*> m_table;
};
