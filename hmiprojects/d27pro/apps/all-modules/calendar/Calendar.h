#ifndef CALENDAR_H
#define CALENDAR_H

#include <QObject>

class Calendar : public QObject
{
    Q_OBJECT



public:
    explicit Calendar(QObject *parent = 0);

signals:

public slots:

public:
    Q_INVOKABLE QString getLunarDate(int year, int month, int day);

private:
    static QString holiday(int month, int day);
    static QString lunarFestival(int month, int day);
};

#endif // CALENDAR_H
