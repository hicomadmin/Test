#include "HSPage.h"

HSPage::HSPage(void)
{
    connect(this, &HSControl::itemFirstShown, this, &HSPage::readyToShow, Qt::QueuedConnection);
}

const QVariant& HSPage::getApplication(void) const
{
    return m_applicationVar;
}

void HSPage::setApplication(const QVariant& app)
{
    if (m_applicationVar == app) return;
    m_applicationVar = app;
    emit applicationChanged();
}
