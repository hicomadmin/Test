#include "HSControl.h"
#include "HSContainer.h"

HSControl::HSControl(void)
{
    setVisible(false);

    connect(this, &HSControl::itemReadyShow, [this]{ setVisible(true ); });
    connect(this, &HSControl::itemHiden    , [this]{ setVisible(false); });
}

const QString& HSControl::getName(void) const
{
    return m_name;
}

void HSControl::setName(const QString& str)
{
    if (m_name == str) return;
    m_name = str;
    emit nameChanged();
}

const QString& HSControl::getTitle(void) const
{
    return m_title;
}

void HSControl::setTitle(const QString& str)
{
    if (m_title == str) return;
    m_title = str;
    emit titleChanged();
}

void __dispatch(QQuickItem* item, HSDispatchable::SignalId signal)
{
    Q_ASSERT(item != Q_NULLPTR);
    foreach (auto child, item->childItems())
    {
        HSDispatchable* d = dynamic_cast<HSDispatchable*>(child);
        if (d != Q_NULLPTR)
        {
            d->dispatch(signal);
        }
        else __dispatch(child, signal);
    }
}

void HSControl::dispatch(SignalId signal)
{
    emit (this->*signal)();
    __dispatch(this, signal);
}
