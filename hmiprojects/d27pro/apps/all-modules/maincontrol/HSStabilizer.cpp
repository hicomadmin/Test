#include "HSStabilizer.h"

#include <QTimer>

class HSStabUnit
{
    HSStabilizer* st_;
    const QString id_;
    QTimer tm_;
    bool status_, last_;

public:
    HSStabUnit(HSStabilizer* st, const QString& id, int tm)
        : st_(st)
        , id_(id)
        , status_(false)
        , last_(false)
    {
        tm_.setInterval(tm);
        tm_.setSingleShot(true);
        QObject::connect(&tm_, &QTimer::timeout, [this]
        {
            if (status_ != last_)
            {
                emit st_->dispatch(id_, last_ = status_);
                tm_.start();
            }
        });
    }

    void tryDispatch(bool status)
    {
        status_ = status;
        if (!tm_.isActive())
        {
            emit st_->dispatch(id_, last_ = status_);
        }
        tm_.start();
    }
};

HSStabilizer::HSStabilizer(QObject *parent)
    : QObject(parent)
{

}

HSStabilizer::~HSStabilizer(void)
{
    foreach (HSStabUnit* unit, m_table)
    {
        delete unit;
    }
    m_table.clear();
}

void HSStabilizer::receive(QString id, bool status, int tm)
{
    HSStabUnit*(& unit) = m_table[id];
    qDebug("#### [HSStabilizer] receive unit: %s - %p", id.toLocal8Bit().data(), unit);
    if (unit == Q_NULLPTR)
    {
        unit = new HSStabUnit(this, id, tm);
    }
    unit->tryDispatch(status);
}
