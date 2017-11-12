#pragma once

#include "HSControl.h"

class HSPage : public HSControl
{
    Q_OBJECT

    Q_PROPERTY(QVariant application READ getApplication WRITE setApplication NOTIFY applicationChanged)

public:
    HSPage(void);

    const QVariant& getApplication(void) const;
    void setApplication(const QVariant& app);

signals:
    void applicationChanged(void);
    void readyToShow(void);

private:
    QVariant m_applicationVar;
};

QML_DECLARE_TYPE(HSPage)
