#pragma once

#include "HSPage.h"

class HSTab : public HSPage
{
    Q_OBJECT

    Q_PROPERTY(QVariant tabview READ getTabview WRITE setTabview NOTIFY tabviewChanged)

public:
    HSTab(void);

    const QVariant& getTabview(void) const;
    void setTabview(const QVariant& var);

signals:
    void tabviewChanged(void);

private:
    QVariant m_tabviewVar;
};

QML_DECLARE_TYPE(HSTab)
