#include "HSTab.h"

HSTab::HSTab(void)
{

}

const QVariant& HSTab::getTabview(void) const
{
    return m_tabviewVar;
}

void HSTab::setTabview(const QVariant& var)
{
    if (m_tabviewVar == var) return;
    m_tabviewVar = var;
    emit tabviewChanged();
}
